require "resque/tasks"

task "resque:setup" => :environment do
   Resque.before_first_fork = Proc.new { Rails.logger.auto_flushing = 1 }
end
