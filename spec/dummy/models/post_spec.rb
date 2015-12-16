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
        expect(Post.redis).to be_kind_of Redis
      end
    end
  end

  describe 'Fields' do
    describe '.field' do
      describe 'title' do
        it 'get value like a string' do
          post.title = 'Random Title'
          expect(post.title).to eq 'Random Title'
        end

        it 'get any value but convert it to string' do
          post.title = 3.1415
          expect(post.title).to eq '3.1415'
        end
      end
    end

    describe '.fields' do
      describe 'body' do
        it 'get value like a string' do
          post.body = 'Random body'
          expect(post.body).to eq 'Random body'
        end

        it 'get any value but convert it to string' do
          post.body = 3541269708
          expect(post.body).to eq '3541269708'
        end
      end
    end
  end

  describe 'Queries' do
    describe '.all' do
      context 'when record present' do
        before { setup }
        it 'return 3 items' do
          expect(Post.all.size).to eq 3
        end
      end

      context 'when records not present' do
        it 'return empty array' do
          expect(Post.all).to eq []
        end
      end
    end

    describe 'find' do
      context 'when records present' do
        before { setup }
        it 'return correct record' do
          setup
          post.title = 'Correct Record'
          post.save
          expect(Post.find(post.id).title).to eq 'Correct Record'
        end
      end

      context 'when records not present' do
        it 'return nil' do
          expect(Post.find('dummy_id')).to eq nil
        end
      end
    end

    describe 'find_by' do
      context 'when records present' do
        before { setup }
        it 'return correct record for correct ID' do
          post.author = 'V. Sveredyuk'
          post.save
          expect(Post.find_by(:author, 'V. Sveredyuk').author).to eq 'V. Sveredyuk'
        end

        it 'return nil for incorrect ID' do
          expect(Post.find_by(:title, 'Some dummy title of record')).to eq nil
        end
      end

      context 'when records not present' do
        it 'return correct record for correct ID' do
          post.author = 'V. Sveredyuk'
          post.save
          expect(Post.find_by(:author, 'V. Sveredyuk').author).to eq 'V. Sveredyuk'
        end

        it 'return nil for incorrect ID' do
          expect(Post.find_by(:dummy, 'field')).to eq nil
        end
      end
    end

    describe 'destroy_all' do
      context 'when records present' do
        before { setup }
        it 'remove all records from redis' do
          Post.destroy_all
          expect(Post.all.size).to eq 0
        end

        it 'return number of deleted items' do
          expect(Post.destroy_all).to eq 3
        end
      end

      context 'when records not present' do
        it 'return 0' do
          expect(Post.destroy_all).to eq 0
        end
      end
    end
  end

  describe 'Key' do
    describe '.key' do
      it 'return correct key name' do
        expect(Post.key("123")).to eq 'Post:123'
      end
    end
  end

  describe 'Actions' do
    describe '#new' do
      it 'not raise any exception' do
        expect{post = Post.new}.not_to raise_error
      end

      it 'initialize with attributes' do
        post = Post.new(title: 'Test title', body: 'Test body', author: 'Test author')
        expect(post.title).to  eq 'Test title'
        expect(post.body).to   eq 'Test body'
        expect(post.author).to eq 'Test author'
      end
    end

    describe '#save' do
      context 'when valid' do
        it 'create new record' do
          post.save
          expect(Post.all.size).to eq 1
        end

        it 'return true' do
          expect(post.save).to eq true
        end
      end

      context 'when invalid' do
        before { allow(post).to receive(:valid?).and_return(false) }
        it 'not create new record' do
          post.save
          expect(Post.all.size).to eq 0
        end

        it 'return false' do
          expect(post.save).to eq false
        end
      end
    end

    describe '#save!' do
      context 'when valid' do
        it 'create new record' do
          post.save!
          expect(Post.all.size).to eq 1
        end

        it 'return record' do
          expect(post.save!).to eq post
        end
      end

      context 'when invalid' do
        before { allow(post).to receive(:valid?).and_return(false) }
        it 'not create new record' do
          post.save!
          expect(Post.all.size).to eq 0
        end

        it 'return false' do
          expect(post.save!).to eq false
        end
      end
    end

    describe 'update' do
      before do
        post.title  = 'Titile'
        post.body   = 'Body'
        post.author = 'Author'
        post.save
      end

      let(:update_params) do
        { title: 'New title', body: 'New body', author: 'New author' }
      end

      context 'when valid' do
        it 'change fields values' do
          post.update(update_params)
          expect(post.title).to  eq 'New title'
          expect(post.body).to   eq 'New body'
          expect(post.author).to eq 'New author'
        end

        it 'return true' do
          expect(post.update(update_params)).to eq true
        end
      end

      context 'when invalid' do
        before { allow(post).to receive(:valid?).and_return(false) }
        it 'change fields values' do
          post.update(update_params)
          expect(post.title).to  eq 'New title'
          expect(post.body).to   eq 'New body'
          expect(post.author).to eq 'New author'
        end

        it 'return false' do
          expect(post.update(update_params)).to eq false
        end
      end
    end
  end
end
