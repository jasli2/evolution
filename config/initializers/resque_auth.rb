require 'resque/tasks'
#Rake::Task["resque:work QUEUE='*'"].invoke
Resque::Server.use(Rack::Auth::Basic) do |user, password|
  password == "lljc"
end
