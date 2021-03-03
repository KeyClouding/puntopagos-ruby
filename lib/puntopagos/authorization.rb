require 'base64'
require 'openssl'

module PuntoPagos
  # rubocop:disable Layout/LineLength

  # Public: This class manage the signing of a message using
  # the secret and api-key defined in puntopagos.yml
  class Authorization
    def initialize(env = nil)
      @@config ||= PuntoPagos::Config.new(env)
    end

    # Public: Signs a string using the secret and api-key defined in puntopagos.yml
    #
    # string - The String to be signed
    # Returns the signed String.
    def sign(string)
      # encoded_string = if string.length <= 40
      #                    Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', @@config.puntopagos_secret, string))
      #                  else
                         encoded_string = Base64.encode64(@@config.puntopagos_secret)
                      #  end

      "PP " + @@config.puntopagos_key + ":" + encoded_string
    end
  end
  # rubocop:enable Layout/LineLength
end
