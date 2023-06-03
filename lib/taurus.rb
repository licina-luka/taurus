# frozen_string_literal: true

require_relative "taurus/version"
require "json"
require "socket"

module Taurus
  class Error < StandardError; end
  # Your code goes here...

  def self.req payload
    begin
      s = TCPSocket.new 'localhost', 1234
      puts s.gets
      s.puts JSON.generate(payload)
      res = JSON.parse(s.gets).transform_keys(&:to_sym)

      if res.key?(:err)
        raise res[:err]
      end
      
      s.close
      return [res, nil]
    rescue => e
      return [nil, e]
    end
  end
end
