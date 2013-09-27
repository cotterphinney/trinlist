class Item < ActiveRecord::Base
	validates_presence_of :name, :description, :location, :price
	validates_length_of :name, :maximum => 120
	validates_attachment :image, :size => { :in => 0..3.megabytes }
	validate :between_one_and_three_categories?

	belongs_to :user
	acts_as_taggable
	acts_as_taggable_on :categories

	has_attached_file :image, :styles => { :resized => "250x250>", :large => "600x600>" }, :url => ":s3_domain_url", :path => "/:class/:attachment/:id_partition/:style/:filename"

	def between_one_and_three_categories?
		if ((self.category_list.length == 0) || (self.category_list.length > 3))
			errors.add(:base, "You must choose between one and three categories")
		end
	end
end
