require 'rails_helper'

RSpec.describe Customer, type: :model do

  it { should have_many(:invoices) }
  # it { should have_many(:transactions) }
  it { should have_many(:transactions).through(:invoices) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

end
