require 'rails_helper'

RSpec.describe Item, type: :model do

  it {should belongs_to(:merchant)}

end
