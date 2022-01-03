class CreateLineFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :line_foods do |t|
      t.references :food, null: false, foreign_key: true, comment: 'フードへの参照'
      t.references :restaurant, null: false, foreign_key: true, comment: 'レストランへの参照'
      t.references :order, foreign_key: true, '注文への参照'
      t.integer :count, null: false, default: 0, comment: '注文数'
      t.boolean :active, null: false, default: false, comment: '論理削除用フラグ'

      t.timestamps
    end
  end
end
