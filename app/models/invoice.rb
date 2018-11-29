class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  # enum status: [:shipped]  ----- they're 100% shipped ?!??

end
