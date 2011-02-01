ENV["REDISTOGO_URL"] ||= "redis://kmandrup:944e3b183ec3b06b9e7a9cbcdb0dad35@goosefish.redistogo.com:9005/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
