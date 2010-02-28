# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MusicExplorer_session',
  :secret      => 'aedef7048cdb289b1d122d7b3e9cbb116dc54175ff4c2ec3ad66b2e293c251cff49f2f6d4f48059c0570d03d0ae69dbda63061a536a24698993ab1e2a4a43d15'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
