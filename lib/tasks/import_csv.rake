require "csv"

namespace :import do

  desc 'import merchants from csv'
  task merchants: :environment do
    file = './db/data/merchants.csv'
    # CSV.foreach(file, headers: true) do |row|
    #   Merchant.create!(row.to_h)
    # end
    table = :merchants
    csv_row(file, table)
  end

  desc 'import customers from csv'
  task customers: :environment do
    file = './db/data/customers.csv'
    # CSV.foreach(file, headers: true) do |row|
    #   Customer.create!(row.to_h)
    # end
    table = :customers
    csv_row(file, table)
  end

  desc 'import transactions from csv'
  task transactions: :environment do
    file = './db/data/transactions.csv'
    # CSV.foreach(file, headers: true) do |row|
    #   Transaction.create!(row.to_h)
    # end
    table = :transactions
    csv_row(file, table)
  end

  desc 'import invoices from csv'
  task invoices: :environment do
    file = './db/data/invoices.csv'
    # CSV.foreach(file, headers: true) do |row|
    #   Invoice.create!(row.to_h)
    # end
    table = :invoices
    csv_row(file, table)
  end

  desc 'import items from csv'
  task items: :environment do
    file = './db/data/items.csv'
    # CSV.foreach(file, headers: true) do |row|
    #   Item.create!(row.to_h)
    # end
    table = :items
    csv_row(file, table)
  end

  desc 'import invoice items from csv'
  task invoice_items: :environment do
    file = './db/data/invoice_items.csv'
    # CSV.foreach(file, headers: true) do |row|
    #   InvoiceItem.create!(row.to_h)
    # end
    table = :invoice_items
    csv_row(file, table)
  end

end

# TODO - refactor imports
# TODO - just iterate over csv's in folder

def csv_row(file, table)
  CSV.foreach(file, headers: true) do |row|
    row = row.to_h
    add_to_table(table, row)
  end
end

def add_to_table(table, row)
  hash = {
    merchants:     Merchant.create!(row),
    customers:     Customer.create!(row),
    transactions:  Transaction.create!(row),
    invoices:      Invoice.create!(row),
    items:         Item.create!(row),
    invoice_items: InvoiceItem.create!(row)
  }
  hash[table]
end
