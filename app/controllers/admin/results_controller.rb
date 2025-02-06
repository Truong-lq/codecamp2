class Admin::ResultsController < Admin::AdminController
  def index
    @test = Test.find_by params[:test_id]
    redirect_to root_path, alert: "Test not found" if @test.nil?

    @results = @test.results.group(
      "CASE 
        WHEN point BETWEEN 7 AND 10 THEN 'good' 
        WHEN point BETWEEN 5 AND 7 THEN 'average'
        ELSE 'bad' 
      END"
    ).count
  end
end
