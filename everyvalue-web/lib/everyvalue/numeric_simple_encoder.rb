# Numeric class monkey patching 함 (Fixnum)
# 1. encoding
#    12345.simple_encode
#       => W125
# 2. decoding
#    Numeric.simple_decode("U125")
#       => 12345
class Numeric
  ECHARS = 'SCPGKVALQXYJDHMRBTNZFUW'
  ECHARS_LENGTH = ECHARS.length

  ENUMS = '7061258943'
  ENUMS_LENGTH = 10

  # EBASE_VALUE = 10000

  def simple_encode(num_length=3)
    base_value = 10 ** (num_length + 1)

    num = self + base_value
    head = num / (10 ** num_length)
    tail = num % (10 ** num_length)

    encoded_head = encode_head(head)
    encoded_tail = encode_tail(tail)

    while encoded_tail.length < num_length do
      encoded_tail = ENUMS[0] + encoded_tail
    end

    encoded_head + encoded_tail
  end

  def self.simple_decode(str, num_length=3)
    base_value = 10 ** (num_length + 1)

    num_index = num_length * -1
    encoded_head = str[0...num_index]
    encoded_tail = str[num_index..-1]

    decoded_value = self.decode_head(encoded_head) * (10 ** num_length) + self.decode_tail(encoded_tail)
    decoded_value - base_value
  end

  private

  def self.decode_head(str)
    value = 0

    (0...str.length).each do |index|
      c = str[index]
      char_index = ECHARS.index(c)
      value = value * ECHARS_LENGTH + char_index
    end

    value
  end

  def self.decode_tail(str)
    value = 0

    (0...str.length).each do |index|
      c = str[index]
      char_index = ENUMS.index(c)
      value = value * ENUMS_LENGTH + char_index
    end

    value
  end

  def encode_head(num)
    if num < ECHARS_LENGTH
      ECHARS[num]
    else
      encode_head(num / ECHARS_LENGTH) + ECHARS[num % ECHARS_LENGTH]
    end
  end

  def encode_tail(num)
    if num < ENUMS_LENGTH
      ENUMS[num]
    else
      encode_tail(num / ENUMS_LENGTH) + ENUMS[num % ENUMS_LENGTH]
    end

  end
end