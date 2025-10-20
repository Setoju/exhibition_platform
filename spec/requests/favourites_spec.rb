require 'rails_helper'

RSpec.describe 'Favourites', type: :request do
  let(:user) { create(:user) }
  let(:exhibition) { create(:exhibition) }

  describe 'GET /favourites' do
    context 'when user is not logged in' do
      it 'returns a 302 http status' do
        get favourites_path
        expect(response).to have_http_status(302)
      end
    end

    context 'when user is logged in' do
      before { sign_in(user) }

      it 'returns a 200 http status' do
        get favourites_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /favourites' do
    before { sign_in(user) }

    context 'when not already favourited' do
      it 'creates a new favourite' do
        expect {
          post exhibition_favourite_path(exhibition)
        }.to change(Favourite, :count).by(1)
        expect(response).to redirect_to(exhibition_path(exhibition))
        follow_redirect!
        expect(response.body).to include('Added to favourites.')
      end
    end

    context 'when already favourited' do
      before { user.favourites.create(exhibition: exhibition) }

      it 'does not create a duplicate favourite' do
        expect {
          post exhibition_favourite_path(exhibition)
        }.not_to change(Favourite, :count)
      end
    end
  end

  describe 'DELETE favourites' do
    before { sign_in(user) }
    before { user.favourites.create(exhibition: exhibition) }

    it 'removes the favourite' do
      expect {
        delete exhibition_favourite_path(exhibition)
      }.to change(Favourite, :count).by(-1)
      expect(response).to redirect_to(exhibition_path(exhibition))
      follow_redirect!
      expect(response.body).to include('Removed from favourites.')
    end

    it 'handles attempting to remove a non-existent favourite gracefully' do
      user.favourites.destroy_all
      expect {
        delete exhibition_favourite_path(exhibition)
      }.not_to change(Favourite, :count)
      expect(response).to redirect_to(exhibition_path(exhibition))
    end
  end
end
