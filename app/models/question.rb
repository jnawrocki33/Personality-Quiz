class Question < ApplicationRecord
    
    belongs_to :test
    belongs_to :survey, optional: true
    belongs_to :question, foreign_key: :cloner_id, optional: true
    has_many :options, foreign_key: :parent_question, dependent: :destroy
    
    validates :prompt, presence: true, uniqueness: {:scope => [:test, :survey_id], case_sensetive: false}, if: '!self.survey_id'
    
    before_create :init
    
    def init
        self.survey_id ? self.question_number = self.survey.questions.count : self.question_number = self.test.questions.count
    end

end
