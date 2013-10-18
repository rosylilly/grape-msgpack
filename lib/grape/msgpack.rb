require 'msgpack'
require 'grape'
require 'grape/msgpack/version'

module Grape
  # Message pack formatter for Grape
  module Msgpack
    class << self
      def call(obj, env)
        return obj.to_msgpack if obj.respond_to?(:to_msgpack)
        MessagePack.pack(obj)
      end
    end
  end
end

class << Grape::Formatter::Base
  FORMATTERS[:msgpack] = Grape::Msgpack
end

class << Grape::ErrorFormatter::Base
  FORMATTERS[:msgpack] = Grape::Msgpack
end

Grape::ContentTypes::CONTENT_TYPES[:msgpack] = 'application/x-msgpack'

if defined?(Grape::Entity)
  class Grape::Entity
    def to_msgpack(options = {})
      options = options.to_h if options && options.respond_to?(:to_h)
      MessagePack.pack(serializable_hash(options))
    end
  end
end
