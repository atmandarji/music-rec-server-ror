class History < ApplicationRecord
	belongs_to :user
	validates_presence_of :userid
	validates_presence_of :keyword
end
