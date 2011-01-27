# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Mongoid.database.collections.each do |coll|
  coll.remove
end

courier = Courier::Individual::create_from :munich
courier.save!

# couriers = Courier.create_random(10, :from => :munich, :type => :individual)

p couriers
couriers.each {|c| c.save! }

puts "In database"

puts "Couriers: #{Courier.all.to_a}"
puts "Individual Couriers: #{Courier::Individual.all.to_a}"
puts "Company Couriers: #{Courier::Company.all.to_a}"

