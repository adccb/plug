task :default => ['test']

desc 'run tests'
task 'test' do
  ruby FileList['spec/**/*.spec.rb']
end

desc 'run cli'
task 'start' do |t, args|
  print args
end

