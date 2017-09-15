module SortOptions
  def self.sort_options
    { 
      newest_first:       {name: 'Newest first',        option: 'created_at DESC'},
      popular_first:      {name: 'Popular first',       option: 'created_at'},
      price_low_to_hight: {name: 'Price: Low to Hight', option: 'price'},
      price_hight_to_low: {name: 'Price: Hight to Low', option: 'price DESC'},
      title_a_z:          {name: 'Title: A to Z',       option: 'title'},
      title_z_a:          {name: 'Title: Z to A',       option: 'title DESC'}
    }
  end
end