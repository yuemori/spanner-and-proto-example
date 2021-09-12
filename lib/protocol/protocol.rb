module Protocol
  def self.services
    @services ||= {}
  end

  def self.register_service(name, klass)
    services[name] = klass
  end
end

$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.dirname(__FILE__) + "/pb"

Dir.glob(File.expand_path("../pb/core/*.rb", __FILE__)).each do |file|
  require Pathname.new("core").join(File.basename(file)).to_s
end

Dir.glob(File.expand_path("../pb/rpc/*.rb", __FILE__)).each do |file|
  require Pathname.new("rpc").join(File.basename(file)).to_s
end

Dir.glob(File.expand_path("../pb/masterpb/*.rb", __FILE__)).each do |file|
  require Pathname.new("masterpb").join(File.basename(file)).to_s
end

require "service"
require "servicepb/service"
