require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['./aws/*_test.rb']
  t.verbose = true
end