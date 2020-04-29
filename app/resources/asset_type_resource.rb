class AssetTypeResource < ApplicationResource
  attribute :reference_code, :string

  has_many :wanteds, resource: LeadWantedResource
end
