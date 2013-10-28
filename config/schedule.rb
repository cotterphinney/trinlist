every 1.day, :at => '12:00 am' do
  rake "listings:delete_expired"
end