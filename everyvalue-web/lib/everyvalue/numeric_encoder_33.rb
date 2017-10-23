# Numeric class monkey patching 함 (Fixnum)
# prefix : c, Id : 12345 
# 1. encoding
#    c + 12345.encode 
#       => c5comy
# 2. decoding
#    Numeric.decode("c5comy"[1..-1])
#       => 12345
class Numeric
    ENCODING_CHARS_33 = 'LDJVFYNUZS10TCQRHP3GWBKM84X62957A'
    ENCODING_BASE_33 = ENCODING_CHARS_33.length
    ENCODING_BASE_33_VALUE = 10000000

    def encode_33
        encode_inner_33(self + ENCODING_BASE_33_VALUE)
    end

    def self.decode_33(str)
        value = 0
        (0...str.length).each do |index|
            char_index = ENCODING_CHARS_33.index(str[index, 1])
            if char_index
                value = value * ENCODING_BASE_33 + char_index
            else
                return nil
            end
        end
        value - ENCODING_BASE_33_VALUE
    end

    private
    def encode_inner_33(num)
        if num < ENCODING_BASE_33
            ENCODING_CHARS_33[num, 1]
        else
            result = encode_inner_33(num / ENCODING_BASE_33) + ENCODING_CHARS_33[num % ENCODING_BASE_33, 1]
        end
    end
end