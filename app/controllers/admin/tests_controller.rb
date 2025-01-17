class Admin::TestsController < ApplicationController
  def show
  end

  def new
    @test = Test.new
    @question = @test.questions.build
    3.times { @question.answers.build }
  end

  def create
    @test = Test.new test_params
    
    if @test.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def test_params
    params.require(:test).permit(
      :title,
      :description,
      questions_attributes: [
        :content,
        answers_attributes: [:content, :is_correct],
      ],
    )
  end
end
