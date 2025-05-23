module CollectionPaginator
    extend ActiveSupport::Concern
    
    def paginate_collection(scope, order_by: :created_at, search_column: nil, search_value: nil, page: 1, per_page: 25)
        page = page.to_i
        per_page = per_page.to_i

        scope = scope.where("#{search_column} ILIKE ?", "%#{search_value}%") if search_column.present? && search_value.present?

        ordered_scope = scope.order(order_by)

        paginated = ordered_scope.page(page).per(per_page)

        # ← Validación para evitar páginas vacías si alguien envia un número inválido
        if page > paginated.total_pages && paginated.total_pages > 0
            paginated = ordered_scope.page(paginated.total_pages).per(per_page)
        end

        {
            records: paginated,
            pagination: {
                current_page: paginated.current_page,
                total_pages: paginated.total_pages,
                per_page: paginated.limit_value,
                total_count: paginated.total_count
            }
        }
    end
end