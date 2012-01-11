# encoding: UTF-8

require 'iqvoc/compound_forms/version'

module IqvocCompoundForms

  unless Iqvoc.const_defined?(:CompoundForms) && Iqvoc::CompoundForms.const_defined?(:Application)
    require File.join(File.dirname(__FILE__), '../config/engine')
  end

  ActiveSupport.on_load(:after_iqvoc_config) do
    require 'iqvoc'
  end

end
