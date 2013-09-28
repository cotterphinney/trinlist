desc "This task is called by the Heroku scheduler add-on"
task :delete_expired_listings => :environment do
  puts "Finding expired listings..."
  expired_listings = Item.find(:all, :conditions => ["created_at >= ?", 15.days.ago])
  puts "Deleting expired listings..."
  expired_listings.destroy
end