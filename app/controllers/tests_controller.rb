class TestsController < ApplicationController
  before_action :authenticate_user!, only: :do
  before_action :load_test

  def show
  end

  def do
  end

  private

  def load_test
    @test = Test.find_by id: params[:id]
  end
end
