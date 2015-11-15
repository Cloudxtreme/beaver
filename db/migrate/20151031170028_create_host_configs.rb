class CreateHostConfigs < ActiveRecord::Migration
  def change
    create_table :host_configs do |t|
        t.string :name
        t.text :settings
      end
  end
end
