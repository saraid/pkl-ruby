require 'byebug'
require 'logger'
require 'msgpack'
require 'pathname'
require 'timeout'

require_relative 'pkl/refinements'

require_relative 'pkl/binary_format'
require_relative 'pkl/evaluator'
require_relative 'pkl/message'
require_relative 'pkl/server'

module Pkl
  def self.random_request_id = rand(4_611_686_018_427_387_903) # I dunno, some max int, I guess. It's not real.
  def self.logger = @logger ||= Logger.new($stderr)
end
