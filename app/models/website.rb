# frozen_string_literal: true

# == Schema Information
#
# Table name: websites
#
#  id           :bigint           not null, primary key
#  title        :string
#  url          :string
#  access_count :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'base62-rb'

class Website < ApplicationRecord
  scope :find_by_shortened_id, ->(url_id) { Website.find_by(id: Base62.decode(url_id)) }
  scope :top, ->(limit) { Website.order(access_count: :desc).limit(limit) }

  validates :url, presence: true, url: true

  def shortened_id
    Base62.encode(id)
  end

  def increase_access_count!
    # TODO: create a semaphore to ensure count is correctly tracked
    update_attributes(access_count: access_count + 1)
  end
end
