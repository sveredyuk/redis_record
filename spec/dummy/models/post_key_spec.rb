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

  describe 'Key' do
    describe '.key' do
      it 'return correct key name' do
        expect(Post.key("123")).to eq 'Post:123'
      end
    end
  end
end
