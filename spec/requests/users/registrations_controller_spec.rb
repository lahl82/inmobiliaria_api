RSpec.describe Users::RegistrationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            email: 'test@example.com',
            password: 'password123'
          }
        }
      end

    #   it 'creates a new user' do
    #     expect do
    #       post :create, params: valid_params
    #     end.to change(User, :count).by(1)
    #   end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)
      end

    #   it 'returns the created user data' do
    #     post :create, params: valid_params
    #     user = User.last
    #     expect(response.body).to include(user.email)
    #     # ... agregar más expectativas según tu UserSerializer
    #   end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            email: '',
            password: 'password123'
          }
        }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'returns an error response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the error message' do
        post :create, params: invalid_params
        response_body = JSON.parse(response.body)
        expect(response_body['status']['message']).to include("User couldn't be created successfully")
      end
    end
  end
end
