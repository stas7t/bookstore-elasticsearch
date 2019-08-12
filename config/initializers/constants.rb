# frozen_string_literal: true

SORT_OPTIONS =
  {
    newest_first:       { name: 'Newest first',
                          query: 'created_at DESC',
                          es: { field: 'publication_year', order: 'desc' } },

    popular_first:      { name: 'Popular first',
                          query: 'order_items.quantity',
                          es: { field: 'sales', order: 'desc' } },

    price_low_to_hight: { name: 'Price: Low to Hight',
                          query: 'price',
                          es: { field: 'price', order: 'asc' } },

    price_hight_to_low: { name: 'Price: Hight to Low',
                          query: 'price DESC',
                          es: { field: 'price', order: 'desc' } },

    title_a_z:          { name: 'Title: A to Z',
                          query: 'title',
                          es: { field: 'title', order: 'asc' } },

    title_z_a:          { name: 'Title: Z to A',
                          query: 'title DESC',
                          es: { field: 'title', order: 'desc' } }
  }.freeze
