class OptionsController < ApplicationController
  def new
    @test = Test.find(params[:test_id])
    @question = Question.find(params[:parent_question]) if params[:parent_question]
    @option = Option.new
  end
  
  def create
    @option = Option.new(option_params)
    @option.parent_question = params[:parent_question]
    @option.values = params[:option][:values].map {|x| x.to_i}
    if @option.save
      redirect_to options_new_path parent_question: params[:parent_question], test_id: params[:test_id]
    else
      flash[:alert] = @option.errors.full_messages
      redirect_to options_new_path parent_question: params[:parent_question], test_id: params[:test_id]
    end
  end
  
  private

    def option_params
      params.require(:option).permit(:text, :test_id, :parent_question, :values)
    end
end
