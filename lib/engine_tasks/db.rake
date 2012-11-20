# encoding: UTF-8

namespace :iqvoc_compound_forms do
  namespace :db do

    desc "Load seeds (task is idempotent)"
    task :seed => :environment do
      Iqvoc::CompoundForms::Engine.load_seed
    end

  end
end
