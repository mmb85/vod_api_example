require "rails_helper"

RSpec.describe CreateMoviesJsonCacheJob, :type => :job do
  describe "#perform_later" do
    let!(:movie) { create :movie }
    
    it "Job is queued" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        CreateMoviesJsonCacheJob.perform_later
      }.to have_enqueued_job
    end

    it "Cache was creted properly" do
      ActiveJob::Base.queue_adapter = :test
      expect { CreateMoviesJsonCacheJob.perform_now }.not_to raise_error
    end
  end
end