module ActiveRecordExtension
  def attr_encoded(column, options={})

    encoder = options[:encoder] || 'numeric_simple'
    prefix = options[:prefix] || ''
    num_length = options[:num_length] || 3

    class_eval <<-RUBY, __FILE__, __LINE__+1
      def encoded_#{column}
        self.class.encode_#{column}(self.#{column})
      end

      def self.encode_#{column}(value)
        return unless value

        encoder = '#{encoder}'

        result = case encoder
          when 'numeric_simple'
            value.simple_encode(#{num_length})
          when 'numeric_36'
            puts value
            puts value.class
            value.encode  
          when 'numeric_33'
            value.encode_33
          else
            value.two_phased_encode
          end

        '#{prefix}' + result
      rescue => e
        nil
      end


      def self.decode_#{column}(encoded_value)
        encoder = '#{encoder}'
        encoded_value = encoded_value[#{prefix.length}..-1]

        result = case encoder
          when 'numeric_simple'
            Numeric.simple_decode(encoded_value, #{num_length})
          when 'numeric_36'
            Numeric.decode(encoded_value)
          when 'numeric_33'
            Numeric.decode_33(encoded_value)
          else
            Numeric.two_phased_decode(encoded_value)
          end
      rescue => e
        nil
      end

      def self.find_by_encoded_#{column}(encoded_value)
        self.find(self.decode_#{column}(encoded_value))
      end

      # if self.respond_to?(:ransacker)
      #   ransacker :encoded_#{column}, args: [:parent, :context, :attr_name],
      #     formatter: proc { |v| Integer(v) rescue self.decode_id(v.upcase)},
      #     validator: proc { |v| v.present? },
      #     type: :string do |parent, context, attr_name|
      #
      #     Arel.sql("#{table_name}.#{column}")
      #
      #     # params = context.params
      #     # entries = params.select{ |key, value| key.include?(attr_name) and value.blank? == false and Integer(value) rescue false}
      #     #
      #     # if entries.count == 0 or context.auth_object.andand.admin?
      #     #   Arel.sql("#{table_name}.#{column}")
      #     # else
      #     #   nil
      #     # end
      #   end
      # end
    RUBY
  end
end