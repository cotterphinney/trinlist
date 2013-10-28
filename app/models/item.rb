class Item < ActiveRecord::Base
	validates_presence_of :name, :description, :location, :price
	validates_length_of :name, :maximum => 120
	validates_numericality_of :price, :greater_than_or_equal_to => 0
	validate :between_one_and_three_categories?

	belongs_to :user
	acts_as_taggable
	acts_as_taggable_on :categories

	has_attached_file :image, 
		:styles => { :resized => "250x250>", :original => "600x600>" },
		:storage => :s3,
    :bucket => ENV['AWS_BUCKET'],
    :path => ":attachment/:id/:style.:extension",
    :url => ":s3_domain_url",
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
	validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'],
		:message => "must be a jpeg, gif or png file."
	validates_attachment_size :image, :less_than => 7.megabytes

	def between_one_and_three_categories?
		if ((self.category_list.length == 0) || (self.category_list.length > 3))
			errors.add(:base, "You must choose between one and three categories")
		end
	end
end
