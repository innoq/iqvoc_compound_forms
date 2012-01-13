# encoding: UTF-8

# Be sure to restart your server when you modify this file.

if Iqvoc::CompoundForms.const_defined?(:Application)

  # Your secret key for verifying the integrity of signed cookies.
  # If you change this key, all old signed cookies will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.

  # Run `rake secret` and uncomment the following line
  # Replace the secret-placeholder with your generated token
  Iqvoc::CompoundForms::Application.config.secret_token = "9e45407ff5be9fcef2555f944b8d9a196f1017999b1c6f5833ad51c7f17f66cb9304ac2236224c652fff07dbc44d435ec135dbd44baf7ad9012f0f0cf5c09725"

end
