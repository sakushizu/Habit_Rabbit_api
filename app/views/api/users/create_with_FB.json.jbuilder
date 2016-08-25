json.extract! @user, :id, :name, :email
json.avatar @user.avatar.url
json.access_token @access_token