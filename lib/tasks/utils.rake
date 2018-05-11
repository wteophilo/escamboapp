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
   			password_confirmation: '123456',
        role: [0,1].sample)
   end
   p "Cadastrando adm fakes.... OK"
  end

  desc "Cria Anúncios fake"
  task generate_ads: :environment do
   p "Cadastrando anúncios fakes...."
   100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: Faker::Lorem.sentence([2,3,4,5].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(2)}.jpg"))

      )
   end
   p "Cadastrando anúncios fakes...OK"
  end
end