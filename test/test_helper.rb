require 'bundler/setup'

require 'test/unit'
require 'shoulda-context'
require 'factory_girl'
require 'active_attr'
require 'active_attr/model'
require 'faker'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'unit'))

require 'serial_attr'

class Test::Unit::TestCase
  def assert_json_equal(expected, actual, msg=nil)
    assert_equal JSON::parse(expected), JSON::parse(actual), msg
  end
end

class BasicPerson
  include ActiveAttr::Model
  include SerialAttr::Model

  attribute :name
  attribute :phone_number
  attribute :address
end

class PersonWithBlacklist < BasicPerson
  skip_serial_attr :phone_number
end

class PersonWithWhitelist < BasicPerson
  serial_attr :greeting, :phone_number

  def greeting
    @greeting ||= Faker::Lorem.sentence
  end
end

class PersonWithBothLists < PersonWithWhitelist
  serial_attr :city
  skip_serial_attr :phone_number, :greeting

  def city
    @city ||= Faker::Address.city
  end
end

FactoryGirl.define do
  factory :basic_person do
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
  end

  factory :person_with_blacklist do
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
  end

  factory :person_with_whitelist do
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
  end

  factory :person_with_both_lists do
    name { Faker::Name.name }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
  end
end