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

  describe 'Connection' do
    describe '.redis' do
      it 'return current redis connection' do
        expect(Post.redis).to be_instance_of Redis
      end
    end
  end
end
