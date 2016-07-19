class Person < ApplicationRecord
    belongs_to :test
    before_create :init
    has_attached_file :avatar, styles: { medium: "300x300>", thumb: "50x50>" }#, default_url: "/images/:style/missing.png"
    
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
    validates :name, presence: true, uniqueness: {scope: :test, case_sensetive: false}
    
    def init
       
       self.score ||= 0
       self.values_index = self.test.people.count
        
    end
end
