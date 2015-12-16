module RedisRecord
  module Fields
    attr_reader :fields

    def field(name)
      raise ArgumentError, "Already defined #{name} field" if instance_methods.include?(name.to_sym)

      define_method("#{name}") { @fields[normalize_key(name)] }
      define_method("#{name}=") { |value| @fields[normalize_key(name)] = normalize_value(value) }
    end

    def fields(*names)
      names.each { |name| field(name) }
      @fields = names
    end
  end
end
