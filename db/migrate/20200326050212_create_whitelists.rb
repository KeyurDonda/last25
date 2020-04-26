class CreateWhitelists < ActiveRecord::Migration
  def change
    create_table :whitelists do |t|
      t.string :url, limit: 500
      t.string :name, limit: 500

      t.timestamps
    end
  end
end
