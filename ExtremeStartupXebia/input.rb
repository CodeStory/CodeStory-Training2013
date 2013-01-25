require_relative 'extreme_startup_xebia'

if ARGV[0] == 'FeetToMetersQuestion'
  feet_to_meters_question = ExtremeStartup::FeetToMetersQuestion.new()
  puts(feet_to_meters_question.n1)
elsif ARGV[0] == 'PiQuestion'
  pi_question = ExtremeStartup::PiQuestion.new()
  puts(pi_question.n1)
elsif ARGV[0] == 'GeneralKnowledgeQuestion'
  general_knowledge_question = ExtremeStartup::GeneralKnowledgeQuestion.new()
  puts(general_knowledge_question.n1)
end
