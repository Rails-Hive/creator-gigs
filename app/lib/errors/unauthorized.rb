module Errors
    class Unauthorized < Errors::StandardError
      def initialize
        super(
          title: "Unauthorized",
          status: 401,
          detail: "Missing or invalid Token",
          source: { pointer: "/request/headers/authorization" }
        )
      end
    end
end