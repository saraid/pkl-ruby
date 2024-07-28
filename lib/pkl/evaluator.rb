module Pkl
  class Evaluator
    def self.evaluate(create_options = {}, &)
      evaluator = new(create_options)
      result = evaluator.instance_eval(&)
      evaluator.close!
      result
    end

    def initialize(options = {})
      @id = Pkl::Message::CreateEvaluatorRequest.new(options)
        .then { write _1 }
        .then { read }
        .evaluator_id
    end
    attr_reader :last_message

    private def write(message) = Pkl::Server.instance.write(message.to_msgpack_ext)
    private def read
      @last_message = Pkl::Server.instance.read
    end
    def close! = write(Pkl::Message::CloseEvaluator.new(@id))

    def evaluate(moduleUri:, moduleText: nil, expr: nil)
      Pkl::Message::EvaluateRequest.new(evaluatorId: @id, moduleUri:, moduleText:, expr:)
        .tap { Pkl.logger.debug _1.inspect }
        .then { write _1 }

      result = nil
      loop do
        case msg = read
        when Pkl::Message::Log
          Pkl.logger.add(msg.level, msg.message)
        when Pkl::Message::ReadResourceRequest
          puts msg.inspect
        when Pkl::Message::ReadModuleRequest
          puts msg.inspect
        when Pkl::Message::ListResourcesRequest
          puts msg.inspect
        when Pkl::Message::ListModulesRequest
          puts msg.inspect
        when Pkl::Message::EvaluateResponse
          Pkl.logger.debug msg.inspect
          if msg.error?
            puts msg.error
          else
            result = msg.result
              .then { MessagePack.unpack _1 }
              .then { BinaryFormat.parse _1 }
          end
          break
        end
      end
      result
    end
  end
end
