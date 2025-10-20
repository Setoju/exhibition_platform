require 'rails_helper'

RSpec.describe ExhibitionsFilter do
    let(:exhibition1) { create(:exhibition) }
    let(:exhibition2) { create(:exhibition) }
    let(:exhibition3) { create(:exhibition) }
    let(:exhibitions) { Exhibition.all }

    describe '#filter' do
        context 'when filtering by name' do
            it 'returns exhibitions matching the name' do
                params = { search_name: exhibition1.name }
                filtered = ExhibitionsFilter.new(exhibitions, params).apply_filters
                expect(filtered).to include(exhibition1)
                expect(filtered).not_to include(exhibition2, exhibition3)
            end
        end

        context 'when filtering by exhibition type' do
            it 'returns exhibitions matching the type' do
                params = { exhibition_type_id: exhibition2.exhibition_type_id }
                filtered = ExhibitionsFilter.new(exhibitions, params).apply_filters
                expect(filtered).to include(exhibition2)
                expect(filtered).not_to include(exhibition1, exhibition3)
            end
        end

        context 'when filtering by center name' do
            it 'returns exhibitions matching the center name' do
                params = { exhibition_center: exhibition3.exhibition_center.name }
                filtered = ExhibitionsFilter.new(exhibitions, params).apply_filters
                expect(filtered).to include(exhibition3)
            end
        end

        context 'when filtering by multiple criteria' do
            it 'returns exhibitions matching all criteria' do
                params = { 
                    search_name: exhibition1.name, 
                    exhibition_type_id: exhibition1.exhibition_type_id,
                    exhibition_center: exhibition1.exhibition_center.name
                }
                filtered = ExhibitionsFilter.new(exhibitions, params).apply_filters
                expect(filtered).to include(exhibition1)
                expect(filtered).not_to include(exhibition2, exhibition3)
            end
        end

        context 'when no filters are applied' do
            it 'returns all exhibitions' do
                params = {}
                filtered = ExhibitionsFilter.new(exhibitions, params).apply_filters
                expect(filtered).to include(exhibition1, exhibition2, exhibition3)
            end
        end
    end
end