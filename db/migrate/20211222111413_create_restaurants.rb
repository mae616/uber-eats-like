class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false, comment: 'レストランの名前'
      t.integer :fee, null: false, default: 0, comment: 'レストランの配送料'
      t.integer :time_required, null: false, comment: 'レストランの配送時間'

      t.timestamps
    end
  end
end
