class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
        t.string :name
        t.integer :major
        t.integer :minor
        t.text :url
      end
  end
end
