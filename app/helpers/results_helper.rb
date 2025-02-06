module ResultsHelper
  def resolve_label_class(current_answer)
    return "text-success" if current_answer == @correct_answer

    return "text-danger" if current_answer == @user_answer && current_answer != @correct_answer
  end

  def result_back_url
    test_result_path @test, @result, question: first_idx? ? current_idx : prev_idx
  end

  def result_next_url
    test_result_path @test, @result, question: last_idx? ? current_idx : next_idx
  end

  
  private
  
  def last_idx?
    @question_idx + 1 == @test.questions.size
  end
  
  def first_idx?
    @question_idx == 0
  end

  def current_idx
    @question_idx + 1
  end

  def prev_idx
    @question_idx
  end

  def next_idx
    @question_idx + 2
  end
end
