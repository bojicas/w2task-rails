class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.column :name, :string 
      t.column :special, :boolean, :default => false
    end
    names = ActionView::Helpers::FormOptionsHelper::COUNTRIES 
    names.each do |country_name| 
      Country.create(:name => country_name) 
    end
  end

  def self.down
    drop_table :countries
  end
end
