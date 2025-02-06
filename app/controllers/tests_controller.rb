class TestsController < ApplicationController
  before_action :load_test
  before_action :authenticate_user!, only: :do
  before_action :load_question, only: :do

  def show; end

  def do; end

  def submit
    result = test_service.create_result params[:data]

    ActiveRecord::Base.transaction do
      result.save!

      current_user.answers << test_service.create_user_answers(params[:data], result) unless params[:data].blank?

      render json: { msg: "Test completed!", result_id: result.id }, status: :ok
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
    render json: { msg: "Can not save the test. Please try again!" }, status: :unprocessable_entity
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
