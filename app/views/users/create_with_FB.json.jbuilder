json.user do
  json.extract! @user, :name, :email
  json.avatar @avatar_url
end
json.access_token @access_token