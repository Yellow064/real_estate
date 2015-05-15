class HouseSerializer < ActiveModel::Serializer
	attributes :id, :title, :price, :published, :latitude, :longitude, :date_published
	has_one :user
end
