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
      add_values_in_options(@person)
      bool = false
      @person.test.questions.each {|question| bool = true if question.options.count > 0}
      flash[:notice] = "Note - all option values for #{@person.name} preset to 0" if bool
      
      redirect_to people_new_path test_id: params[:test_id]
    else
      flash[:alert] = @person.errors.full_messages
      redirect_to people_new_path test_id: params[:test_id]
    end
  end
  
  def destroy
    @person = Person.find(params[:id])
    people = @person.test.people.all
    update_values_indices(@person.values_index, people)
    delete_values_in_options(@person, @person.values_index)
    @person.destroy
    redirect_to people_new_path test_id: params[:test_id]
  end
  
  def update_values_indices(deleted_index, people)
    people.all.each do |person|
      person.update_attributes(values_index: person.values_index - 1) if person.values_index > deleted_index
    end
  end
  
  def delete_values_in_options(person, deleted_index)
    person.test.questions.each do |question|
      next if question.isDup
      question.options.each do |option|
        option.update_attributes(values: option.values.tap {|x| x.delete_at(deleted_index)})
      end
    end
  end
  
  def add_values_in_options(person)
    person.test.questions.each do |question|
      next if question.isDup
      question.options.each do |option|
        option.update_attributes(values: option.values.push(0))
      end
    end
  end
  
  def 
  
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
