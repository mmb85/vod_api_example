require "rails_helper"

RSpec.describe CreatePurchasesJsonCacheJob, :type => :job do
  describe "#perform_later" do
    let!(:purchase) { create :hd_purchase }
    
    it "Job is queued" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        CreatePurchasesJsonCacheJob.perform_later
      }.to have_enqueued_job
    end

    it "Cache was creted properly" do
      ActiveJob::Base.queue_adapter = :test
      expect { CreatePurchasesJsonCacheJob.perform_now }.not_to raise_error
    end
  end
end