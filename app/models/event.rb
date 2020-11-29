# frozen_string_literal: true

class Event
  include ActiveModel::Model
  include ActiveModel::Validations

  ATTRIBUTES = %i[name properties ocurred_at].freeze
  attr_accessor(*ATTRIBUTES)

  validates :name, presence: true

  # TODO: set ocurred_at before_action

  def initialize(attr = {})
    attr.each do |k, v|
      send("#{k}=", v) if ATTRIBUTES.include?(k.to_sym)
    end
  end

  def attributes
    ATTRIBUTES.each_with_object({}) do |attr, hash|
      hash[attr] = send(attr)
    end
  end

  alias to_hash attributes
end
