class String
  def camelize
    self.split('_').collect(&:capitalize).join
  end
end

module Telbe
  module InitializeFromHash
    def initialize(opts)
      opts.each_pair do |k, v|
        if Telbe::const_defined?(k.to_s.camelize) then
          case v
          when Hash
            v = Telbe::const_get(k.to_s.camelize).new(v)
          when Array
            v.collect! { |i| Telbe::const_get(k.to_s.camelize).new(i) }
          end
        end
        create_and_set_instance_variable("#{k}", v)
      end
    end

    def to_h
      h = {}
      instance_variables.each do |i|
        k = /\@(.*)/.match(i.to_s)[1]
        v = instance_variable_get(i)
        if v.class.inspect.start_with?("Telbe") then
          h[k] = v.to_h
        else
          h[k] = v
        end
      end
      h
    end

    def to_json
      self.to_h.to_json
    end
    
    def method_missing(method_name, *args, &block)
      case method_name
      when /(.*)\=$/
        create_and_set_instance_variable("#{$1}", args[0])
      else
        super(method_name, args, block)
      end
    end

    def respond_to_missing?(method_name, *args)
      case method_name
      when /(.*)\=$/
        true # always respond to assignment methods
      else
        super(method_name, args)
      end
    end

    private
    def create_and_set_instance_variable(name, value)
      instance_variable_set("@#{name}", value)
      define_singleton_method("#{name}=") { |arg| instance_variable_set("@#{name}", arg) }
      define_singleton_method("#{name}") { instance_variable_get("@#{name}") }
    end
  end
end