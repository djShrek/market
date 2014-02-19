class UserListing < ActiveRecord::Base

  belongs_to :user

  has_many :item_listings, dependent: :destroy
  has_many :items, through: :item_listings
  has_many :items_wanted,
           :through => :item_listings,
           :source => :item,
           :conditions => ["status = ?", "wanted"]
  has_many :items_offered,
           :through => :item_listings,
           :source => :item,
           :conditions => ["status = ?",  "offered"]

  attr_accessible :status, :item_id

  def all_listings
    current
  end

end