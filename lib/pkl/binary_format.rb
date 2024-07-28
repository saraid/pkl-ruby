module Pkl
  class BinaryFormat
    def self.parse(message)
      case message
      when Array
        code, *slots = message
        @@lookup[code].new(*slots)
      else message
      end
    rescue => e
      byebug
      puts message.inspect
      raise
    end

    def self.code(arg = nil)
      raise NoMethodError("code undefined for #{self.class}") if arg.nil? && @code.nil?
      return @code if arg.nil?
      (@@lookup ||= {})[arg] = self
      @code = arg
    end

    def self.slots(*args)
      @slots ||= []
      return @slots if args.empty?
      @slots = args
      attr_reader *args
    end

    def initialize(*args)
      self.class.slots.zip(args).each do |slot, arg|
        case arg
        when Hash
          arg
            .transform_keys { BinaryFormat.parse _1 }
            .transform_values { BinaryFormat.parse _1 }
        when Array
          arg.map { BinaryFormat.parse _1 }
        else
          BinaryFormat.parse arg
        end.then { instance_variable_set(:"@#{slot}", _1) }
      end
    end
  end
end

require_relative 'binary_format/non_primitive'
require_relative 'binary_format/object_member'
