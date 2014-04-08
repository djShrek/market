class Comment < ActiveRecord::Base
  attr_accessible :user_id, :user_listing_id, :description

  belongs_to :user
  belongs_to :user_listing
  
end
