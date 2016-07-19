class Survey < ApplicationRecord
    
    has_many :questions, foreign_key: :survey_id, dependent: :destroy
    belongs_to :test
    
end
