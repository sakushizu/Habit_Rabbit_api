class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :calendar_users
  has_many :stamped_date
  has_many :calendars, through: :calendar_users
  has_many :api_keys, dependent: :destroy

  validates :email, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  def self.login?(access_token)
    api_key = ApiKey.find_by_access_token(access_token)
    return false if !api_key || !api_key.before_expired? || !api_key.active
    return !self.find(api_key.user_id).nil?
  end
 
  def activate
    if !api_key
      return ApiKey.create(user_id: self.id)
    else
      if !api_key.active
        api_key.set_active
        api_key.save
      end
      if !api_key.before_expired?
        api_key.set_expiration
        api_key.save
      end
      return api_key
    end
  end
 
  def inactivate
    api_key.active = false
    api_key.save
  end
 
  private
 
  def api_key
    @api_key ||= ApiKey.find_by_user_id(self.id)
  end
end
