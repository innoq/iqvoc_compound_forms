require 'rails'

module Iqvoc
  module CompoundForms

    class Engine < Rails::Engine

      paths["lib/tasks"] << "lib/engine_tasks"

    end

  end
end
