class CreateProvisions < ActiveRecord::Migration
  def change
    create_table :provisions do |t|
        t.string :uuid
        t.text :content
      end
  end
end
