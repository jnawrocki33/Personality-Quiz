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
  
  def javascript_practice
  end
  
  def destroy
    @option = Option.find(params[:id])
    @option.destroy
    if params[:from_index]
      redirect_to questions_index_path test_id: params[:test_id]
    else
      redirect_to options_new_path parent_question: params[:parent_question], test_id: params[:test_id]
    end
  end
  
  def edit
    @test = Test.find(params[:test_id])
    @question = Question.find(params[:parent_question]) if params[:parent_question]
    @option = Option.find(params[:id])
  end
  
  def update
    @option = Option.find(params[:id])
    @option.update_attributes(text: params[:option][:text])
    @option.update_attributes(values: params[:option][:values].map {|x| x.to_i})
    if not @option.errors.full_messages.empty?
      flash[:alert] = @option.errors.full_messages
      redirect_to edit_option_path(id: @option.id, parent_question: params[:parent_question], test_id: params[:test_id])
    else
      redirect_to options_new_path parent_question: params[:parent_question], test_id: params[:test_id]
    end
  end
  
  
  private

    def option_params
      params.require(:option).permit(:text, :test_id, :parent_question, :values)
    end
end
