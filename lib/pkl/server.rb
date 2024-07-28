require 'msgpack'

module Pkl
  class Server
    def self.instance
      @instance = nil if @instance&.closed?
      @instance ||= new
    end

    def initialize
      @io = IO.popen('pkl server', 'r+b')
      @unpacker = MessagePack::Unpacker.new(@io).each
    end

    def write(binary) = @io.write(binary)
    def read = @unpacker.next.then { Message::ServerMessage.parse(_1) }

    def close! = @io.close
    def closed? = @io.closed?
  end
end
