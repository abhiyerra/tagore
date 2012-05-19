require 'rubygems'
require "redis"
require 'erb'
require 'typhoeus'
require 'json'
require 'ruby-debug'

MACHINE_IP = '127.0.0.1'

SERVICE_SEARCH_URL = "http://localhost:3001/services/"

FORMAN_FILE = 1

class Deployer
  def initialize

  end

  def deploy(service_id, commit)
    response = Typhoeus::Request.get(SERVICE_SEARCH_URL + service_id + ".json")
    service = JSON.parse(response.body)

    # if not directory exists
    unless File.directory?(service["name"])
      `cd /srv/#{service["name"]} && git clone #{service["repo"]} #{service["name"]}`
    else
      `cd /srv/#{service["name"]} && foreman stop`
    end

    `cd /srv/#{service["name"]} && git pull --rebase && git checkout #{commit}`
    # TODO: Create forman file

    # TODO: Should start the forman service in a restricted mode so
    # other services can't fuck with things.
    `cd /srv/#{service["name"]} && foreman start -c web 4 PORT=#{service["port"]}`
  end

  def looper
    @redis.subscribe(:nginx_provision) do |on|
      on.subscribe do |channel, subscriptions|
        puts "Subscribed to ##{channel} (#{subscriptions} subscriptions)"
      end

      on.message do |channel, message|
        puts "##{channel}: #{message}"
        provision

        if message =~ /deploy \(\w+\) \(\w+\)/
          service_id = $1
          commit = $2

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
