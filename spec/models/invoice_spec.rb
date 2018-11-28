require 'rails_helper'

RSpec.describe Invoice, type: :model do

  it {should belongs_to(:customer)}
  it {should belongs_to(:merchant)}


end
