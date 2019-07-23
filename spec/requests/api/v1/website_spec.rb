# frozen_string_literal: true

RSpec.describe 'Api::V1::Websites', type: :request do
  describe 'GET /websites' do
    let!(:websites) { FactoryBot.create_list(:website, 150) }

    it 'returns top 100 websites' do
      get '/api/v1/websites'
      top = Website.top(100)
      expect(response.body).to eq(ActiveModelSerializers::SerializableResource.new(top).to_json)
    end
  end

  describe 'POST /websites' do
    context 'when invalid request' do
      it 'responds with 400' do
        post '/api/v1/websites', params: { website: { url: 'not_a_url' } }
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)['errors']).to be_present
      end
    end

    context 'when valid request' do
      context 'when website exists' do
        let!(:website) { FactoryBot.create(:website) }

        it 'responds the website' do
          post '/api/v1/websites', params: { website: { url: website.url } }
          expect(JSON.parse(response.body)['id']).to eq(website.shortened_id)
        end
      end

      context 'when website does not exist' do
        it 'creates the website' do
          post '/api/v1/websites', params: { website: { url: 'http://fakeurl.com' } }
          expect(JSON.parse(response.body)['id']).to eq(Website.last.shortened_id)
        end
      end
    end
  end

  describe 'GET /websites/:id' do
    context 'when website exists' do
      let!(:website) { FactoryBot.create(:website) }

      it 'returns the website associated to the shortened_id' do
        get "/api/v1/websites/#{website.shortened_id}"
        expect(response.body).to eq(WebsiteSerializer.new(website.reload).to_json)
      end
    end

    context 'when website does not exist' do
      it 'responds with 404' do
        get '/api/v1/websites/1'
        expect(response.status).to eq(404)
      end
    end
  end
end
