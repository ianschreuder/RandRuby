class ClusterController < ApplicationController

  def individual
    @zoom = 8
    @center = Geokit::Geocoders::GoogleGeocoder.geocode("80202")
    facilities = Facility.find_by_sql(distance_sql(@center.lat, @center.lng, 100))
    @data_points = build_facility_data_as_hash(facilities)
    render(:index)
  end


  def group
    @zoom = 8
    @center = Geokit::Geocoders::GoogleGeocoder.geocode("80202")
    facilities = Facility.find_by_sql(distance_sql(@center.lat, @center.lng, 100))
    data = build_data_frame(facilities.collect(&:lat),facilities.collect(&:lng))
    @data_points = build_kmeans_as_hash(data, 3)
    render(:index)
  end

  private

  def distance_sql(lat, lng, limit)
    sql = "SELECT facilities.id, facilities.name, 
          3956 * 2 * ASIN(SQRT(POWER(SIN((#{lat} - ABS(locations.lat)) * pi()/180 / 2), 2) + 
            COS(#{lat} * pi()/180 ) * COS(ABS(locations.lat) * pi()/180) * 
            POWER(SIN((#{lng} - locations.lng) * pi()/180 / 2), 2))) as distance,
          locations.lat, locations.lng
          FROM facilities inner join locations on facilities.id = locations.facility_id 
          WHERE locations.lat is not null and locations.lng is not null
          ORDER BY distance limit #{limit};"
    sql
  end

  def build_facility_data_as_hash(facilities)
    facilities.inject({}){|h,f| h.merge!({f.id=>{:lat=>f.lat, :lng=>f.lng, :count=>1}}) }
  end

  def build_data_frame(latitudes,longitudes)
    data = {}
    data['latitude'] = latitudes
    data['longitude'] = longitudes
    $rsruby.as_data_frame(:x => data)
  end

  def build_kmeans_as_hash(df, points)
    kmeans = $rsruby.kmeans(df, points)
    data = {}
    points.times do |i|
      data["#{i}"] = {:lat=>kmeans["centers"][i][0],:lng=>kmeans["centers"][i][1],:count=>kmeans["size"][i]}
    end
    data
  end

end
