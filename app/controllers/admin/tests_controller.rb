class Admin::TestsController < Admin::AdminController
  load_and_authorize_resource

  def new
    @test = Test.new
    @question = @test.questions.build
    3.times { @question.answers.build }
  end

  def create
    @test = Test.new test_params

    if @test.save
      redirect_to edit_admin_test_path(@test), notice: "Create test successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @test_template = Test.new
    question = @test_template.questions.build
    3.times { question.answers.build }
  end

  def update
    if @test.update(test_params)
      redirect_to edit_admin_test_path(@test), notice: "Update test successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @test.destroy
      redirect_to root_path, notice: "Delete test successfully"
    else
      redirect_to root_path, alert: "Test is not existed"
    end
  end

  private

  def test_params
    params.require(:test).permit(
      :title,
      :description,
      questions_attributes: [
        :id,
        :content,
        answers_attributes: [:id, :content, :is_correct, :_destroy],
      ],
    ).tap do |permit_params|
      permit_params[:questions_attributes]&.each do |_id, question|
        question[:answers_attributes]&.each do |_id, answer|
          answer[:is_correct] ||= false
        end
      end
    end
  end
end
