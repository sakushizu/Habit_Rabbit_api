json.stamped_dates do
  json.array! @stamped_dates do |date|
    json.extract! date, :date
  end
end