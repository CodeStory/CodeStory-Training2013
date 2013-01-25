require_relative 'extreme_startup_xebia'

if ARGV[0] == 'FeetToMetersQuestion'
  feet_to_meters_question = ExtremeStartup::FeetToMetersQuestion.new(Integer(ARGV[1]))
  puts(feet_to_meters_question.as_text)
elsif ARGV[0] == 'PiQuestion'
  pi_question = ExtremeStartup::PiQuestion.new(Integer(ARGV[1]))
  puts(pi_question.as_text)
elsif ARGV[0] == 'GeneralKnowledgeQuestion'
  general_knowledge_question = ExtremeStartup::GeneralKnowledgeQuestion.new(Integer(ARGV[1]))
  puts(general_knowledge_question.as_text)
end
