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

  describe 'Types' do
    describe 'String' do
      it 'setted as default type' do
        expect{post.title = 'Test title'}.not_to raise_error
        expect{post.title = 100}.to raise_error RuntimeError, 'WrongFormat: value must be String'
      end

      it 'get as String' do
        post.title = 'Best title ever'
        expect(post.title).to be_kind_of String
      end

      it 'excellent also work if statically typed' do
        expect{post.author = 'Test author'}.not_to raise_error
        expect{post.author = 100}.to raise_error RuntimeError, 'WrongFormat: value must be String'
      end

      it 'get as String' do
        post.author = 'Best author ever'
        expect(post.author).to be_kind_of String
      end
    end

    describe 'Integer' do
      it 'excellent work' do
        expect{post.rank = 5}.not_to raise_error
        expect{post.rank = '5'}.to raise_error RuntimeError, 'WrongFormat: value must be Integer'
      end

      it 'get as Integer' do
        post.rank = 5
        expect(post.rank).to be_kind_of Integer
      end
    end

    describe 'Float' do
      it 'excellent work' do
        expect{post.weight = 99.9}.not_to raise_error
        expect{post.weight = 99}.not_to raise_error
        expect{post.weight = '99.9'}.to raise_error RuntimeError, 'WrongFormat: value must be Float'
      end

      it 'get as Float' do
        post.weight = 77.7
        expect(post.weight).to be_kind_of Float
        post.weight = 77
        expect(post.weight).to be_kind_of Float
      end
    end

    describe '.types' do
      it 'return hash with all types' do
        hash = { title: "String", body: "String", author: "String", rank: "Integer", weight: "Float" }
        expect(Post.types).to eq hash
      end
    end
  end
end
