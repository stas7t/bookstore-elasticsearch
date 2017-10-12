# frozen_string_literal: true

SORT_OPTIONS =
  {
    newest_first:       { name: 'Newest first',        query: 'created_at DESC' },
    popular_first:      { name: 'Popular first',       query: 'order_items.quantity' },
    price_low_to_hight: { name: 'Price: Low to Hight', query: 'price' },
    price_hight_to_low: { name: 'Price: Hight to Low', query: 'price DESC' },
    title_a_z:          { name: 'Title: A to Z',       query: 'title' },
    title_z_a:          { name: 'Title: Z to A',       query: 'title DESC' }
  }.freeze
