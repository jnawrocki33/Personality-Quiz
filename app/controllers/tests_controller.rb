class TestsController < ApplicationController
  
  #before_action :authenticate_user!
  
  def new
    @test = Test.new
    # @test.save
    # redirect_to @test
  end
  
  
  def create
    @test = current_user.tests.new(test_params)
    # @test.update_attributes(test_name: params[:test][:test_name])
    if @test.save
      redirect_to @test
    else
      flash[:alert] = @test.errors.full_messages
      redirect_to tests_new_path
    end
  end
  def add_name
    @test = Test.find(params[:id])
    @test.update_attributes(test_name: params[:test][:test_name])
    byebug
    redirect_to @test
  end

  def index
    @survey = Survey.new question_index: 0
  end
  
  def destroy
    @test = Test.find(params[:id])
    @test.destroy
    redirect_to root_path
  end
  
  
  def show
    @survey = Survey.new question_index: 0
    @test = Test.find(params[:id])
    # @test = Test.find(params[:test_id])
    # @questions = @test.questions
    
    # if params[:question_index]
    #   q_index = params[:question_index].to_i
    #   @test.update_attributes(question_index: q_index)
    # else
    #   q_index = @test.question_index
    #   @test.update_attributes(question_index: q_index += 1)
    # end
    
    # if @test.question_index >= @questions.size
    #   redirect_to :action => :results, id: @test.id
    # else
    #   @question = @questions[@test.question_index]
    #   redirect_to @question
    # end
  end
  
  def results
    @test = Test.find(params[:id])
    @questions = @test.questions
    @data = Array.new(@test.people.count, 0)
    @questions.each do |question|
      option = Option.find(question.answer)
      option.values.each_with_index do |value, index|
        next if value == nil
        @data[index] = @data[index] + value
      end
    end
    
    @labels = []
    @test.people.all.sort_by(&:values_index).each do |person|
      @labels.push(person.name)
    end
    
    #Chart::Theme.add_theme_file("app/assets/custom_theme.yml")
    
    Gchart.pie_3d(:title => 'Personality Scores', 
    :theme => :custom_theme,
    :labels => @labels,
    data: @data,
    :size => '400x200',
    :format => 'file',
    :filename => 'app/assets/images/test.png')
    
    max_index = @data.index(@data.max)
    @winner = @test.people.all.find_by(values_index: max_index)
  end
  
  private

    def test_params
      params.require(:test).permit(:test_name)
    end
end
