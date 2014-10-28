shared_examples 'indexable' do |method, value|
  include_context 'subject class'

  describe 'approved' do
    before do
      subject.consultant.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::APPROVED)
      ConsultantIndexer.jobs.clear
      SidekiqUniqueJobs.redis_mock.flushdb
    end

    describe '#create' do
      it 'should start a job' do
        expect(ConsultantIndexer).to receive(:perform_async).with(:update, subject.consultant.id)
        subject.save!
      end

      it 'should add a job to queue' do
        expect { subject.save! }.to change(ConsultantIndexer.jobs, :size).from 0
      end
    end

    describe '#update' do
      before do
        subject.save!
        subject.send(method, value)
        ConsultantIndexer.jobs.clear
        SidekiqUniqueJobs.redis_mock.flushdb
      end

      it 'should start a job' do
        expect(ConsultantIndexer).to receive(:perform_async).with(:update, subject.consultant.id)
        subject.save!
      end

      it 'should add a job to queue' do
        expect { subject.save! }.to change(ConsultantIndexer.jobs, :size).from 0
      end
    end

    describe '#destroy' do
      before do
        subject.save!
        ConsultantIndexer.jobs.clear
        SidekiqUniqueJobs.redis_mock.flushdb
      end

      it 'should start a job' do
        expect(ConsultantIndexer).to receive(:perform_async).with(:update, subject.consultant.id)
        subject.destroy!
      end

      it 'should add a job to queue' do
        expect { subject.destroy! }.to change(ConsultantIndexer.jobs, :size).from 0
      end
    end
  end

  describe 'not approved' do
    before do
      subject.consultant.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::REJECTED)
      ConsultantIndexer.jobs.clear
      SidekiqUniqueJobs.redis_mock.flushdb
    end

    describe '#create' do
      it 'should not start a job' do
        expect(ConsultantIndexer).not_to receive(:perform_async).with(:update,
                                                                      subject.consultant.id)
        subject.save!
      end

      it 'should not add a job to queue' do
        expect { subject.save! }.not_to change { ConsultantIndexer.jobs.length }.from 0
      end
    end

    describe '#update' do
      before do
        subject.save!
        ConsultantIndexer.jobs.clear
        SidekiqUniqueJobs.redis_mock.flushdb
      end

      it 'should not start a job' do
        expect(ConsultantIndexer).not_to receive(:perform_async).with(:update,
                                                                      subject.consultant.id)
        subject.save!
      end

      it 'should not add a job to queue' do
        expect { subject.save! }.not_to change(ConsultantIndexer.jobs, :size).from 0
      end
    end

    describe '#destroy' do
      before do
        subject.save!
        ConsultantIndexer.jobs.clear
        SidekiqUniqueJobs.redis_mock.flushdb
      end

      it 'should not start a job' do
        expect(ConsultantIndexer).not_to receive(:perform_async).with(:update,
                                                                      subject.consultant.id)
        subject.destroy!
      end

      it 'should not add a job to queue' do
        expect { subject.destroy! }.not_to change(ConsultantIndexer.jobs, :size).from 0
      end
    end
  end
end
