module Pkl
  using Refinements

  class Message
    class ServerMessage < Message
      def self.parse(message)
        code, data = message
        @@lookup[code].new(data)
      end

      def self.parse_properties(*variables)
        @properties ||= []
        variables.each do |prop|
          attr_reader prop.underscorize
          @properties << prop
        end
      end
      parse_properties :requestId

      def self.properties = @properties || []

      def initialize(data)
        @data = data # placeholder stuff
        self.class.properties.each do |prop|
          instance_variable_set(:"@#{prop.underscorize}", data[prop.to_s])
        end
      end
      attr_reader :data
    end

    class CreateEvaluatorResponse < ServerMessage
      code 0x21
      parse_properties :evaluatorId
    end

    class EvaluateResponse < ServerMessage
      code 0x24
      parse_properties :evaluatorId, :result, :error

      def error? = !!error
    end

    class Log < ServerMessage
      code 0x25
      parse_properties :evaluatorId, :level, :message, :frameUri
    end

    class ReadResourceRequest < ServerMessage
      code 0x26
      parse_properties :evaluatorId, :uri
    end

    class ReadModuleRequest < ServerMessage
      code 0x28
      parse_properties :evaluatorId, :uri
    end

    class ListResourcesRequest < ServerMessage
      code 0x2a
      parse_properties :evaluatorId, :uri
    end

    class ListModulesRequest < ServerMessage
      code 0x2c
      parse_properties :evaluatorId, :uri
    end
  end
end
