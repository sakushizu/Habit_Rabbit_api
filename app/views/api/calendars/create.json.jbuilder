json.calendar do
  json.extract! @calendar, :title, :color_R, :color_G, :color_B, :stamp_image, :orner
  json.stamp_image @calendar.stamp_image.url
end








