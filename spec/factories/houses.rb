FactoryGirl.define do
  factory :house do
    title { FFaker::CompanyIT.name }
    price { rand() * 100 }
    published false
    date_published { FFaker::Time.date }
    user
  end
end