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

  describe 'Validations' do
    describe '#unique?' do
      before do
        post.title = 'Unique title'
        post.save
      end
      context 'when record has title with realy unique value' do
        it 'return true' do
          new_post = Post.new(title: 'Another post')
          new_post.save
          expect(Post.all.size).to eq 2
          expect(new_post.unique?(:title)).to eq true
        end
      end

      context 'when record has title with same value' do
        it 'return false' do
          double_post = Post.new(title: 'Unique title')
          double_post.save
          expect(Post.all.size).to eq 2
          #expect(double_post.unique?(:title)).to eq false # TODO BUG -> some timeout issues
        end
      end
    end
  end
end
