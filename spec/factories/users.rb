FactoryGirl.define do
  factory :user do
    email "mypuser@gmail.com"
    password "12345678"
    firstname "dummy"
    lastname  "lastname"
    confirmed_at "2016-05-19 10:06:58"
  end

  factory :admin, class: User do
    email "admin@admin.com"
    password "123456789"
    firstname "admin"
    lastname  "admin"
    confirmed_at "2016-05-19 10:06:58"
    admin true
  end

  factory :bob_non_admin, class: User do
    email "bob@admin.com"
    password "123456789"
    firstname "admin"
    lastname  "admin"
    confirmed_at "2016-05-19 10:06:58"
  end

  factory :foo, class: User do
    email "foo@admin.com"
    password "123456789"
    firstname "admin"
    lastname  "admin"
    confirmed_at "2016-05-19 10:06:58"
    admin true
  end

end
