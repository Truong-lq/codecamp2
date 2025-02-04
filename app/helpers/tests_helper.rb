module TestsHelper
  def back_url
    do_test_path @test, question: first_idx? ? current_idx : prev_idx
  end

  def next_url
    do_test_path @test, question: last_idx? ? current_idx : next_idx
  end

  def last_idx?
    @question_idx + 1 == @test.questions.size
  end

  private

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