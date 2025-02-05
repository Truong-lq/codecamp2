class TestsController < ApplicationController
  before_action :load_test
  before_action :authenticate_user!, only: :do
  before_action :load_question, only: :do

  def show; end

  def do; end

  def submit
    result = test_service.calculate_result params[:data]

    if result.save
      render json: { msg: "Test completed!" }, notice: "Test completed!"
    else
      render json: { msg: "Can not save the test. Please try again!" }
    end
  end

  def show_results
    @results = current_user.results.order created_at: :desc
  end

  private

  def load_test
    @test = Test.find_by id: params[:id]

    redirect_to root_path, alert: "Test not found" if @test.nil?
  end

  def load_question
    @question_idx = params[:question] ? params[:question].to_i - 1 : 0
    @question = @test.questions[@question_idx]

    redirect_to do_test_path(@test), alert: "Question not found" if @question.nil?
  end

  def test_service
    @test_service ||= TestService.new @test, current_user
  end
end
