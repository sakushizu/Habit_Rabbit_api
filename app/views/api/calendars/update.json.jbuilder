json.calendar do
  json.extract! @calendar, :id, :title, :color_R, :color_G, :color_B, :stamp_image
  json.stamp_image @calendar.stamp_image.url
  json.user do
    json.extract! @calendar.user, :id, :email, :name
    json.avatar @calendar.user.avatar.url
  end
end