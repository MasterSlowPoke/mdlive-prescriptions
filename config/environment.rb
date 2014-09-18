# Load the Rails application.
require File.expand_path('../application', __FILE__)

#Load enviroment vars from local file
env_vars = File.join(Rails.root, 'config', 'setup_enviroment.rb')
load(env_vars) if File.exists?(env_vars)

# Initialize the Rails application.
Rails.application.initialize!
