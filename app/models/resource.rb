class Resource < ActiveRecord::Base
  attr_accessible :data, :service_id, :type

  belongs_to :service
  belongs_to :machine

  serialize :data

  TYPES = {
    "mysql" => MysqlResource,
    "redis" => RedisResource,
#    "mongo" => MongoResource,
    "memcached" => MemcachedResource,
    "web" => WebResource,
    "worker" => WorkerResource,
  }
end
