class Option < ApplicationRecord
    serialize :values, Array
    
    validates :text, presence: true, uniqueness: {scope: :parent_question, case_sensetive: false}
    belongs_to :question, foreign_key: :parent_question
end
