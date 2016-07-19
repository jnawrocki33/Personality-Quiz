class SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end
  
  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      Test.find(@survey.test_id).questions.each do |question|
        next if question.isDup
        newQ = question.dup
        newQ.survey_id = @survey.id
        newQ.save
        newQ.update_attributes(isDup: true)
        newQ.update_attributes(cloner_id: question.id)
      end
      redirect_to action: "show", id: @survey.id
    else
      redirect_to root_path
      
    end
  end
  
  
  def show
    @survey = Survey.find(params[:id])    
    @questions = @survey.questions
    
    prev_question_index = params[:question_number] ? params[:question_number].to_i : -1
    question_index = prev_question_index += 1
    
    if question_index >= @questions.size
      redirect_to :action => :results, id: @survey.id
    else
      @question = @questions[question_index]
      redirect_to @question
    end
    
    
    
    # q_index = @survey.question_index
    # @survey.update_attributes(question_index: q_index += 1)
    
    # if @survey.question_index >= @questions.size
    #   redirect_to :action => :results, id: @survey.id
    # else
    #   @question = @questions[@survey.question_index]
    #   redirect_to @question
    # end
  end
  
  
  
  def index
  end
  
  
  def results
    @survey = Survey.find(params[:id])
    @questions = @survey.questions
    @data = Array.new(@survey.test.people.count, 0) #replace 3 with @survey.test.people.count
    @questions.each do |question|
      option = Option.find(question.answer)
      option.values.each_with_index do |value, index|
        next if value == nil
        @data[index] = @data[index] + value
      end
    end
    
    @labels = []
    @survey.test.people.all.sort_by(&:values_index).each do |person|
      @labels.push(person.name)
    end
    
    
    Gchart.pie_3d(:title => 'Personality Scores', 
    :theme => :custom_theme,
    :labels => @labels,
    data: @data,
    :size => '400x200',
    :format => 'file',
    :filename => 'app/assets/images/test.png')
    
    max_index = @data.index(@data.max)
    @winner = @survey.test.people.all.find_by(values_index: max_index)
    #@survey.destroy
  end
  
  private

    def survey_params
      params.permit(:test_id, :question_index)
    end
  
end
