class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_test
  before_action :load_result
  before_action :load_question

  def index
    @results = Result.by_test_user @test, current_user
  end

  def show
    @user_answer = UserAnswer.find_by(user: current_user,
                                      test: @test,
                                      result: @result,
                                      question: @question)&.answer
    @correct_answer = Answer.find_by question: @question, is_correct: true
  end

  private

  def load_test
    @test = Test.find_by id: params[:test_id]

    redirect_to root_path, alert: "Test not found" if @test.nil?
  end

  def load_result
    @result = Result.find_by test: @test, id: params[:id]
  end

  def load_question
    @question_idx = params[:question] ? params[:question].to_i - 1 : 0
    @question = @test.questions[@question_idx]

    redirect_to test_result_path(@test, @result), alert: "Question not found" if @question.nil?
  end
end
