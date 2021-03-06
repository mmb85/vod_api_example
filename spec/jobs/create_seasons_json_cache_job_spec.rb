require "rails_helper"

RSpec.describe CreateSeasonsJsonCacheJob, :type => :job do
  describe "#perform_later" do
    let!(:season) { create :season }
    
    it "Job is queued" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        CreateSeasonsJsonCacheJob.perform_later
      }.to have_enqueued_job
    end

    it "Cache was creted properly" do
      ActiveJob::Base.queue_adapter = :test
      expect { CreateSeasonsJsonCacheJob.perform_now }.not_to raise_error
    end
  end
end