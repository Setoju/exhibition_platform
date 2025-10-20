require 'rails_helper'

RSpec.describe Admin::ExhibitionCentersFilter, type: :service do
    let (:exhibition_center1) { create(:exhibition_center) }
    let (:exhibition_center2) { create(:exhibition_center) }
    let (:exhibition_center3) { create(:exhibition_center) }
    let (:exhibition_centers) { ExhibitionCenter.all }

    describe '#apply_filters' do
        context 'when filtering by name' do
            it 'returns exhibition centers matching the name' do
                params = { search_name: exhibition_center1.name }
                filter = Admin::ExhibitionCentersFilter.new(exhibition_centers, params)
                result = filter.apply_filters
                expect(result).to include(exhibition_center1)
                expect(result).not_to include(exhibition_center2, exhibition_center3)
            end
        end

        context 'when filtering by address' do
            it 'returns exhibition centers matching the address' do
                params = { search_address: exhibition_center2.address }
                filter = Admin::ExhibitionCentersFilter.new(exhibition_centers, params)
                result = filter.apply_filters
                expect(result).to include(exhibition_center2)
                expect(result).not_to include(exhibition_center1, exhibition_center3)
            end
        end

        context 'when filtering by contact info' do
            it 'returns exhibition centers matching the contact email' do
                params = { search_contact: exhibition_center3.contact_email }
                filter = Admin::ExhibitionCentersFilter.new(exhibition_centers, params)
                result = filter.apply_filters
                expect(result).to include(exhibition_center3)
                expect(result).not_to include(exhibition_center1, exhibition_center2)
            end

            it 'returns exhibition centers matching the contact phone' do
                params = { search_contact: exhibition_center1.contact_phone }
                filter = Admin::ExhibitionCentersFilter.new(exhibition_centers, params)
                result = filter.apply_filters
                expect(result).to include(exhibition_center1)
                expect(result).not_to include(exhibition_center2, exhibition_center3)
            end
        end

        context 'when no filters are applied' do
            it 'returns all exhibition centers' do
                params = {}
                filter = Admin::ExhibitionCentersFilter.new(exhibition_centers, params)
                result = filter.apply_filters
                expect(result).to include(exhibition_center1, exhibition_center2, exhibition_center3)
            end
        end
    end
end
