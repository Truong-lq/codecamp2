class HomeController < ApplicationController
  def index
    @tests = Test.all
  end
end
