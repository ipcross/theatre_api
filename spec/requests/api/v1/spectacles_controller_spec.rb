describe 'Spectacles controller', type: :request do
  let!(:spectacle) { create(:spectacle) }

  describe 'get #spectacles' do
    it 'returns success code and data' do
      request_api :get, api_spectacles_path, token: 'test_access_api_token'
      expect(response).to have_http_status(:ok)
      expect(json).not_to be_empty
      %i[id name date_from date_to].each do |attr|
        expect(json[:spectacles].first).to include(attr)
      end
    end

    it 'returns error when send wrong token' do
      request_api :get, api_spectacles_path, token: 'wrong token'
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns error when unauthorized' do
      request_api :get, api_spectacles_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'post #spectacles' do
    it 'returns success code and data' do
      request_api :post,
                  api_spectacles_path(name: 'test', date_from: '2022-01-28', date_to: '2022-01-29'),
                  token: 'test_access_api_token'
      expect(response).to have_http_status(:ok)
      expect(json).not_to be_empty
      %i[id name date_from date_to].each do |attr|
        expect(json[:spectacles]).to include(attr)
      end
    end

    it 'returns error when spectacle exists' do
      date = spectacle.period.first.strftime
      request_api :post,
                  api_spectacles_path(name: 'test', date_from: date, date_to: date),
                  token: 'test_access_api_token'
      expect(response).to have_http_status(:bad_request)
      expect(json[:errors][:detail]).to eq 'Period Spectacle exists.'
    end

    it 'returns error when bad date format' do
      request_api :post,
                  api_spectacles_path(name: 'test', date_from: '2022-01-28', date_to: 'sdfsdfsdfsdf'),
                  token: 'test_access_api_token'
      expect(response).to have_http_status(:bad_request)
      expect(json[:errors][:detail]).to eq 'bad date format'
    end

    it 'returns error when name is empty' do
      request_api :post,
                  api_spectacles_path(name: ''),
                  token: 'test_access_api_token'
      expect(response).to have_http_status(:bad_request)
    end

    it 'returns error when send wrong token' do
      request_api :post, api_spectacles_path, token: 'wrong token'
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns error when unauthorized' do
      request_api :post, api_spectacles_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'delete #spectacles/id' do
    it 'returns success code and data' do
      request_api :delete,
                  api_spectacle_path(spectacle),
                  token: 'test_access_api_token'
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq 'Was successfully destroyed.'
    end

    it 'returns error when request not found' do
      request_api :delete,
                  api_spectacle_path(id: 1000),
                  token: 'test_access_api_token'
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error when send wrong token' do
      request_api :delete, api_spectacle_path(spectacle), token: 'wrong token'
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns error when unauthorized' do
      request_api :delete, api_spectacle_path(spectacle)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
