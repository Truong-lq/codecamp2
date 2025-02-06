class TestService
  def initialize(test, user)
    @test = test
    @user = user
  end

  def create_result(data)
    result = @user.results.build point: 0, test: @test
    question_ids = data.keys

    question_ids.each do |question_id|
      answer = Answer.find_by question_id: question_id, id: data[question_id]

      next if answer.nil? || !answer.is_correct?

      result.point += 1
    end

    result.point = result.point / @test.questions.size.to_f * 10

    result
  end

  def create_user_answers(data, result)
    question_ids = data.keys
    user_answers = []

    question_ids.each do |question_id|
      answer = Answer.find_by question_id: question_id, id: data[question_id]

      next if answer.nil?

      user_answer = @user.answers.build test: @test,
                                        answer: answer,
                                        question_id: question_id,
                                        result: result

      user_answers << user_answer
    end

    user_answers
  end
end
