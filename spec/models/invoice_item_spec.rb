require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  it { should belong_to(:invoice) }
  it { should belong_to(:item) }
  it { should have_one(:customer).through(:invoice) }
  it { should have_one(:merchant).through(:invoice) }

  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit_price) }


  describe "it can filter by: " do

    before(:each) do
      @merchant = create(:merchant)
      @item1 = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)

      @customer = create(:customer)
      @inv1 = create(:invoice, merchant: @merchant, customer: @customer)

      @inv_item_1 = create(:invoice_item, invoice: @inv1, item: @item1)
      @inv_item_2 = create(:invoice_item, invoice: @inv1, item: @item2)
    end

    it 'item name' do
      inv_items = InvoiceItem.name_is(@item1.name).to_a
      inv_item = inv_items.first
      expect(inv_items.class).to eq(Array)
      expect(inv_item.class).to  eq(InvoiceItem)
      expect(inv_item.id).to     eq(@inv_item_1.id)
    end

    it 'ID' do
      inv_item = InvoiceItem.id_is(@inv_item_1.id).to_a
      expect(inv_item.class).to eq(Array)
      expect(inv_item.first.class).to eq(InvoiceItem)
      expect(inv_item.first.id).to eq(@inv_item_1.id)
    end


    describe 'dates' do

      before(:each) do
        @inv_item_1 = create(:invoice_item, invoice: @inv1, item: @item1)
        sleep(0.2)
        @inv_item_2 = create(:invoice_item, invoice: @inv1, item: @item2)
      end

      it 'created_at' do
        skip
        expect(@inv_item_1.created_at).to_not eq(@inv_item_2.created_at)
        invoice_items = InvoiceItem.created_on(@inv_item_1.created_at).to_a
        invoice_item = invoice_items.first
        expect(invoice_items.class).to eq(Array)
        expect(invoice_items.count).to eq(1)
        expect(invoice_item.class).to  eq(InvoiceItem)
        expect(invoice_item.id).to     eq(@inv_item_1.id)
      end

      it 'can find by updated_at' do
        skip
        expect(@inv_item_1.updated_at).to_not eq(@inv_item_2.updated_at)
        invoice_items = InvoiceItem.updated_on(@inv_item_1.updated_at).to_a
        customer = invoice_items.first
        expect(invoice_items.class).to eq(Array)
        expect(invoice_items.count).to eq(1)
        expect(customer.class).to  eq(InvoiceItem)
        expect(customer.id).to     eq(@inv_item_1.id)
      end
    end
  end

  describe 'it can select a random invoice_item' do

    before(:each) do
      @merchant = create(:merchant)
      @item1 = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)

      @customer = create(:customer)
      @inv1 = create(:invoice, merchant: @merchant, customer: @customer)
      @inv2 = create(:invoice, merchant: @merchant, customer: @customer)

      @inv_item_1 = create(:invoice_item, invoice: @inv1, item: @item1)
      @inv_item_2 = create(:invoice_item, invoice: @inv1, item: @item2)
      @inv_item_1 = create(:invoice_item, invoice: @inv2, item: @item1)
    end

    it 'sends only one random invoice_item' do
      invoice_item = InvoiceItem.random
      expect(invoice_item.class).to eq(InvoiceItem)
    end
  end



end
