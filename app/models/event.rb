# frozen_string_literal: true

class Event
  include ActiveModel::Model
  include ActiveModel::Validations

  extend ActiveModel::Callbacks

  ATTRIBUTES = %i[name properties ocurred_at].freeze
  attr_accessor(*ATTRIBUTES)

  validates :name, presence: true

  define_model_callbacks :create

  before_create :set_ocurred_at
  before_create :set_properties

  def initialize(attrs = {})
    attrs.each do |k, v|
      send("#{k}=", v) if ATTRIBUTES.include?(k.to_sym)
    end
  end

  def self.create(attrs = {})
    new(attrs).create
  end

  def create(_attrs = {})
    run_callbacks :create do
      EventRepository.new.save(self)
    end
  end

  def attributes
    ATTRIBUTES.each_with_object({}) do |attr, hash|
      hash[attr] = send(attr)
    end
  end

  alias to_hash attributes

  private

  def set_ocurred_at
    self.ocurred_at ||= Time.current
  end

  def set_properties
    self.properties ||= {}
    self.properties = self.properties.to_hash
  end
end
