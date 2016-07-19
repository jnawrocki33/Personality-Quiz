class AddSurveyIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :survey_id, :integer
  end
end
