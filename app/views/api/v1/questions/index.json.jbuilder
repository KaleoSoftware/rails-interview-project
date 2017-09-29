json.questions @questions do |question|
  json.id question.id
  json.question question.title
  json.answers question.answers do |answer|
    json.body answer.body
    json.user answer.user.name
  end


end
