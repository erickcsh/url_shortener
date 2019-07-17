require 'httparty'

class TitleRetrieverJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Website.where(title: nil).find_each do |website|
      begin
        response = HTTParty.get(website.url)
        website.update_attributes(title: Nokogiri::HTML(response).title)
      rescue => exception
        logger.error "Failed to retrieve title for #{website.url} due to: #{exception.message}"
      end
    end
  end
end
