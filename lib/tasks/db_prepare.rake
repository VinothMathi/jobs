task prepare_db: :environment do
  [:drop, :create, :migrate, :seed, :'fixtures:load' ].each do |task|
    Rake::Task['db:' + task.to_s ].invoke
  end  
end

