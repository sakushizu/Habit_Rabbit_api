json.array! @calendar_users_ranking do |user|
  json.extract! user, :id, :email, :name
  json.avatar user.avatar.url
  json.stamped_count @calendar.stamped_count(user)
end
