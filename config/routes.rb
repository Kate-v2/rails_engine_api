Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants,     only: [:index, :show]
      resources :customers,     only: [:index, :show]
      resources :transactions,  only: [:index, :show]
      resources :invoices,      only: [:index, :show]
      resources :items,         only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end

end



# TODO

# -- Merchants --
  # params: id, name, created_at, updated_at
  # merchants/find?params
  # merchants/find_all?params
  # merchants/random

  # merchants/:id/items
  # merchants/:id/invoices

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

  # items/:id/invoice_items
  # items/:id/merchant   NO S

  # items/most_revenue?quantity=x
  # items/most_items?quantity=x
  # items/:id/best_day

# -- Customers --
  # params: id, name, created_at, updated_at
  # customers/find?params
  # customers/find_all?params
  # customers/random

  # customers/:id/invoices
  # customers/:id/transactions

  # customers/favorite_merchant

# -- Invoice_items --
  # params: id, name, created_at, updated_at
  # invoice_items/find?params
  # invoice_items/find_all?params
  # invoice_items/random

  # invoice_items/:id/invoice  NO S
  # invoice_items/:id/item     NO S

# -- Invoices --
  # params: id, name, created_at, updated_at
  # invoices/find?params
  # invoices/find_all?params
  # invoices/random

  # invoices/:id/items
  # invoices/:id/invoice_items
  # invoices/:id/transactions
  # invoices/:id/customers
  # invoices/:id/merchant     No S


# -- Transactions --
  # params: id, name, created_at, updated_at
  # transactions/find?params
  # transactions/find_all?params
  # transactions/random

  # transactions/:id/invoice     No S
