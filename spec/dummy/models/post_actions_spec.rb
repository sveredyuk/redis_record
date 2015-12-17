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

    describe '#update' do
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

    describe '#destroy' do
      it 'remove record' do
        post.save
        expect(Post.all.size).to eq 1
        post.destroy
        expect(Post.all.size).to eq 0
      end
    end
  end
end
