json.extract! @user, :id, :name, :email
json.access_token @access_token
json.avatar @user.avatar.url
