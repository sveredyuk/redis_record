describe Post do
  let(:post) { Post.new }
  let(:setup) do
    3.times do
      p = Post.new
      p.title = 'dummy'
      p.save
    end
  end

  after { Post.destroy_all } # clear DB...

  describe 'Helpers' do
    describe '#redis' do
      it 'return current redis connection' do
        expect(post.redis).to be_instance_of Redis
      end
    end

    describe '#persisted?' do
      context 'when new record' do
        it 'return nil' do
          expect(post.persisted?).to eq nil
        end
      end

      context 'when exist record' do
        it 'return self' do
          post.save
          expect(post).to receive(:persisted?).and_return(post)
          post.persisted?
        end
      end
    end

    describe '#to_param' do
      context 'when new record' do
        it 'return nil' do
          expect(post.to_param).to eq nil
        end
      end

      context 'when exist record' do
        it 'return id' do
          post.save
          expect(post).to receive(:persisted?).and_return(post.id)
          post.to_param
        end
      end
    end

    describe '#new_record?' do
      context 'when new record' do
        it 'return true' do
          expect(post.new_record?).to eq true
        end
      end

      context 'when exist record' do
        it 'return false' do
          post.save
          expect(post.new_record?).to eq false
        end
      end
    end

    describe '#fields' do
      it 'return a hash of fields' do
        setup
        p = Post.all.first
        expect(p.attributes).to eq p.instance_variable_get('@fields')
      end
    end
  end
end
