class Relationship < ActiveRecord::Base
  attr_accessible :other_user_id, :status, :user_id
  
  belongs_to :user
  belongs_to :other_user, class_name: "User"

  validates :user_id, presence: true
  validates :other_user_id, presence: true
  validates :status, presence: true

  def self.create_blocked_relationship(user_id, blocked_user_id)
    relationship = find_by_user_id_and_other_user_id(user_id, blocked_user_id)
    if relationship.present?
      relationship.status = "blocked"
      relationship.save
      return relationship
    else 
      create({user_id: user_id, other_user_id: blocked_user_id, status: "blocked"})
    end
  end

  def self.unblock_relationship(user_id, other_user_id)
    relationship = find_by_user_id_and_other_user_id(user_id, other_user_id)
    relationship.status = "default"
    relationship.save
    return relationship 
  end

  def self.get_all_block_or_blocking_users(current_user_id)
    blocked_users = get_blocked_users(current_user_id)
    blocking_users = get_blocking_users(current_user_id)
    @blocked_susers = blocked_users.concat(blocking_users)
  end

  def self.get_blocked_users(current_user_id)
    where({user_id: current_user_id, status: "blocked"})
      .map { |relationship| relationship.other_user_id }
  end

  def self.get_blocking_users(current_user_id)
    where({other_user_id: current_user_id, status: "blocked"})
     .map { |relationship| relationship.user_id }
  end

# need to fix below and test
  def self.any_blocked_relationships?(user, other_user)
    exists?(user_id: user, other_user_id: other_user, status: "blocked") ||
    exists?(user_id: other_user, other_user_id: user, status: "blocked")
  end

end