class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
        t.string :name
        t.text :content
        t.references :template_types
    end
  end
end
