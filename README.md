SerialAttr
=============================

SerialAttr makes it simple to keep track of which attributes of an object to serialize. It also provides helpers for
serializing those attributes into a ruby hash and json.


Installation
-----------------------------

Add this line to your application's Gemfile:

    gem 'serial_attr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serial_attr


Usage
-----------------------------

To use on any ruby object, just include `SerialAttr::Object`. It will then provide you with some helper methods to
create a list of attribute names to serialize.

    class MyObj
      include SerialAttr::Object

      serial_attr :name, :address, :phone_number
      skip_serial_attr :scratch_pad
    end

`serial_attr` simply takes in a list of attributes to add to the whitelist. `skip_serial_attr` will add those
attributes to the blacklist. The blacklist takes precedence over the whitelist.

If the object responds to `attributes` (like ActiveRecord) or `redis_attributes` (like RedisAttr) those will
*automatically* be included in the whitelist. Use skip_serial_attr to exclude them.


Contributing
-----------------------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
