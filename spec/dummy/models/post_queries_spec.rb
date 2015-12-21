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

    describe '.count' do
      context 'when record present' do
        before { setup }
        it 'return 3 items' do
          expect(Post.count).to eq 3
        end
      end

      context 'when records not present' do
        it 'return empty array' do
          expect(Post.count).to eq 0
        end
      end
    end

    describe '.first' do
      context 'when record present' do
        before { setup }
        it 'return first items' do
          expect(Post.first.id).to eq Post.all[0].id
        end
      end

      context 'when records not present' do
        it 'return nil array' do
          expect(Post.first).to eq nil
        end
      end
    end

    describe '.last' do
      context 'when record present' do
        before { setup }
        it 'return last items' do
          expect(Post.last.id).to eq Post.all[2].id
        end
      end

      context 'when records not present' do
        it 'return nil array' do
          expect(Post.last).to eq nil
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
end
