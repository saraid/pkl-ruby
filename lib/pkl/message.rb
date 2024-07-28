module Pkl
  using Refinements

  class Message
    def self.code(arg = nil)
      raise NoMethodError("code undefined for #{self.class}") if arg.nil? && @code.nil?
      return @code if arg.nil?
      (@@lookup ||= {})[arg] = self
      @code = arg
    end
    def code = self.class.code
    def payload = [code, @payload]

    def self.from_msgpack(msg) = MessagePack.unpack(msg)
    def self.from_msgpack_ext(data) = new(MessagePack.unpack(data))
    def to_msgpack_ext = payload.to_msgpack
  end
end

require_relative 'message/client_message'
require_relative 'message/server_message'
