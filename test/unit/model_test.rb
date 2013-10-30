require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

module SerialAttr
  class ModelTest < Test::Unit::TestCase

    context 'basic object' do
      setup do
        @person = FactoryGirl.build(:basic_person)
      end

      should 'list all attributes to serialize' do
        assert_equal [:name, :address, :phone_number].sort, @person.attributes_to_serialize
      end

      should 'serialize all attributes to a hash' do
        assert_equal @person.attributes, @person.serialized_to_hash
      end

      should 'serialize all attributes to json' do
        assert_json_equal @person.attributes.to_json, @person.serialized_to_json
      end
    end

    context 'object with blacklist' do
      setup do
        @person = FactoryGirl.build(:person_with_blacklist)

        @expected_attrs = @person.attributes.dup
        @expected_attrs.delete('phone_number')
      end

      should 'skip blacklisted attributes' do
        assert_equal [:address, :name], @person.attributes_to_serialize
      end

      should 'not include blacklisted attributes in hash' do
        assert_equal @expected_attrs, @person.serialized_to_hash
      end

      should 'not include blacklisted attributes in json' do
        assert_json_equal @expected_attrs.to_json, @person.serialized_to_json
      end
    end

    context 'object with whitelist' do
      setup do
        @person = FactoryGirl.build(:person_with_whitelist)
      end

      should 'include the additional whitelisted attributes' do
        assert @person.attributes_to_serialize.include?(:greeting)
      end

      should 'not duplicate attributes' do
        assert_equal @person.attributes_to_serialize.uniq, @person.attributes_to_serialize
      end
    end

    context 'person with both lists' do
      setup do
        @person = FactoryGirl.build(:person_with_both_lists)
      end

      should 'exclude blacklisted items even if on whitelist' do
        assert !@person.attributes_to_serialize.include?(:greeting)
        assert !@person.attributes_to_serialize.include?(:phone_number)
      end

      should 'include attributes from subsequent whitelists' do
        assert @person.attributes_to_serialize.include?(:city)
      end

      should 'include basic attributes not on either list' do
        assert @person.attributes_to_serialize.include?(:name)
      end
    end
  end
end