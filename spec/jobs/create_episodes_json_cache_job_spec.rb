require "rails_helper"

RSpec.describe CreateEpisodesJsonCacheJob, :type => :job do
  describe "#perform_later" do
    let!(:episode) { create :episode }
    
    it "Job is queued" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        CreateEpisodesJsonCacheJob.perform_later
      }.to have_enqueued_job
    end

    it "Cache was creted properly" do
      ActiveJob::Base.queue_adapter = :test
      expect { CreateEpisodesJsonCacheJob.perform_now }.not_to raise_error
    end
  end
end