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

  describe 'Fields' do
    describe '.field' do
      describe 'title' do
        it 'get value like a string' do
          post.title = 'Random Title'
          expect(post.title).to eq 'Random Title'
        end
      end
    end

    describe '.fields' do
      describe 'body' do
        it 'get value like a string' do
          post.body = 'Random body'
          expect(post.body).to eq 'Random body'
        end
      end
    end
  end
end
