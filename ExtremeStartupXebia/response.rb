require_relative 'extreme_startup_xebia'

if ARGV[0] == 'FeetToMetersQuestion'
  feet_to_meters_question = ExtremeStartup::FeetToMetersQuestion.new(Integer(ARGV[1]))
  exit(feet_to_meters_question.answered_correctly?(Float(ARGV[2])) ? 0 : 1)
end

exit(1)
