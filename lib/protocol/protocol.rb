module Protocol
  def self.services
    @services ||= {}
  end

  def self.register_service(name, klass)
    services[name] = klass
  end
end

require_relative "service"

Dir.glob(File.expand_path("../pb/*.rb", __FILE__)).each do |file|
  require_relative file
end

Dir.glob(File.expand_path("../servicepb/*.rb", __FILE__)).each do |file|
  require_relative file
end
