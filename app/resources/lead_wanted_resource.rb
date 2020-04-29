class LeadWantedResource < ApplicationResource
  attribute :lead_id, :integer_id

  belongs_to :lead
  belongs_to :asset_type
end
