json.users do
  json.array! @users do |user|
    json.extract! user, :id, :email, :name
    json.avatar user.avatar.url
  end
end

