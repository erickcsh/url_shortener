# frozen_string_literal: true

require 'base62'

RSpec.describe Base62 do
  describe '.encode' do
    it 'it base62 encodes the int' do
      { 0 => 'a', 157 => 'cH', 8_128_382 => 'IgI6' }.each do |key, value|
        assert_equal value, Base62.encode(key)
      end
    end
  end

  describe '.decode' do
    it 'it base62 decodes the string' do
      { 'a' => 0, 'toRN' => 4_584_753, 'nR' => 849 }.each do |key, value|
        assert_equal value, Base62.decode(key)
      end
    end
  end
end
