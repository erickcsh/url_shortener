# frozen_string_literal: true

class Base62
  # The order of the mapping is important since each character is associated to the respective index
  MAPPING = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z
               A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9].freeze

  def self.encode(num)
    encoded = ''
    loop do
      remainder = num % 62
      encoded += MAPPING[remainder]
      num /= 62
      break unless num.positive?
    end
    encoded.reverse
  end

  def self.decode(encoded)
    split_encoded = encoded.split('').reverse
    split_encoded.each_with_index.reduce(0) { |acc, (element, index)| acc + MAPPING.index(element) * 62**index }
  end
end
