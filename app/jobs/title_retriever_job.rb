# frozen_string_literal: true

require 'httparty'

class TitleRetrieverJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Website.where(title: nil).find_each do |website|
      response = HTTParty.get(website.url)
      website.update_attributes(title: Nokogiri::HTML(response).title)
    rescue StandardError => e
      logger.error "Failed to retrieve title for #{website.url} due to: #{e.message}"
    end
  end
end
