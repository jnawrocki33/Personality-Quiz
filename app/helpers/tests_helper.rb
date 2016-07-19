module TestsHelper
    
    def has_complete_questions? test
        test.questions.each do |question|
            next if question.isDup
            return false if question.options.count == 0
        end
        return true
    end
end
