require 'rubygems'
require "redis"
require 'erb'
require 'typhoeus'
require 'json'
require 'ruby-debug'

trap(:INT) { puts; exit }

MACHINE_IP = '127.0.0.1'

SERVICE_SEARCH_URL = "http://localhost:3001/services/"

FORMAN_FILE = "Procfile.erb"

DEPLOY_DIR = "/Users/abhi/deployer/"

class Deployer
  def initialize
    @redis = Redis.new
  end

  def deploy(service_id, commit)
    response = Typhoeus::Request.get(SERVICE_SEARCH_URL + service_id + ".json")

    service = JSON.parse(response.body)
    port = 5000

    deploy_loc = "#{DEPLOY_DIR}#{service["name"]}"
    # if not directory exists
    unless File.directory?(deploy_loc)
      puts `cd #{DEPLOY_DIR} && git clone #{service["repo"]} #{service["name"]}`
    else
      puts `cd #{DEPLOY_DIR}#{service["name"]} && foreman stop`
    end

    puts `cd #{DEPLOY_DIR}#{service["name"]} && git pull --rebase && git checkout #{commit}`
    # TODO: Create forman file

    # TODO: Should start the forman service in a restricted mode so
    # other services can't fuck with things.
    puts `cd #{DEPLOY_DIR}#{service["name"]} && foreman start -c web=4 PORT=#{port} & `
  end

  def looper
    @redis.subscribe(:deploy) do |on|
      on.subscribe do |channel, subscriptions|
        puts "Subscribed to ##{channel} (#{subscriptions} subscriptions)"
      end

      on.message do |channel, message|
        puts "##{channel}: #{message}"

        if message =~ /(\w+) (\w+)/
          service_id = $1
          commit = $2

          puts $1
          puts $2

          deploy(service_id, commit)
        end
      end

      on.unsubscribe do |channel, subscriptions|
        puts "Unsubscribed from ##{channel} (#{subscriptions} subscriptions)"
      end
    end
  end
end

# Provision
# -> See if

deployer = Deployer.new
deployer.looper
