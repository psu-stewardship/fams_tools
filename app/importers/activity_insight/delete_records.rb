class DeleteRecords

  def delete(xlsx_path)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Data {
        xml.SCHTEACH {
          Creek::Book.new('data/delete.xlsx').sheets[0].rows.each_with_index do |row, index|
            unless row.empty?
              row.each do |k,v|
                xml.item( 'id' => v ) if index != 0
              end
            else
              break
            end
          end
        }
      }
    end
    request(builder.to_xml)
  end

  private

  def request(data)
    auth = {:username => Rails.application.config_for(:activity_insight)["webservices"][:username],
            :password => Rails.application.config_for(:activity_insight)["webservices"][:password]}
    url = 'https://betawebservices.digitalmeasures.com/login/service/v4/SchemaData:delete/INDIVIDUAL-ACTIVITIES-University'
    response = HTTParty.post url, :basic_auth => auth, :body => data, :headers => {'Content-type' => 'text/xml'}, :timeout => 320
    #puts response
  end

end