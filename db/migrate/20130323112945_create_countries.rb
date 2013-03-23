class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name

      t.timestamps
    end
    add_index :countries, :name, unique: true

    say_with_time "Seeding countries" do
      %w[Молдова Украина Россия Белоруссия Казахстан Италия].each do |name|
        Country.create name: name
      end
    end
  end
end
