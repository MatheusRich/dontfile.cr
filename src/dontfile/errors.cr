module Dontfile::Errors
  class ClientError < Exception; end

  class InternalError < Exception; end

  class ServerError < Exception; end
end
