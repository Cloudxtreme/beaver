class CreateTemplateTypes < ActiveRecord::Migration
  def change
    create_table :template_types do |t|
        t.string :name
      end
  end
end
