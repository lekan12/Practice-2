class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :headline
      t.text :summary
      t.text :link
      t.string :writer

      t.timestamps null: false
    end
  end
end
