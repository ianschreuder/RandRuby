require 'csv'

def address_to_string(home)
  "#{home.street}, #{home.city}, #{home.state}, #{home.zip}"
end

CSV.foreach("#{Rails.root}/data/NHC_NH.csv", {:headers => true} ) do |row|
  f=Facility.find_by_prov_num(row["ProvNum"])
  next if f.present?

  f=Facility.new
  f.prov_num=row["ProvNum"]
  f.name=row["NursingHomeName"]
  f.save

  next if f.location.present?

  l=Location.new
  l.facility=f
  l.street = row["Street"]
  l.city = row["City"]
  l.state = row["State"]
  l.zip = row["ZipCode"]
  l.save

  geo = Geokit::Geocoders::GoogleGeocoder.geocode(address_to_string(l))
  next if geo.lat.blank? || geo.lng.blank?
  ActiveRecord::Base.connection.execute("update locations set lng=#{geo.lng},lat=#{geo.lat} where id = #{l.id}")
  sleep(0.1)

end
