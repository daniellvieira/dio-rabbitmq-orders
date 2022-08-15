# frozen_string_literal: true

class BunnyConsumer
  VALID_MODELS = { 'User' => 'Customer' }

  class << self
    def call!(metadata, payload)
      return false unless VALID_MODELS.keys.include?(metadata[:type])

      model_klass(metadata[:type]).create_or_update_from_bunny(JSON.parse(payload))
    end

    private

    def model_klass(type)
      VALID_MODELS[type].constantize
    end
  end
end
