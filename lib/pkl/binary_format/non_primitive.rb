module Pkl
  class BinaryFormat
    class NonPrimitive < BinaryFormat
    end

    class TypedDynamic < NonPrimitive
      code 0x1
      slots :class_name, :enclosing_module_uri, :object_members
    end

    class Map < NonPrimitive
      code 0x2
      slots :map
    end

    class Mapping < NonPrimitive
      code 0x3
      slots :map
    end

    class List < NonPrimitive
      code 0x4
      slots :members
    end

    class Listing < NonPrimitive
      code 0x5
      slots :members
    end

    class Set < NonPrimitive
      code 0x6
      slots :members
    end

    class Duration < NonPrimitive
      code 0x7
      slots :value, :unit
    end

    class DataSize < NonPrimitive
      code 0x8
      slots :value, :unit
    end

    class Pair < NonPrimitive
      code 0x9
      slots :first, :second
    end

    class IntSeq < NonPrimitive
      code 0xA
      slots :start, :end, :step
    end

    class Regex < NonPrimitive
      code 0xB
      slots :string
    end

    class Class < NonPrimitive
      code 0xC
    end

    class TypeAlias < NonPrimitive
      code 0xD
    end

  end
end
