require 'open-uri'

class Product < ActiveRecord::Base
	# attr_accessor :name, :photo, :product_id, :producer_name, :primary_category, :secondary_category, :volume_in_milliliters, :price, :alcohol_content, :is_kosher

	def self.get_all_products
		base_url = "http://lcboapi.com/products?page="

		1.upto(578) do |i|
			page_of_products = retrieve_data(base_url + "#{i}")

			page_of_products.each do |product| 
				local_product = {
					name: product['name'],
					photo: product['image_thumb_url'],
					product_id: product['id'],
					producer_name: product['producer_name'],
					primary_category: product['primary_category'],
					secondary_category: product['secondary_category'],
					volume_in_milliliters: product['volume_in_milliliters'],
					price: format_price(product['price_in_cents']),
					alcohol_content: product['alcohol_content'],
					is_kosher: product['is_kosher']
				}
			@product = Product.new(local_product)
	 		@product.save
			end
		end
	end

	def self.retrieve_data(url)
		# Retrieve JSON-formatted text from lcboapi.com
		raw_response = open(url).read

		# Parse JSON-formatted text into a Ruby Hash
		parsed_response = ActiveSupport::JSON.decode(raw_response)

		# Return just the actual result data from the response, ignoring metadata
		result = parsed_response["result"]
	end

	def self.format_price(cents_string)
    cents_string.to_f/100
  end
end