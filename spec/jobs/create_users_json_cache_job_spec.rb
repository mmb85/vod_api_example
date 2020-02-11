require "rails_helper"

RSpec.describe CreateUsersJsonCacheJob, :type => :job do
  describe "#perform_later" do
    let!(:user) { create :user }
    
    it "Job is queued" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        CreateUsersJsonCacheJob.perform_later
      }.to have_enqueued_job
    end

    it "Cache was creted properly" do
      ActiveJob::Base.queue_adapter = :test
      expect { CreateUsersJsonCacheJob.perform_now }.not_to raise_error
    end
  end
end