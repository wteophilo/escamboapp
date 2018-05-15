require 'faker'
namespace :utils do

  desc "Setup Development"
  task setup_dev: :environment do
  imagems_path = Rails.root.join('public','system')
   puts "Executando setup para desenvolvimento"
   puts "Apagando banco...#{%x(rake db:drop)}"
   puts "Imagens public/system...#{%x(rm -rf #{imagems_path})}"
   puts "Criando banco...#{%x(rake db:create)}"
   puts %x(rake db:migrate)
   puts %x(rake db:seed)
   puts %x(rake utils:generate_admins)
   puts %x(rake utils:generate_members)
   puts %x(rake utils:generate_ads)
   puts "Setup completo"
 end


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

desc "Cria membros fake"
task generate_members: :environment do
 p "Cadastrando membros fakes...."
 10.times do
  Member.create!(
    email: Faker::Internet.email,
    password: '123456',
    password_confirmation: '123456'
    )
end
p "Cadastrando membros fakes.... OK"
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
    picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(7)}.jpg"))

    )
end
p "Cadastrando anúncios fakes...OK"
end


end