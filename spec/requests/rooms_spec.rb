require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  let(:admin) { create(:user, :admin) }

  describe 'GET /rooms' do
    context 'when admin is not logged in' do
      it 'returns a 302 http status' do
        get admin_exhibition_center_rooms_path(exhibition_center_id: 1)
        expect(response).to have_http_status(302)
      end

      it 'redirects to the login page' do
        get admin_exhibition_center_rooms_path(exhibition_center_id: 1)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when admin is logged in' do
      before { sign_in(admin) }

      it 'returns a 200 http status' do
        exhibition_center = create(:exhibition_center)
        get admin_exhibition_center_rooms_path(exhibition_center_id: exhibition_center.id)
        expect(response).to have_http_status(200)
      end

      it 'renders the index template' do
        exhibition_center = create(:exhibition_center)
        get admin_exhibition_center_rooms_path(exhibition_center_id: exhibition_center.id)
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'DELETE /rooms/:id' do
    let(:exhibition_center) { create(:exhibition_center) }
    let!(:room) { create(:room, exhibition_center: exhibition_center) }

    context 'when admin is not logged in' do
      it 'returns a 302 http status' do
        delete admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id)
        expect(response).to have_http_status(302)
      end
    end

    context 'when admin is logged in' do
      before { sign_in(admin) }

      it 'deletes the room' do
        expect {
          delete admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id)
        }.to change(Room, :count).by(-1)
      end

      it 'redirects to the rooms index page' do
        delete admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id)
        expect(response).to redirect_to(admin_exhibition_center_rooms_path(exhibition_center))
      end
    end
  end

  describe 'POST /rooms' do
    let(:exhibition_center) { create(:exhibition_center) }
    let(:valid_params) do
      {
        room: {
          name: 'New Room',
          width: 100,
          height: 200,
          depth: 300
        }
      }
    end

    context 'when admin is not logged in' do
      it 'returns a 302 http status' do
        post admin_exhibition_center_rooms_path(exhibition_center_id: exhibition_center.id), params: valid_params
        expect(response).to have_http_status(302)
      end
    end

    context 'when admin is logged in' do
      before { sign_in(admin) }

      context 'with valid parameters' do
        it 'creates a new room' do
          expect {
            post admin_exhibition_center_rooms_path(exhibition_center_id: exhibition_center.id), params: valid_params
          }.to change(Room, :count).by(1)
        end

        it 'redirects to the rooms index page' do
          post admin_exhibition_center_rooms_path(exhibition_center_id: exhibition_center.id), params: valid_params
          expect(response).to redirect_to(admin_exhibition_center_rooms_path(exhibition_center))
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          {
            room: {
              name: '',
              width: -100,
              height: 200,
              depth: 300
            }
          }
        end

        it 'does not create a new room' do
          expect {
            post admin_exhibition_center_rooms_path(exhibition_center_id: exhibition_center.id), params: invalid_params
          }.not_to change(Room, :count)
        end

        it 'renders the new template with unprocessable_entity status' do
          post admin_exhibition_center_rooms_path(exhibition_center_id: exhibition_center.id), params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'PATCH /rooms/:id' do
    let(:exhibition_center) { create(:exhibition_center) }
    let!(:room) { create(:room, exhibition_center: exhibition_center) }
    let(:valid_params) do
      {
        room: {
          name: 'Updated Room',
          width: 150,
          height: 250,
          depth: 350
        }
      }
    end

    context 'when admin is not logged in' do
      it 'returns a 302 http status' do
        patch admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id), params: valid_params
        expect(response).to have_http_status(302)
      end
    end

    context 'when admin is logged in' do
      before { sign_in(admin) }

      context 'with valid parameters' do
        it 'updates the room' do
          patch admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id), params: valid_params
          room.reload
          expect(room.name).to eq('Updated Room')
          expect(room.width).to eq(150)
          expect(room.height).to eq(250)
          expect(room.depth).to eq(350)
        end

        it 'redirects to the exhibition center page' do
          patch admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id), params: valid_params
          expect(response).to redirect_to(admin_exhibition_center_path(exhibition_center))
        end
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          {
            room: {
              name: '',
              width: -150,
              height: 250,
              depth: 350
            }
          }
        end

        it 'does not update the room' do
          patch admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id), params: invalid_params
          room.reload
          expect(room.name).not_to eq('')
          expect(room.width).not_to eq(-150)
        end

        it 'renders the edit template with unprocessable_entity status' do
          patch admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id), params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'GET /rooms/:id' do
    let(:exhibition_center) { create(:exhibition_center) }
    let(:room) { create(:room, exhibition_center: exhibition_center) }

    context 'when admin is not logged in' do
      it 'returns a 302 http status' do
        get admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id)
        expect(response).to have_http_status(302)
      end
    end

    context 'when admin is logged in' do
      before { sign_in(admin) }

      it 'returns a 200 http status' do
        get admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id)
        expect(response).to have_http_status(200)
      end

      it 'renders the show template' do
        get admin_exhibition_center_room_path(exhibition_center_id: exhibition_center.id, id: room.id)
        expect(response).to render_template(:show)
      end
    end
  end
end
