desc "This task deletes expired listings and is called by the Heroku scheduler add-on"
task :delete_expired_listings => :environment do
  puts "Finding expired listings..."
  expired_listings = Item.where("created_at < ?", 15.days.ago)
  puts "Deleting expired listings..."
  expired_listings.destroy_all
  puts "Done."
end