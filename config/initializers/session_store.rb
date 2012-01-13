# Be sure to restart your server when you modify this file.

if Iqvoc::CompoundForms.const_defined?(:Application)
  Iqvoc::CompoundForms::Application.config.session_store :cookie_store,
      :key => "_iqvoc_compound_forms_session"
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Iqvoc::Application.config.session_store :active_record_store
