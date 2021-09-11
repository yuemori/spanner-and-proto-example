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

Dir.glob(File.expand_path("../pb/*.rb", __FILE__)).each do |file|
  require File.basename(file)
end

require "service"
require "servicepb/service"
