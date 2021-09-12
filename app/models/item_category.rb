class ItemCategory
  attr_reader :value

  def initialize(arg)
    value =
      case arg
      when Integer
        sym = Protocol::Core::ItemCategory.lookup(arg)
        Protocol::Core::ItemCategory.resolve(sym)
      when Symbol then Protocol::Core::ItemCategory.resolve(arg)
      when ItemCategory then arg.value
      else
        raise ArgumentError, "#{arg} is not supported"
      end

    @value = value
  end

  Protocol::Core::ItemCategory.constants.each do |name|
    define_singleton_method name.to_s.gsub("ITEM_CATEGORY_", "").underscore do
      Protocol::Core::ItemCategory.const_get(name)
    end
  end

  def to_i
    @value
  end

  def to_sym
    Protocol::Core::ItemCategory.lookup(@value)
  end
end
