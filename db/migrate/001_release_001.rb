class Release001 < ActiveRecord::Migration[5.0]
  def change
    create_table :colleges do |t|
      t.string :name,           null: false, index: true
      t.string :alias,          null: true, index: true
      t.integer :enrollment,    null: false
      t.string :address,        null: false
      t.string :city,           null: false
      t.string :state,          null: false
      t.string :zip,            null: false
      t.float :latitude,        null: false, index: true
      t.float :longitude,       null: false, index: true
    end

    create_table :employees do |t|
      t.belongs_to :college
      t.string :first_name,     null: false, index: true
      t.string :last_name,      null: false, index: true
      t.string :email,          null: false, index: true
    end

    create_table :labels do |t|
      t.string :code,           null: false, index: true
      t.string :text,           null: false
    end

    create_table :colleges_labels, id: false do |t|
      t.belongs_to :college,    null: false
      t.belongs_to :label,      null: false
    end
  end
end
