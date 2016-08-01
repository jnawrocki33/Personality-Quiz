class QuestionsController < ApplicationController
  
  before_filter :set_cache_buster
  def new
    @test = Test.find(params[:test_id])
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    @question.test_id = params[:test_id]
    if @question.save
      redirect_to questions_new_path test_id: params[:test_id]
    else
      flash[:alert] = @question.errors.full_messages
      redirect_to questions_new_path test_id: params[:test_id]
    end
  end
  
  def show
    @question = Question.find(params[:id])
  end
  
  
  def update
    @question = Question.find(params[:id])
    @question.update_attributes(:answer => params[:option_id].to_i)
    redirect_to survey_path(id:@question.survey.id, question_number:@question.question_number)
  end
  
  def index
    @test = Test.find(params[:test_id])
    expires_in(1, public: true)
  end
  
  def destroy
    @question = Question.find(params[:id])
    @questions = @question.test.questions.all
    update_question_numbers(@question.question_number, @questions)
    @question.destroy
    redirect_to questions_new_path test_id: params[:test_id]
  end
  
  def update_question_numbers(deleted_index, questions)
    questions.all.each do |question|
      next if question.isDup
      question.update_attributes(question_number: question.question_number - 1) if question.question_number > deleted_index
    end
  end
  
  private

    def question_params
      params.require(:question).permit(:prompt, :test_id)
    end
  
end
