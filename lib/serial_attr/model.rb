require 'active_support/concern'

module SerialAttr
  module Model
    extend ActiveSupport::Concern

    # Generates the list of attribute names for serialization
    #
    # @return [Array] list of attribute names to serialize
    def attributes_to_serialize
      attrs = []

      attrs |= self.attributes.keys.collect(&:to_sym) if respond_to?(:attributes)

      attrs |= self.class.serial_attr_whitelist
      attrs -= self.class.serial_attr_blacklist

      attrs.sort
    end

    # Serialize attributes listed in #attributes_to_serialize to a ruby hash
    #
    # @return [Hash] serialized attributes
    def serialized_to_hash
      serialized = HashWithIndifferentAccess.new
      self.attributes_to_serialize.each { |key| serialized[key] = send(key) }

      serialized
    end

    # Serialize attributes listed in #attributes_to_serialize to JSON
    #
    # @return [String] attributes serialized to JSON
    def serialized_to_json
      self.serialized_to_hash.to_json
    end

    module ClassMethods
      attr_writer :serial_attr_whitelist
      def serial_attr_whitelist
        @serial_attr_whitelist ||= []
      end

      attr_writer :serial_attr_blacklist
      def serial_attr_blacklist
        @serial_attr_blacklist ||= []
      end

      # Adds list of attributes to the serialization whitelist
      #
      # Note: Blacklist takes precedence over whitelist
      #
      # @example add a list of attributes
      #    class Person
      #      include SerialAttr::Model
      #
      #      serial_attr :name, :address, :phone_number
      #    end
      #
      # @param [Symbol, Array] args list of attributes to add
      def serial_attr(*args)
        self.serial_attr_whitelist |= args
      end

      # Add list of attributes to the serialization blacklist and skip on serialization
      #
      # Note: Blacklist takes precedence over whitelist
      #
      # @example skip a list of attributes
      #    class Person
      #      include ActiveAttr::Model
      #      include SerialAttr::Model
      #
      #      attribute :name
      #      attribute :address
      #      attribute :phone_number
      #
      #      skip_serial_attr :phone_number
      #    end
      #
      # @param [Symbol, Array] args list of attributes to skip in serialization
      def skip_serial_attr(*args)
        self.serial_attr_blacklist |= args
      end
    end

  end
end