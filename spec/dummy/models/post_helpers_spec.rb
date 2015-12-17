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
      it 'must be false' do
        expect(post.persisted?).to eq false
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
