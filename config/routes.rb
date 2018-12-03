Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
          get 'find',          to: 'filters#show',          as: :find
          get 'find_all',      to: 'filters#index',         as: :find_all
          get 'random',        to: 'filters#random',        as: :random
          get 'revenue',       to: 'revenue#total_revenue', as: :revenue
          get 'most_revenue',  to: 'revenue#index',         as: :most_revenue
          get 'most_items',    to: 'revenue#most_items',  as: :most_items
      end
      resources :merchants, only: [:index, :show] do
        get 'revenue',                         to: 'merchants/revenue#revenue',    as: :revenue
        get 'favorite_customer',               to: 'merchants/customers#favorite_customer', as: :favorite_customer
        get 'customers_with_pending_invoices', to: 'merchants/customers#pending',  as: :pending_customer
        resources :items,    only: [:index], module: :merchants
        resources :invoices, only: [:index], module: :merchants
      end

      namespace :customers do
          get 'find',          to: 'filters#show',   as: :find
          get 'find_all',      to: 'filters#index',  as: :find_all
          get 'random',        to: 'filters#random', as: :random
      end
      resources :customers, only: [:index, :show] do
        resources :invoices,     only: [:index], module: :customers
        resources :transactions, only: [:index], module: :customers
      end

      namespace :transactions do
          get 'find',          to: 'filters#show',   as: :find
          get 'find_all',      to: 'filters#index',  as: :find_all
          get 'random',        to: 'filters#random', as: :random
      end
      resources :transactions,  only: [:index, :show] do
        get 'invoice', to: "transactions/invoices#show", as: :invoice
      end

      namespace :invoices do
          get 'find',          to: 'filters#show',   as: :find
          get 'find_all',      to: 'filters#index',  as: :find_all
          get 'random',        to: 'filters#random', as: :random
      end
      resources :invoices, only: [:index, :show] do
        resources :invoice_items, only: [:index], module: :invoices
        resources :items,         only: [:index], module: :invoices, as: :has_items
        resources :transactions,  only: [:index], module: :invoices
        get 'customer', to: 'invoices/customers#show', as: :customer
        get 'merchant', to: 'invoices/merchants#show', as: :merchant
      end

      namespace :items do
          get 'find',          to: 'filters#show',   as: :find
          get 'find_all',      to: 'filters#index',  as: :find_all
          get 'random',        to: 'filters#random', as: :random
      end
      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index], module: :items
        get 'merchant', to: 'items/merchants#show', as: :merchant
      end

      namespace :invoice_items do
          get 'find',          to: 'filters#show',   as: :find
          get 'find_all',      to: 'filters#index',  as: :find_all
          get 'random',        to: 'filters#random', as: :random
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
  # DONE-ISH merchants/find?params
  # DONE-ISH merchants/find_all?params
  # DONE-ISH merchants/random

  # DONE merchants/:id/items
  # DONE merchants/:id/invoices

  # DONE merchants/revenue
  # DONE merchants/most_revenue?quantity=x
  # DONE merchants/most_items?quantity=x
  # DONE merchants/:id/revenue
  # merchants/:id/revenue?date=x
  # DONE merchants/:id/favorite_customer
  # DONE merchants/:id/customers_with_pending_invoices

# -- Items --
  # params: id, name, created_at, updated_at
  # DONE-ISH items/find?params
  # DONE-ISH items/find_all?params
  # DONE-ISH items/random

  # DONE items/:id/invoice_items
  # DONE items/:id/merchant   NO S

  # items/most_revenue?quantity=x
  # items/most_items?quantity=x
  # items/:id/best_day

# -- Customers --
  # params: id, name, created_at, updated_at
  # DONE-ISH customers/find?params
  # DONE-ISH customers/find_all?params
  # DONE-ISH customers/random

  # DONE customers/:id/invoices
  # DONE customers/:id/transactions

  # customers/favorite_merchant

# -- Invoice_items --
  # params: id, name, created_at, updated_at
  # DONE-ISH invoice_items/find?params
  # DONE-ISH invoice_items/find_all?params
  # DONE-ISH invoice_items/random

  # DONE invoice_items/:id/invoice  NO S
  # DONE invoice_items/:id/item     NO S

# -- Invoices --
  # params: id, name, created_at, updated_at
  # DONE-ISH invoices/find?params
  # DONE-ISH invoices/find_all?params
  # DONE-ISH invoices/random

  # DONE invoices/:id/items
  # DONE invoices/:id/invoice_items
  # DONE invoices/:id/transactions
  # DONE invoices/:id/customers
  # DONE invoices/:id/merchant     No S


# -- Transactions --
  # params: id, name, created_at, updated_at
  # DONE-ISH transactions/find?params
  # DONE-ISH transactions/find_all?params
  # DONE-ISH transactions/random

  # DONE transactions/:id/invoice     No S
