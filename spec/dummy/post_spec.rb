describe Post do
  let(:post) { Post.new }
  after { Post.destroy_all } # clear DB...

  describe '#connection' do
    it 'return current redis connection' do
      expect(Post.redis).to be_kind_of Redis
    end
  end

  describe 'field' do
    describe 'title' do
      it 'get value like a string' do
        post.title = 'Random Title'
        expect(post.title).to eq 'Random Title'
      end

      it 'get any value but convert it to ' do
        post.title = 3.1415
        expect(post.title).to eq '3.1415'
      end
    end
  end

  describe 'fields' do
    describe 'body' do
      it 'get value like a string' do
        post.body = 'Random body'
        expect(post.body).to eq 'Random body'
      end

      it 'get any value but convert it to ' do
        post.body = 3541269708
        expect(post.body).to eq '3541269708'
      end
    end
  end

  describe 'queries' do
    describe 'all' do
      it 'return 3 items' do
        3.times do
          p = Post.new
          p.title = 'dummy'
          p.save
        end

        expect(Post.all.size).to eq 3
      end

      it 'return empty array' do
        expect(Post.all).to eq []
      end
    end

    describe 'find' do
      it 'return correct record' do
        post.title = 'Correct Record'
        post.save
        expect(Post.find(post.id).title).to eq 'Correct Record'
      end

      it 'return nil' do
        expect(Post.find('dummy')).to eq nil
      end
    end

    describe 'find_by' do
      it 'return correct record' do
        post.author = 'V. Sveredyuk'
        post.save
        expect(Post.find_by(:author, 'V. Sveredyuk').author).to eq 'V. Sveredyuk'
      end

      it 'return nil' do
        expect(Post.find_by(:dummy, 'field')).to eq nil
      end
    end

    describe 'destroy_all' do
      it 'delete all items' do
        3.times do
          p = Post.new
          p.title = 'dummy'
          p.save
        end
        expect(Post.all.size).to eq 3

        Post.destroy_all
        expect(Post.all.size).to eq 0
      end
    end
  end
end
