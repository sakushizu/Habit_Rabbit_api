json.calendars do
  json.array! @calendars do |calendar|
    json.extract! calendar, :id, :title, :color_R, :color_G, :color_B
    json.stamp_image calendar.stamp_image.url
    json.user do
      json.extract! calendar.user, :id, :email, :name
      json.avatar calendar.user.avatar.url
    end
    json.users do
      json.array! calendar.joined do |user|
        json.extract! user, :id, :email, :name
        json.avatar user.avatar.url
      end
    end
  end
end