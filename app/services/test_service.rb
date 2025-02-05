class TestService
  def initialize(test, user)
    @test = test
    @user = user
  end

  def calculate_result(data)
    result = Result.new point: 0, test: @test, user: @user
    question_ids = data.keys

    question_ids.each do |question_id|
      answer = Answer.find_by question_id: question_id, id: data[question_id]

      next if answer.nil? || !answer.is_correct?

      result.point += 1
    end

    result.point = result.point / @test.questions.size.to_f * 10
    
    result
  end
end