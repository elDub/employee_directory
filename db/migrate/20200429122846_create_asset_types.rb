class CreateAssetTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :asset_types do |t|
      t.string :reference_code

      t.timestamps
    end
  end
end
