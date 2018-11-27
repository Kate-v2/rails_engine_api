require "csv"

namespace :import do

  desc 'import merchants from csv'
  task merchants: :environment do
    # file = "/Users/kt/turing/3mod/projects/rails_engine_api/db/data/merchants.csv"
    file = './db/data/merchants.csv'
    CSV.foreach(file, headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

end
