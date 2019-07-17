# frozen_string_literal: true

require 'base62-rb'

RSpec.describe Website, type: :model do
  it { should validate_presence_of(:url) }

  describe '.find_by_shortened_id' do
    let!(:websites) { FactoryBot.create_list(:website, 3) }

    it 'retrieves top accesed websites' do
      website = Website.find_by_shortened_id(websites.first.shortened_id)
      expect(websites.first).to eq(website)
    end
  end

  describe '.top' do
    let!(:websites) { FactoryBot.create_list(:website, 3) }

    it 'retrieves top accesed websites' do
      top = Website.top(2)
      expect(websites.sort_by(&:access_count).reverse.first(2)).to eq(top)
    end
  end

  describe '#shortened_id' do
    subject { FactoryBot.create(:website) }
    it { expect(subject.id).to be(Base62.decode(subject.shortened_id)) }
  end

  describe '#increase_access_count' do
    subject { FactoryBot.create(:website) }
    it { expect { subject.increase_access_count! }.to change { subject.access_count }.by(1) }
  end
end
