module Admin
    class ExhibitionCentersFilter
        def initialize(exhibition_centers, params)
            @exhibition_centers = exhibition_centers
            @params = params
        end

        def apply_filters
            @exhibition_centers = @exhibition_centers.where("name ILIKE ?", "%#{@params[:search_name]}%") if @params[:search_name].present?
            @exhibition_centers = @exhibition_centers.where("address ILIKE ?", "%#{@params[:search_address]}%") if @params[:search_address].present?

            if @params[:search_contact].present?
                contact_search = "%#{@params[:search_contact]}%"
                @exhibition_centers = @exhibition_centers.where("contact_email ILIKE ? OR contact_phone ILIKE ?", contact_search, contact_search)
            end

            @exhibition_centers
        end
    end
end
