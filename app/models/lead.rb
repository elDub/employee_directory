class Lead < ApplicationRecord
  has_many :wanteds, class_name: 'LeadWanted'
end
