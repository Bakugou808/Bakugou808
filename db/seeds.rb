#clear all the tables
#add data to your tables
#start testing
#create class methods that call active record methods in them
#
require_relative '../app/api_communications.rb'
strain_hash = all_strain_names_and_id

User.delete_all
CannabisStrainId.delete_all
MedicineCabinetItem.delete_all


u1 = User.create(name: "j1", password:"112233")
u2 = User.create(name: "j2", password:"123")
u3 = User.create(name: "j3", password:"1234")
u4 = User.create(name: "j4", password:"12345")


strain_hash.each{|name, id| CannabisStrainId.create(name:name, strain_id: id)}

# s1 = CannabisStrainId.create(name: "sour diesel", strain_id: 4)
# s2 = CannabisStrainId.create(name: "jack", strain_id: 3)
# s3  = CannabisStrainId.create(name: "kush", strain_id: 2)
# s4 = CannabisStrainId.create(name: "cherry", strain_id: 1)

# mc1 = MedicineCabinetItem.create(user_id: u1.id, strain_name: "test", strain_id: 3, my_description: "amazing", rating: 5)