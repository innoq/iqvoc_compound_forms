require 'rails'

module Iqvoc
  module CompoundForms

    class Engine < Rails::Engine
      paths["lib/tasks"] << "lib/engine_tasks"

      initializer "iqvoc_compound_forms.load_migrations" do |app|
        app.config.paths['db/migrate'] += Iqvoc::CompoundForms::Engine.paths['db/migrate'].existent
      end
    end

  end
end
