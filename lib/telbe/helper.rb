module InitializeFromHash
  def self.included(base)
    base.singleton_class.send(:attr_accessor, :attributes)
    base.attributes = {}
    base.singleton_class.send(:attr_accessor, :mandatory)
    base.mandatory = []
    base.singleton_class.send(:attr_accessor, :default)
    base.default = {}
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attribute(attr, type = Object, **args)
      raise ArgumentError, "Duplicate attribute #{attr}." if self.attributes[attr]
      self.attributes[attr] = {
        type: (type.class == Class ? type : Object ),
        params: args
      }
      self.mandatory << attr if args[:mandatory]
      self.default["#{attr}".to_sym] = args[:default] if args[:default]
    end
  end

  def initialize(opts)
    opts.each_pair do |k, v|
      # if parent.const_defined?(k.to_s.camelize) then
      #   puts "Já conheço #{k}"
        case v
        when Hash
          puts "Reusando class #{k}"
          # v = parent.const_get(k.to_s.camelize).new(v)
          v = self.class.attributes[k][:type].new(v)
        when Array
          puts "Coleção de #{k}"
          # v.collect! { |i| parent.const_get(k.to_s.camelize).new(i) }
          v.collect! { |i| self.class.attributes[k][:type].new(i) }
        end
      # end
      create_and_set_instance_variable("#{k}", v)
    end
    raise ArgumentError, "Missing mandatory attributes => #{self.class.mandatory-self.instance_variables}" if not mandatory_attributes_in?
    self.class.default.each_pair do |k, v|
      create_and_set_instance_variable(k, v) unless self.instance_variables.include?("@#{k}".to_sym)
    end
  end

  def to_h
    h = {}
    instance_variables.each do |i|
      k = /\@(.*)/.match(i.to_s)[1].to_sym
      v = instance_variable_get(i)
      # if v.class.inspect.start_with?("Telbe") then
      h[k] = v.respond_to?(:to_h) ? v.to_h : v
        # h[k] = v.to_h
      # else
      #   h[k] = v
      # end
    end
    return h
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
    define_singleton_method("#{name}=") do |arg| 
      valid_values = self.class.attributes[name.to_sym][:params][:values]
      raise "Argument Error. Invalid value for #{name} => #{arg}" if valid_values && !valid_values.include?(arg)
      instance_variable_set("@#{name}", arg)
    end
    define_singleton_method("#{name}") do
      instance_variable_get("@#{name}")
    end
    self.send("#{name}=", value)
  end

  def mandatory_attributes_in?
    self.class.mandatory.collect {|v| self.instance_variables.include?("@#{v}".to_sym)}.inject(&:&)
  end
end