module RedisRecord
  module Fields
    attr_reader :fields

    def field(name, type: String)
      raise ArgumentError, "Already defined #{name} field" if instance_methods.include?(name.to_sym)

      define_method("#{name}") do
        Types::Converter.convert(@fields[normalize_key(name)], get_type(name))
      end

      define_method("#{name}=") do |value|
        unless value == Types::Converter.convert(value, get_type(name))
          raise "WrongFormat: value must be #{get_type(name)}"
        end

        @fields[normalize_key(name)] = value
      end

      set_type(name.to_s, type.to_s)
    end

    def fields(*names, type: String)
      names.each { |name| field(name, type: type) }
      @fields = names
    end
  end
end
