require 'rails_helper'

RSpec.describe Admin::RoomsFilter, type: :service do
    let(:room1) { create(:room) }
    let(:room2) { create(:room) }
    let(:room3) { create(:room) }
    let(:rooms) { Room.all }

    describe '#filter' do
        context 'when filtering by name' do
            it 'returns rooms matching the name' do
                params = { search_name: room1.name }
                filtered = Admin::RoomsFilter.new(rooms, params).apply_filters
                expect(filtered).to include(room1)
                expect(filtered).not_to include(room2, room3)
            end
        end

        context 'when filtering by physical parameters' do
            it 'returns rooms with width greater than or equal to the minimum' do
                min_width = [ room2.width, room3.width, room1.width ].min
                params = { min_width: min_width }
                filtered = Admin::RoomsFilter.new(rooms, params).apply_filters
                expect(filtered).to include(room1, room2, room3)
            end

            it 'returns rooms with height greater than or equal to the minimum' do
                min_height = [ room2.height, room3.height, room1.height ].min
                params = { min_height: min_height }
                filtered = Admin::RoomsFilter.new(rooms, params).apply_filters
                expect(filtered).to include(room1, room2, room3)
            end

            it 'returns rooms with depth greater than or equal to the minimum' do
                min_depth = [ room2.depth, room3.depth, room1.depth ].min
                params = { min_depth: min_depth }
                filtered = Admin::RoomsFilter.new(rooms, params).apply_filters
                expect(filtered).to include(room1, room2, room3)
            end

            it 'returns no rooms if none meet the width criteria' do
                params = { min_width: 10000 }
                filtered = Admin::RoomsFilter.new(rooms, params).apply_filters
                expect(filtered).to be_empty
            end
        end

        context 'when no filters are applied' do
            it 'returns all rooms' do
                params = {}
                filtered = Admin::RoomsFilter.new(rooms, params).apply_filters
                expect(filtered).to include(room1, room2, room3)
            end
        end
    end
end
