json.calendars do
  json.array! @calendars do |calendar|
    json.extract! calendar, :title, :color_R, :color_G, :color_B, :orner
    json.stamp_image calendar.stamp_image.url
  end
end