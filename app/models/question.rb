class Question < ApplicationRecord
    
    belongs_to :test
    belongs_to :survey, optional: true
    belongs_to :question, foreign_key: :cloner_id, optional: true
    has_many :options, foreign_key: :parent_question, dependent: :destroy
    
    validate :unique_prompt
    
    before_create :init
    
    def init
        self.survey_id ? self.question_number = self.survey.questions.count : self.question_number = self.test.questions.count
    end
    
    private

    def unique_prompt
        errors.add(:prompt, 'cannot be empty') if prompt.blank?
        if not self.survey_id 
            errors.add(:prompt, 'already used') if self.test.questions.pluck(:prompt).include?(self.prompt)
        end
        
    end
end
