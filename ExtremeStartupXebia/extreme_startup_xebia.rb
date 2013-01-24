module ExtremeStartup

  class Question
    def answered_correctly?(answer)
      correct_answer.to_s.downcase.strip == answer
    end
  end

  class UnaryMathsQuestion < Question
    def initialize(number = rand(20))
      @n1 = number
    end
  end

  class FeetToMetersQuestion < UnaryMathsQuestion
    RATIO=0.3048

    def as_text
      n = @n1 + 1
      "how+much+is+#{n}+feet+in+meters"
    end

    def n1
      @n1
    end

    def answered_correctly?(answer)
      (answer.to_f - correct_answer.to_f).abs < 0.01
    end

    def correct_answer
      '%.2f' % ((@n1 + 1) * RATIO)
    end
  end

end
