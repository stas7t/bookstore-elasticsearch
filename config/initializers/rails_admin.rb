RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  [Address, Admin, Authorship, Billing, CreditCard, OrderItem, Shipping, User].each do |model|
    config.excluded_models << model
  end

  config.model Book do
    list do
      field :cover do
        formatted_value do
          bindings[:view].tag(:img, { src: bindings[:object].cover_url.url(:thumb) }) << value
        end
      end
      field :category
      field :title
      field :authors
      field :description
      field :price
    end

    show do
      field :title
      field :description
      field :price
      field :publication_year
      field :height
      field :width
      field :depth
      field :materials
      field :authors
      field :category
      field :cover, :carrierwave
      field :images, :carrierwave
    end

    edit do
      field :title
      field :description
      field :price
      field :publication_year
      field :height
      field :width
      field :depth
      field :materials
      field :authors
      field :category
      field :cover, :carrierwave
      field :images, :carrierwave
    end
  end

  config.model Review do
    list do
      scopes [:unprocessed, :processed]
      field :book
      field :title
      field :created_at
      field :user
      field :status
    end

    edit do
      field :status
    end
  end

  config.model Order do
    list do
      scopes [:in_progress, :delivered, :canceled]
      field :number
      field :created_at
      field :status
    end

    edit do
      field :status
    end
  end
end
