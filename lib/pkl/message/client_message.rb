module Pkl
  class Message
    class ClientMessage < Message
    end

    class CreateEvaluatorRequest < ClientMessage
      code 0x20

      def initialize(options = {})
        @payload = {
          requestId: Pkl.random_request_id,
          allowedModules: ['pkl:', 'file:', 'modulepath:', 'https:', 'repl:', 'package:', 'projectpackage:'],
          allowedResources: ['env:', 'prop:', 'package:', 'projectpackage:'],
        }.merge(options)
      end
    end

    class CloseEvaluator < ClientMessage
      code 0x22

      def initialize(evaluator_id)
        @payload = { evaluatorId: evaluator_id }
      end
    end

    class EvaluateRequest < ClientMessage
      code 0x23

      def initialize(evaluatorId:, moduleUri:, moduleText: nil, expr: nil)
        @payload = {
          requestId: Pkl.random_request_id,
          evaluatorId:,
          moduleUri:,
          moduleText:,
          expr:
        }.compact
      end
    end

    class Pkl::Message::ReadResourceResponse < ClientMessage
      code 0x27

      def initialize(evaluatorId:, contents: nil, error: nil)
        @payload = {
          requestId: Pkl.random_request_id,
          evaluatorId:,
          contents:,
          error:
        }.compact
      end
    end

    class Pkl::Message::ReadModuleResponse < ClientMessage
      code 0x29

      def initialize(evaluatorId:, contents: nil, error: nil)
        @payload = {
          requestId: Pkl.random_request_id,
          evaluatorId:,
          contents:,
          error:
        }.compact
      end
    end

    class Pkl::Message::ListResourcesResponse < ClientMessage
      code 0x2b

      def initialize(evaluatorId:, pathElements: nil, error: nil)
        @payload = {
          requestId: Pkl.random_request_id,
          evaluatorId:,
          pathElements:,
          error:
        }.compact
      end
    end

    class Pkl::Message::ListModulesResponse < ClientMessage
      code 0x2d

      def initialize(evaluatorId:, pathElements: nil, error: nil)
        @payload = {
          requestId: Pkl.random_request_id,
          evaluatorId:,
          pathElements:,
          error:
        }.compact
      end
    end
  end
end
