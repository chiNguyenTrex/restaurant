FactoryBot.define do
  factory :restaurant do
    name FFaker::Company.name
    address "#{FFaker::Address.street_address}, #{FFaker::Address.city}, #{FFaker::Address.country}"
  end
end
