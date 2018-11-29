require "csv"

namespace :import do

  desc 'import merchants from csv'
  task merchants: :environment do
    file = './db/data/merchants.csv'
    add_to_table(file, Merchant)
  end

  desc 'import customers from csv'
  task customers: :environment do
    file = './db/data/customers.csv'
    add_to_table(file, Customer)
  end

  desc 'import items from csv'
  task items: :environment do
    file = './db/data/items.csv'
    add_to_table(file, Item)
  end

  desc 'import invoices from csv'
  task invoices: :environment do
    file = './db/data/invoices.csv'
    add_to_table(file, Invoice)
  end

  desc 'import transactions from csv'
  task transactions: :environment do
    file = './db/data/transactions.csv'
    add_to_table(file, Transaction)
  end

  desc 'import invoice items from csv'
  task invoice_items: :environment do
    file = './db/data/invoice_items.csv'
    add_to_table(file, InvoiceItem)
  end

end

def add_to_table(file, model)
  CSV.foreach(file, headers: true) do |row|
    model.create!(row.to_h)
  end
end
