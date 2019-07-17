# frozen_string_literal: true

require 'uri'

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    begin
      uri = URI.parse(value)
      valid = uri.is_a?(URI::HTTP)
    rescue URI::InvalidURIError
      valid = false
    end
    record.errors[attribute] << (options[:message] || "Invalid URL #{value}") unless valid
  end
end
