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
      it 'set as default type' do
        expect{post.title = 'Test title'}.not_to raise_error
        expect{post.title = 100}.to raise_error RuntimeError, 'WrongFormat: value must be String'
      end

      it 'get as String' do
        post.title = 'Best title ever'
        expect(post.title).to be_instance_of String
      end

      it 'excellent work if statically typed' do
        expect{post.author = 'Test author'}.not_to raise_error
        expect{post.author = 100}.to raise_error RuntimeError, 'WrongFormat: value must be String'
      end

      it 'get as String' do
        post.author = 'Best author ever'
        expect(post.author).to be_instance_of String
      end
    end

    describe 'Integer' do
      it 'excellent work' do
        expect{post.rank = 5}.not_to raise_error
        expect{post.rank = '5'}.to raise_error RuntimeError, 'WrongFormat: value must be Integer'
      end

      it 'get as Integer' do
        post.rank = 5
        expect(post.rank).to be_instance_of Fixnum
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
        expect(post.weight).to be_instance_of Float
        post.weight = 77
        expect(post.weight).to be_instance_of Float
      end
    end

    describe 'Bool' do
      it 'excellent work' do
        expect{post.featured = true }.not_to raise_error
        expect{post.featured = false}.not_to raise_error
        expect{post.featured = 'true'}.to raise_error RuntimeError, 'WrongFormat: value must be Bool'
        expect{post.featured = 'false'}.to raise_error RuntimeError, 'WrongFormat: value must be Bool'
        expect{post.featured = 777}.to raise_error RuntimeError, 'WrongFormat: value must be Bool'
      end

      it 'get as Bool' do
        post.featured = true
        expect(post.featured).to be_instance_of TrueClass
        post.featured = false
        expect(post.featured).to be_instance_of FalseClass
      end
    end

    describe 'Array' do
      let(:arr) { [1, 'a', true] }
      it 'excellent work' do
        expect{ post.credentials = arr   }.not_to raise_error
        expect{ post.credentials = 'str' }.to raise_error RuntimeError, 'WrongFormat: value must be Array'
        expect{ post.credentials = 12345 }.to raise_error RuntimeError, 'WrongFormat: value must be Array'
        expect{ post.credentials = true  }.to raise_error RuntimeError, 'WrongFormat: value must be Array'
        expect{ post.credentials = false }.to raise_error RuntimeError, 'WrongFormat: value must be Array'
      end

      it 'get as Array' do
        post.credentials = arr
        expect(post.credentials).to be_instance_of Array
      end
    end

    describe 'Hash' do
      let(:hsh) { {first: '1', second: '2'} }
      it 'excellent work' do
        expect{ post.details = hsh   }.not_to raise_error
        expect{ post.details = 'str' }.to raise_error RuntimeError, 'WrongFormat: value must be Hash'
        expect{ post.details = 12345 }.to raise_error RuntimeError, 'WrongFormat: value must be Hash'
        expect{ post.details = true  }.to raise_error RuntimeError, 'WrongFormat: value must be Hash'
        expect{ post.details = false }.to raise_error RuntimeError, 'WrongFormat: value must be Hash'
      end

      it 'get as Array' do
        post.details = hsh
        expect(post.details).to be_instance_of Hash
      end
    end

    describe 'Time' do
      it 'excellent work' do
        expect{ post.published_at = Time.now }.not_to raise_error
        expect{ post.published_at = 'str' }.to raise_error RuntimeError, 'WrongFormat: value must be Time'
        expect{ post.published_at = 12345 }.to raise_error RuntimeError, 'WrongFormat: value must be Time'
        expect{ post.published_at = true  }.to raise_error RuntimeError, 'WrongFormat: value must be Time'
        expect{ post.published_at = false }.to raise_error RuntimeError, 'WrongFormat: value must be Time'
      end

      it 'get as Time' do
        post.published_at = Time.now
        expect(post.published_at).to be_instance_of Time
      end
    end

    describe '.types' do
      it 'return hash with all types' do
        hash = { title: "String", body: "String", author: "String", rank: "Integer", weight: "Float", featured: "Bool", credentials: "Array", details: "Hash", published_at: "Time" }
        expect(Post.types).to eq hash
      end
    end
  end
end
