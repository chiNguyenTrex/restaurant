FactoryBot.define do
  factory :restaurant do
    name {FFaker::Company.unique.name}
    address do
      "#{FFaker::Address.unique.street_address}, #{FFaker::Address.unique.city}, "\
        "#{FFaker::Address.unique.country}"
    end
  end
end
