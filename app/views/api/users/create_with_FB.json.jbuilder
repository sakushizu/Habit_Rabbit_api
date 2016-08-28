json.extract! @user, :id, :name, :email
json.access_token @access_token
logger.info "#{@user.avatar}"
logger.info "#{@user.avatar.url}"
json.avatar @user.avatar.url
