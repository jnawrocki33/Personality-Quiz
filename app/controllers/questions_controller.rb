class QuestionsController < ApplicationController
  
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
  end
  
  private

    def question_params
      params.require(:question).permit(:prompt, :test_id)
    end
  
end
