# Numeric class monkey patching 함 (Fixnum)
# prefix : c, Id : 12345
# 1. encoding
#    c + 12345.encode 
#       => c5comy
# 2. decoding
#    Numeric.decode("c5comy"[1..-1])
#       => 12345
class Numeric
  ENCODING_CHARS = 'LDJVFYNUZS10TCQRHP3GWBKM8E4X62OI957A'
  ENCODING_BASE = ENCODING_CHARS.length
  ENCODING_BASE_VALUE = 10000000

  def encode
    encode_inner(self + ENCODING_BASE_VALUE)
  end

  def self.decode(str)
    value = 0
    (0...str.length).each do |index|
      char_index = ENCODING_CHARS.index(str[index, 1])
      if char_index
        value = value * ENCODING_BASE + char_index
      else
        return nil
      end
    end
    value - ENCODING_BASE_VALUE
  end

  private
  def encode_inner(num)
    if num < ENCODING_BASE
      ENCODING_CHARS[num, 1]
    else
      result = encode_inner(num / ENCODING_BASE) + ENCODING_CHARS[num % ENCODING_BASE, 1]
    end
  end
end