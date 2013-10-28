namespace :listings do
	desc "Rake task to delete expired listings"
	task :delete_expired => :environment do
	  puts "Finding expired listings..."
	  expired_listings = Item.where("created_at < ?", 15.days.ago)
	  puts "Deleting expired listings..."
	  expired_listings.destroy_all
	  puts "#{Time.now} - Done."
	end
end