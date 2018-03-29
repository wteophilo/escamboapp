require 'faker'
namespace :utils do
  desc "Cria Adm fake"
  task generate_admins: :environment do
   p "Cadastrando adm fakes...."
   10.times do
   		Admin.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
   			password: '123456',
   			password_confirmation: '123456')
   end
   p "Cadastrando adm fakes.... OK"
  end
end
