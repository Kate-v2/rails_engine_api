require "csv"

namespace :import do

  desc 'import merchants from csv'
  task merchants: :environment do
    file = './db/data/merchants.csv'
    CSV.foreach(file, headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  desc 'import customers from csv'
  task customers: :environment do
    file = './db/data/customers.csv'
    CSV.foreach(file, headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end

  desc 'import transactions from csv'
  task transactions: :environment do
    file = './db/data/transactions.csv'
    CSV.foreach(file, headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end

end
