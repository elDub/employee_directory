class LeadResource < ApplicationResource
  attribute :channel, :string

  has_many :wanteds, resource: LeadWantedResource
end
