guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$}) do |m|
    ["spec/#{m[1]}_spec.rb", "spec/integration/#{m[1]}_integration_spec.rb"]
  end

  # watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end
end
