require 'base64'
require 'openssl'

module PuntoPagos
  
  # Public: This class manage the signing of a message using
  # the secret and api-key defined in puntopagos.yml
  class Authorization
    def initialize env = nil
      @@config ||= PuntoPagos::Config.new(env)
      puts "PPRUBY RESPONSE Authorization::initialize =====> #{@@config.inspect}"
    end

    # Public: Signs a string using the secret and api-key defined in puntopagos.yml
    #
    # string - The String to be signed
    # Returns the signed String.
    def sign(string)
      puts "PPRUBY RESPONSE Authorization::sign =====> #{string.inspect}"
      encoded_string = if string.length <= 40
                         Base64.strict_encode64(OpenSSL::HMAC.digest('sha1',@@config.puntopagos_secret, string)).chomp
                       else
                         Base64.strict_encode64(OpenSSL::HMAC.digest('sha512',@@config.puntopagos_secret, string)).chomp
                       end
      puts "PPRUBY RESPONSE Authorization::sign 1 =====> #{encoded_string.inspect}"
      result = "PP "+@@config.puntopagos_key+":"+ encoded_string
      puts "PPRUBY RESPONSE Authorization::sign 2 =====> #{result.inspect}"
      "PP "+@@config.puntopagos_key+":"+ encoded_string
    end
  end
end