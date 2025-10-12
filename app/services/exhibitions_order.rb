class ExhibitionsOrder
    def initialize(params)
        @params = params
    end

    def status_order_sql
        Arel.sql(<<~SQL
        CASE#{' '}
            WHEN start_date <= CURRENT_DATE AND end_date >= CURRENT_DATE THEN 1
            WHEN start_date > CURRENT_DATE THEN 2
            WHEN end_date < CURRENT_DATE THEN 3
            ELSE 4
        END,
        start_date ASC
        SQL
        )
    end
end
