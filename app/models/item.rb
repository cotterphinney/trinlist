class Item < ActiveRecord::Base
	validates_presence_of :name, :description, :price
	validates_length_of :name, :maximum => 120
	validate :between_one_and_three_categories?

	belongs_to :user
	acts_as_taggable
	acts_as_taggable_on :categories

	def between_one_and_three_categories?
		if ((self.category_list.length == 0) || (self.category_list.length > 3))
			errors.add(:base, "You must choose between one and three categories")
		end
	end
end
