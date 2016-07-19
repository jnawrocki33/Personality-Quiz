class PeopleController < ApplicationController
  def new
    @tests = []
    Test.all.each do |test|
      @tests.push([test.test_name, test.id])
    end
    @person = Person.new
    @test = Test.find(params[:test_id])
  end
  
  def create
    @person = Person.new(person_params)
    @person.test_id = params[:test_id]
    if @person.save
      redirect_to people_new_path test_id: params[:test_id]
    else
      flash[:alert] = @person.errors.full_messages
      redirect_to people_new_path test_id: params[:test_id]
    end
  end
  
  def show
    @person = Person.find(params[:id])
  end
  
  def index
    
    #@test = Test.find(params[:test_id])
    @people = []
    Person.all.order(:name).each do |person|
      @people.push(person)
    end
    
  end

  private

    def person_params
      params.require(:person).permit(:name, :bio, :test_id, :image_path, :avatar)
    end
end
