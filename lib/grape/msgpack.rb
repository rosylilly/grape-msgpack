require 'msgpack'
require 'grape'
require 'grape/msgpack/version'

module Grape
  # Message pack formatter for Grape
  module Msgpack
    module Formatter
      class << self
        def call(obj, env)
          return obj.to_msgpack if obj.respond_to?(:to_msgpack)
          MessagePack.pack(obj)
        end
      end
    end

    module ErrorFormatter
      class << self
        def call(message, backtrace, options = {}, env = nil)
          result = message.is_a?(Hash) ? message : { error: message }
          if (options[:rescue_options] || {})[:backtrace] && backtrace && !backtrace.empty?
            result = result.merge(backtrace: backtrace)
          end
          MessagePack.pack(result)
        end
      end
    end

    module Parser
      class << self
        def call(object, env)
          MessagePack.unpack(object)
        end
      end
    end
  end
end

class << Grape::Formatter::Base
  FORMATTERS[:msgpack] = Grape::Msgpack::Formatter
end

class << Grape::ErrorFormatter::Base
  FORMATTERS[:msgpack] = Grape::Msgpack::ErrorFormatter
end

class << Grape::Parser::Base
  PARSERS[:msgpack] = Grape::Msgpack::Parser
end

Grape::ContentTypes::CONTENT_TYPES[:msgpack] = 'application/x-msgpack'

if defined?(Grape::Entity)
  class Grape::Entity
    def to_msgpack(pack = nil)
      if pack
        pack.write(serializable_hash)
      else
        MessagePack.pack(serializable_hash)
      end
    end
  end
end
