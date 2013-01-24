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

    def n1
      @n1
    end
  end

  class FeetToMetersQuestion < UnaryMathsQuestion
    RATIO=0.3048

    def as_text
      n = @n1 + 1
      "how+much+is+#{n}+feet+in+meters"
    end

    def answered_correctly?(answer)
      (answer.to_f - correct_answer.to_f).abs < 0.01
    end

    def correct_answer
      '%.2f' % ((@n1 + 1) * RATIO)
    end
  end

  class PiQuestion < UnaryMathsQuestion
    def as_text
      n = @n1 + 1
      "what+is+the+#{n}" + th(n) + "+decimal+of+Pi"
    end

    def correct_answer
      "14159265358979323846"[@n1]
    end

    private

    def th(n)
      if n % 10 == 1
        return "st"
      end
      if n % 10 == 2
        return "nd"
      end
      if n % 10 == 3
        return "rd"
      end
      "th"
    end
  end

end
