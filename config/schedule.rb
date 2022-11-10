set :environment, "development"

every 2.minutes do
    rake 'batch:gig_payment_complete', :output => 'log/gig_payment_complete.log'
end