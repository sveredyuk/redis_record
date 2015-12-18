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

      describe 'body' do
        it 'get value like a string' do
          post.body = 'Random Body'
          expect(post.body).to eq 'Random Body'
        end

        it 'return default value' do
          expect(post.body).to eq '...'
        end
      end

      describe 'author' do
        it 'get value like a string' do
          post.author = 'Random author'
          expect(post.author).to eq 'Random author'
        end

        it 'return default value' do
          expect(post.author).to eq '...'
        end
      end

      describe 'rank' do
        it 'get value like a integer' do
          post.rank = 10
          expect(post.rank).to eq 10
        end

        it 'return default value' do
          expect(post.rank).to eq 5
        end
      end

      describe 'weight' do
        it 'get value like a integer' do
          post.weight = 333.33
          expect(post.weight).to eq 333.33
        end

        it 'return default value' do
          expect(post.weight).to eq 100.00
        end
      end

      describe 'featured' do
        it 'get value like a bool' do
          post.featured = true
          expect(post.featured).to eq true
          post.featured = false
          expect(post.featured).to eq false
        end

        it 'return default value' do
          expect(post.featured).to eq false
        end
      end

      describe 'credentials' do
        it 'get value like a array' do
          post.credentials = ['a', 'b', 'c']
          expect(post.credentials).to eq ['a', 'b', 'c']
        end

        it 'return default value' do
          expect(post.credentials).to eq [100, 200]
        end
      end

      describe 'details' do
        it 'get value like a hash' do
          hsh = { follow: true }
          post.details = hsh
          expect(post.details).to eq hsh
        end

        it 'return default value' do
          hsh = { some: 'good' }
          expect(post.details).to eq hsh
        end
      end

      describe 'published_at' do
        it 'get value like a time' do
          t = Time.new('2015-12-18 12:58:08 +0200')
          post.published_at = t
          expect(post.published_at).to eq t
        end

        it 'return default value' do
          expect(post.published_at).to eq "2016-12-18 12:58:08 +0200"
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
