# frozen_string_literal: true

module Crudecumber
  module PassFail
    VALID_KEYS = (['p', 'f', 'x', 's'] + ["\r"]).freeze

    def self.capture
      system('stty raw -echo isig')
      key = ''
      key = $stdin.getc.chr until VALID_KEYS.include?(key.downcase)
      system('stty -raw echo')
      key.downcase
    end

    def self.pass?(key) = key == 'p' || key == "\r"
    def self.skip?(key) = key == 's'
    def self.fail?(key) = key == 'f' || key == 'x'
  end
end
