# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

namespace :db do
  task :spanner_emulator_instance_create do
    %w(development test).each do |env|
      config = YAML.load_file(Rails.root.join("config", "database.yml").to_s).fetch(env)

      begin
        spanner = Google::Cloud::Spanner.new project: config["project"], emulator_host: config["emulator_host"]
        job = spanner.create_instance config["instance"],
                                      name: "Test Instance",
                                      config: "emulator-config",
                                      nodes: 1
        job.wait_until_done!
      rescue Google::Cloud::AlreadyExistsError
        puts "instance already created(#{env})"
      end
    end
  end
end
