class HouseSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :published, :date_published
end
