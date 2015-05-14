class House < ActiveRecord::Base
	validates :title, :user_id, :date_published,  presence:true
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
	scope :filter_by_radio, lambda { |radio|
		where("lower(title) LIKE ?", "%#{title.downcase}%" ) 
	}

	def self.search(params = {})
		houses = params[:house_ids].present? ? House.find(params[:house_ids]) : House.all

		houses = houses.filter_by_title(params[:title]) if params[:title]
		houses = houses.above_or_equal_to_price(params[:min_price].to_f) if params[:min_price]
		houses = houses.below_or_equal_to_price(params[:max_price].to_f) if params[:max_price]
		houses = houses.recent(params[:recent]) if params[:recent].present?

		houses
	end
end
