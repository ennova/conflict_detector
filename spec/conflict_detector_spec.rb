require 'conflict_detector'

describe ConflictDetector do
  describe 'conflict' do
    describe 'record does exist' do
      let(:detector) { ConflictDetector.new(model, :description) }
      let(:record) { Object.new }
      let(:model) do
        mock = mock 'Model'
        mock.should_receive(:description).and_return('Hello, World!')
        mock.should_receive(:class).and_return(mock)
        mock.should_receive(:where).with(:description => 'Hello, World!').and_return(mock)
        mock.should_receive(:first).and_return(record)
        mock
      end

      it 'should be the record' do
        detector.conflict.should equal(record)
      end

      describe 'status' do
        before do
          detector.conflict
        end

        it 'should be conflict' do
          detector.status.should eq(:conflict)
        end
      end
    end

    describe 'record does not exist' do
      let(:detector) { ConflictDetector.new(model) }
      let(:model) do
        mock = mock 'Model'
        mock.should_receive(:class).and_return(mock)
        mock.should_receive(:where).and_return(mock)
        mock.should_receive(:first).and_return(nil)
        mock
      end

      it 'should be nil' do
        detector.conflict.should be_nil
      end

      describe 'status' do
        before do
          detector.conflict
        end

        it 'should be nil' do
          detector.status.should be_nil
        end
      end
    end
  end

  describe 'create' do
    let(:detector) { ConflictDetector.new(model) }
    let(:model) do
      mock = mock 'Model'
      mock.should_receive(:save).and_return(true)
      mock
    end

    it 'should be the model' do
      detector.create.should equal(model)
    end

    describe 'status' do
      before do
        detector.create
      end

      it 'should be created' do
        detector.status.should eq(:created)
      end
    end
  end

  describe 'conflicting or creating record' do
    describe 'conflict' do
      let(:record) { Object.new }
      let(:detector) do
        detector = ConflictDetector.new(nil)
        detector.should_receive(:conflict).and_return(record)
        detector
      end

      it 'should be the conflicting record' do
        detector.conflicting_or_created_record.should equal(record)
      end
    end

    describe 'create' do
      let(:record) { Object.new }
      let(:detector) do
        detector = ConflictDetector.new(nil)
        detector.should_receive(:conflict).and_return(nil)
        detector.should_receive(:create).and_return(record)
        detector
      end

      it 'should be the created record' do
        detector.conflicting_or_created_record.should equal(record)
      end
    end
  end
end
