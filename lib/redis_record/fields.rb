module RedisRecord
  module Fields
    attr_reader :fields

    def field(name, type: String, default: nil)
      raise ArgumentError, "Already defined #{name} field" if instance_methods.include?(name.to_sym)

      define_method("#{name}") do
        return default if (default.to_s.present? && @fields[normalize_key(name)].nil?)

        Types::Converter.convert(@fields[normalize_key(name)], get_type(name))
      end

      define_method("#{name}=") do |value|
        unless value == Types::Converter.convert(value, get_type(name))
          raise "WrongFormat: value must be #{get_type(name)}"
        end

        @fields[normalize_key(name)] = value
      end

      # Fix type
      set_type(name.to_s, type.to_s)
    end

    def fields(*names, type: String, default: nil)
      names.each { |name| field(name, type: type, default: default.to_s) }
      @fields = names
    end
  end
end
