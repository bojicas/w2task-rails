# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# ObjectSpace.each_object(Mongrel::HttpServer) { |i| @port = i.port }
# raise "Port could not be introspected!" unless @port and @port.to_i > 0
config.logger = Logger.new File.expand_path(RAILS_ROOT+"/log/#{ENV['RAILS_ENV']}.#{@port}.log")

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
# config.action_view.cache_template_loading            = true

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Keeping session data accross subdomains
# ActionController::Base.session_options[:session_domain] = '.w2task.com'
config.action_controller.session = { 
  :domain => ".w2task.com" 
}