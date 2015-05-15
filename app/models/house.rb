class House < ActiveRecord::Base
	validates :title, :user_id, :date_published, :latitude, :longitude,  presence:true
	validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
	belongs_to :user
	
	scope :filter_by_title, lambda { |title|
		where("lower(title) LIKE ?", "%#{title.downcase}%" ) 
	}
	scope :above_or_equal_to_price, lambda { |price| 
		where("price >= ?", price) 
	}
	scope :below_or_equal_to_price, lambda { |price| 
		where("price <= ?", price) 
	}
	scope :recent, -> {
		order(:updated_at)
	}
	#todo geolocation 
	scope :filter_latlng_within_radio, lambda { |lat, lng, radio|	
		# where("latitude >= 46.53227233")
		where("ACOS(SIN(?)*SIN(radians(latitude)) + COS(?)*COS(radians(latitude))*COS(radians(longitude)- ?)) * 6371 <= ?", lat.to_f,lat.to_f,lng.to_f,radio.to_i*1000)
	}

	def self.search(params = {})
		houses = params[:house_ids].present? ? House.find(params[:house_ids]) : House.all
		houses = houses.filter_latlng_within_radio(params[:lat], params[:lng], params[:radio]) if params[:lat] && params[:lng] && params[:radio]
		houses = houses.filter_by_title(params[:title]) if params[:title]
		houses = houses.above_or_equal_to_price(params[:min_price].to_f) if params[:min_price]
		houses = houses.below_or_equal_to_price(params[:max_price].to_f) if params[:max_price]
		houses = houses.recent(params[:recent]) if params[:recent].present?
		houses
	end
end
