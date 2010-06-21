# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_baseball_session',
  :secret      => 'c3c48092adc038c0381f358454f4254d34f94c60cf058e87132c1c916158fef64dff27ca8e329906174b65517cb6665d7bb0cd2733741fa3ee6328d75254ebc3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
