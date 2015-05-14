class House < ActiveRecord::Base
	validates :title, :user_id, :date_published,  presence:true
	validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
	belongs_to :user
end
