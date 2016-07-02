class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name.to_sym) do
        self.instance_variable_get("@" + name.to_s)
      end
      define_method((name.to_s + "=").to_sym) do |value|
        self.instance_variable_set("@" + name.to_s, value)
      end
    end
  end
end
