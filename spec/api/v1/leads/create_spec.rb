require 'rails_helper'

RSpec.describe "leads#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/leads", payload
  end

  let!(:first_asset_type) { create(:asset_type, reference_code: 'first-type') }
  let!(:second_asset_type) { create(:asset_type, reference_code: 'second-type') }

  describe 'elDub' do
    let(:payload) do
      {
        data: {
          type: 'leads',
          attributes: {
            channel: 'manual'
          },
          relationships: {
            wanteds: {
              data: [
                {
                  type: 'lead_wanteds',
                  :'temp-id' => 'temp-id-28',
                  method: 'create'
                },
                {
                  type: 'lead_wanteds',
                  :'temp-id' => 'temp-id-31',
                  method: 'create'
                }
              ]
            }
          }
        },
        included: [
          {
            type: 'lead_wanteds',
            :'temp-id' => 'temp-id-28',
            relationships: {
              asset_type: {
                data: {
                  type: 'asset_types',
                  id: second_asset_type.id,
                  method: 'update'
                }
              }
            }
          },
          {
            type: 'asset_types',
            id: second_asset_type.id,
            attributes: {
              reference_code: 'second-type-changed'
            }
          },
          {
            type: 'lead_wanteds',
            :'temp-id' => 'temp-id-31',
            relationships: {
              asset_type: {
                data: {
                  type: 'asset_types',
                  id: second_asset_type.id,
                  method: 'update'
                }
              }
            }
          },
          {
            type: 'asset_types',
            id: second_asset_type.id,
            attributes: {
              reference_code: 'second-type-changed'
            }
          }
        ]
      }
    end

    it 'does NOT update first_asset_type' do
      make_request
      expect(first_asset_type.reload.reference_code).to eq('first-type')
    end

    it 'updates second_asset_type' do
      make_request
      expect(second_asset_type.reload.reference_code).to eq('second-type-changed')
    end

    it 'creates two LeadWanted records' do
      expect{ make_request }.to change{ LeadWanted.count }.by(2)
      expect(LeadWanted.first.asset_type_id).to eq(second_asset_type.id)
      expect(LeadWanted.last.asset_type_id).to eq(second_asset_type.id)
    end
  end
end
