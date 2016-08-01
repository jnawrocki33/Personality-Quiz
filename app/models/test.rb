class Test < ApplicationRecord
    
    has_many :questions, foreign_key: :test_id, dependent: :destroy
    has_many :people, foreign_key: :test_id, dependent: :destroy
    belongs_to :user, optional: true

    validates :test_name, presence: true, uniqueness: {case_sensetive: false}
    
    def options_count
        count = 0
        self.questions.each do |question| 
            count += question.options.count
        end
        return count
    end
end
