class GigSerializer < ActiveModel::Serializer
  attributes :id, :brand_name, :state
  has_one :creator
end
