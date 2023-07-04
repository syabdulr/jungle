require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "returns true if all fields are filled" do
      category = Category.create(name: 'Roses')
      product = Product.create(name: 'Roses', price_cents: 4500 ,quantity: 3 , category:category)
      
      expect(product).not_to be nil
    end

    it 'returns nil if the name is missing' do
      category = Category.create(name: 'Evergreens')
      product = Product.create(name: nil, price_cents: 4500,quantity: 3 , category:category)

      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'returns nil if the price is missing' do
      category = Category.create(name: 'Evergreens')
      product = Product.create(name: 'Green bush', price_cents: nil,quantity: 3 , category:category)
    
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    

    it 'returns nil if the quantity is missing' do
      category = Category.create(name: 'Evergreens')
      product = Product.create(name: 'Green bush', price_cents: 4500,quantity: nil , category:category)

      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'returns nil if the category is missing' do
      category = Category.create(name: 'Evergreens')
      product = Product.create(name: 'Green bush', price_cents: 4500, quantity: 10 , category:nil)
   
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end