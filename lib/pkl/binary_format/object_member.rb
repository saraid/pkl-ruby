module Pkl
  class BinaryFormat
    class ObjectMember < BinaryFormat
      def initialize(*args)
        self.class.slots.zip(args).each do |slot, arg|
          instance_variable_set(:"@#{slot}", BinaryFormat.parse(arg))
        end
      end
    end

    class Property < ObjectMember
      code 0x10
      slots :key, :property_value
    end

    class Entry < ObjectMember
      code 0x11
      slots :entry_key, :entry_value
    end

    class Element < ObjectMember
      code 0x12
      slots :index, :element_value
    end
  end
end

