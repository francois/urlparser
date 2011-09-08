require "rake/testtask"

namespace :compile do
  file "ruby/lib/urlparser/parser.rb" => %w(ruby/lib/urlparser/parser.rl url.rl) do
    sh "ragel -I. -R -o ruby/lib/urlparser/parser.rb ruby/lib/urlparser/parser.rl"
  end

  task :ruby => "ruby/lib/urlparser/parser.rb"
end

namespace :test do
  Rake::TestTask.new(:ruby => %w(compile:ruby)) do |t|
    t.libs << "ruby/lib"
    t.libs << "ruby/spec"
    t.warning = true
    t.test_files = FileList["ruby/spec/**/*_spec.rb"]
  end
end

file "url.png" => %w(url.rl ruby/lib/urlparser/parser.rl) do
  sh "ragel -I. -V -p ruby/lib/urlparser/parser.rl | dot -T png -o url.png"
end

task :viz => %w(url.png)

task :compile => %w(compile:ruby)
task :default => %w(test:ruby)
