describe CategoriesController, type: :controller do
  let!(:setup) do
    3.times do |i|
      p = Category.new
      p.name = "category_#{i}"
      p.position = i
      p.save
    end
  end
  let(:new_category)  { Category.new }
  let(:some_category) { Category.all.first }
  let(:attrs) do
    { name: 'New Category', position: 0 }
  end

  after { Category.destroy_all } # clear DB...

  describe 'GET #index' do
    before { get :index }

    it 'populates an array of categories' do
      expect(assigns(:categories).size).to eq 3
    end

    it 'populates the same records like in db' do
      expect(assigns(:categories)[0].id).to eq Category.all[0].id
      expect(assigns(:categories)[1].id).to eq Category.all[1].id
      expect(assigns(:categories)[2].id).to eq Category.all[2].id
    end

    it 'render the :index view' do
      expect(response).to render_template :index
    end

    it 'respond with 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns the requested category to @category' do
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'render the :new view' do
      expect(response).to render_template :new
    end

    it 'respond with 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    before { get :show, id: some_category.id }

    it 'assigns the requested category to @category' do
      expect(assigns(:category).id).to eq some_category.id
    end

    it 'render the :show view' do
      expect(response).to render_template :show
    end

    it 'respond with 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: some_category.id }

    it 'assigns the requested category to @category' do
      expect(assigns(:category).id).to eq some_category.id
    end

    it 'render the :edit view' do
      expect(response).to render_template :edit
    end

    it 'respond with 200' do
      expect(response).to have_http_status(200)
    end
  end


  describe 'POST #create' do
    before { post :create, category: attrs }
    it 'save the new category to db' do
      expect{ post :create, category: attrs }.to change(Category, :count).by(1)
    end

    it 'create new category with correct attributes' do
      expect(Category.find_by(:name, 'New Category').name).to eq 'New Category'
    end
  end

  describe 'PUT #update' do
    it 'update the category' do
      put :update, id: some_category.id, category: { name: 'Modified!' }
      expect(Category.find_by(:name, 'Modified!').name).to eq 'Modified!'
    end

    it 'not change total record count' do
      expect{ put :update, id: some_category.id, category: { name: 'Modified!' } }.not_to change(Category, :count)
    end
  end

  describe 'DELETE #destroy' do
    it 'remove record from db' do
      expect{ delete :destroy, id: some_category.id }.to change(Category, :count).by(-1)
    end

    it 'change total count of records' do
      delete :destroy, id: some_category.id
      expect(Category.all.size).to eq 2
    end
  end
end
