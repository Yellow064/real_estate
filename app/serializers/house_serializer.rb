class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :published, :date_published
  has_one :user
end
