Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      # namespace :merchants do
      #   get 'find',          to: 'merchants#show',  as: :find
      #   get 'find_all',      to: 'merchants#index', as: :find_all
      #   get 'random',        to: 'merchants#show',  as: :random
      #   get 'revenue',       to: 'revenue#show',    as: :revenue
      #   get 'most_revenue',  to: 'merchants#index', as: :most_revenue
      #   get 'most_items',    to: 'merchants#index', as: :most_items
      # end

      resources :merchants, only: [:index, :show] do
        resources :items,    only: [:index], module: :merchants
        resources :invoices, only: [:index], module: :merchants
      end

      resources :customers, only: [:index, :show] do
        resources :invoices,     only: [:index], module: :customers
        resources :transactions, only: [:index], module: :customers
      end

      resources :transactions,  only: [:index, :show] do
        get 'invoice', to: "transactions/invoices#show", as: :invoice
      end

      resources :invoices, only: [:index, :show] do
        resources :invoice_items, only: [:index], module: :invoices
        resources :items,         only: [:index], module: :invoices, as: :has_items
        resources :transactions,  only: [:index], module: :invoices
        get 'customer', to: 'invoices/customers#show', as: :customer
        get 'merchant', to: 'invoices/merchants#show', as: :merchant
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index], module: :items
        get 'merchant', to: 'items/merchants#show', as: :merchant
      end

      resources :invoice_items, only: [:index, :show] do
        get 'invoice', to: 'invoice_items/invoices#show', as: :invoice
        get 'item',    to: 'invoice_items/items#show',    as: :item
      end



    end
  end

end



# TODO

# -- Merchants --
  # params: id, name, created_at, updated_at
  # merchants/find?params
  # merchants/find_all?params
  # merchants/random

  # DONE merchants/:id/items
  # DONE merchants/:id/invoices

  # merchants/revenue
  # merchants/most_revenue?quantity=x
  # merchants/most_items?quantity=x
  # merchants/:id/revenue
  # merchants/:id/revenue?date=x
  # merchants/:id/favorite_customer
  # merchants/:id/customers_with_pending_invoices

# -- Items --
  # params: id, name, created_at, updated_at
  # items/find?params
  # items/find_all?params
  # items/random

  # DONE items/:id/invoice_items
  # DONE items/:id/merchant   NO S

  # items/most_revenue?quantity=x
  # items/most_items?quantity=x
  # items/:id/best_day

# -- Customers --
  # params: id, name, created_at, updated_at
  # customers/find?params
  # customers/find_all?params
  # customers/random

  # DONE customers/:id/invoices
  # DONE customers/:id/transactions

  # customers/favorite_merchant

# -- Invoice_items --
  # params: id, name, created_at, updated_at
  # invoice_items/find?params
  # invoice_items/find_all?params
  # invoice_items/random

  # DONE invoice_items/:id/invoice  NO S
  # DONE invoice_items/:id/item     NO S

# -- Invoices --
  # params: id, name, created_at, updated_at
  # invoices/find?params
  # invoices/find_all?params
  # invoices/random

  # DONE invoices/:id/items
  # DONE invoices/:id/invoice_items
  # DONE invoices/:id/transactions
  # DONE invoices/:id/customers
  # DONE invoices/:id/merchant     No S


# -- Transactions --
  # params: id, name, created_at, updated_at
  # transactions/find?params
  # transactions/find_all?params
  # transactions/random

  # DONE transactions/:id/invoice     No S
