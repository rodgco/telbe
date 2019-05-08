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
        instance_variable_set("@#{k}", v)
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

    def method_missing(m, *args, &block)
      case m
      when /(.*)\=$/
        instance_variable_set("@#{$1}", args[0])
      else
        instance_variable_get("@#{m}")
      end
    end
  end
end