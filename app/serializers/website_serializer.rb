# frozen_string_literal: true

class WebsiteSerializer < ActiveModel::Serializer
  attributes :url, :title, :access_count, :shortened_id
end
