require 'bundler/setup'
Bundler.require

configure :development do
  set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'adopt_a_dog_development', pool: 2}
end

configure :production do
  set :database, {adapter: 'postgresql',  encoding: 'unicode', database: 'adopt_a_dog_production', pool: 5}
end

# configure :development do
#   ENV['SINATRA_ENV'] ||= "development"
#
#   ActiveRecord::Base.establish_connection(
#     :adapter => "sqlite3",
#     :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#   )
# end
#
# # :database => "db/neighborhood#{ENV['SINATRA_ENV']}.sqlite"
#
# configure :production do
# 	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
#
# 	ActiveRecord::Base.establish_connection(
# 			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
# 			:host     => db.host,
# 			:username => db.user,
# 			:password => db.password,
# 			:database => db.path[1..-1],
# 			:encoding => 'utf8'
# 	)
# end

require_all 'app'
