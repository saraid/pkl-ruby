require 'msgpack'

module Pkl
  class Server
    def self.instance
      @instance ||= new
    end

    def initialize
      @io = IO.popen('pkl server', 'r+b')
      @unpacker = MessagePack::Unpacker.new(@io).each
    end

    def write(binary) = @io.write(binary)
    def read = @unpacker.next.then { Message::ServerMessage.parse(_1) }
  end
end
