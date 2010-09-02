# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_update_session',
  :secret      => 'defde66b56c794b4926fec1033521b5ed423b7d670a69607276e59566b31a2e0bf65540a0f3098fd5e20ff60557e2aabe0feb10de0534009a48e31da32891733'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
