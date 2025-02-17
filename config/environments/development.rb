require 'iqvoc/environments/development'

if Iqvoc::CompoundForms.const_defined?(:Application)
  Iqvoc::CompoundForms::Application.configure do
    # Settings specified here will take precedence over those in config/environment.rb
    Iqvoc::Environments::Development.setup(config)
  end
end
