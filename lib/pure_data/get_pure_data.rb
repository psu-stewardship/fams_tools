class GetPureData
  attr_accessor :pure_ids, :pure_xmls, :pure_hash

  def initialize
    @pure_ids = PureId.all
    @pure_xmls = {}
    @pure_hash = {}
  end

  def call
    get_pub_xmls
    xml_to_hash(pure_xmls)
  end

  private

  def get_pub_xmls
    headers = {"Accept" => "application/xml", "api-key" => "#{Rails.application.config_for(:pure)[:api_key]}"}
    pure_ids.each do |id|
      url = "https://pennstate.pure.elsevier.com/ws/api/511/persons/#{id.pure_id}/research-outputs"
      response = HTTParty.get url, :headers => headers, :timeout => 100
      pure_xmls[id.faculty.access_id] = response
    end
  end

  def xml_to_hash(pure_xmls)
    pure_xmls.each do |k,xml|
      noko_obj = Nokogiri::XML.parse(xml.to_s)
      noko_obj.xpath('result//contributionToJournal').each do |publication|
        if pure_hash[k]
          pure_hash[k] << {:title => publication.xpath('title').text,
                           :type => publication.xpath('type').text,
                           :volume => publication.xpath('volume').text,
                           :status => publication.xpath('publicationStatuses//publicationStatus//publicationStatus').text,
                           :dty => publication.xpath('publicationStatuses//publicationDate//year').text,
                           :dtm => publication.xpath('publicationStatuses//publicationDate//month').text,
                           :dtd => publication.xpath('publicationStatuses//publicationDate//day').text,
                           :persons => publication.xpath('personAssociations//personAssociation').collect {
                             |x| {:fName => x.xpath('name//firstName').text,
                                  :mName => x.xpath('name//middleName').text, 
                                  :lName => x.xpath('name//lastName').text,
                                  :role => x.xpath('personRole').text,
                                  :extOrg => x.xpath('externalOrganisations//externalOrganisation//name').text}
                           },
                           :journalTitle => publication.xpath('journalAssociation//title').text,
                           :journalIssn => publication.xpath('journalAssociation//issn').text,
                           :journalNum => publication.xpath('journalNumber').text,
                           :pages => publication.xpath('pages').text,
                           :articleNumber => publication.xpath('articleNumber').text,
                           :peerReview => publication.xpath('peerReview').text,
                           :url => publication.xpath('electronicVersions//electronicVersion//doi').text}
        else
          pure_hash[k] =  [{:title => publication.xpath('title').text,
                           :type => publication.xpath('type').text,
                           :volume => publication.xpath('volume').text,
                           :status => publication.xpath('publicationStatuses//publicationStatus//publicationStatus').text,
                           :dty => publication.xpath('publicationStatuses//publicationDate//year').text,
                           :dtm => publication.xpath('publicationStatuses//publicationDate//month').text,
                           :dtd => publication.xpath('publicationStatuses//publicationDate//day').text,
                           :persons => publication.xpath('personAssociations//personAssociation').collect {
                             |x| {:fName => x.xpath('name//firstName').text,
                                  :mName => x.xpath('name//middleName').text, 
                                  :lName => x.xpath('name//lastName').text,
                                  :role => x.xpath('personRole').text,
                                  :extOrg => x.xpath('externalOrganisations//externalOrganisation//name').text}
                           },
                           :journalTitle => publication.xpath('journalAssociation//title').text,
                           :journalIssn => publication.xpath('journalAssociation//issn').text,
                           :journalNum => publication.xpath('journalNumber').text,
                           :pages => publication.xpath('pages').text,
                           :articleNumber => publication.xpath('articleNumber').text,
                           :peerReview => publication.xpath('peerReview').text,
                           :url => publication.xpath('electronicVersions//electronicVersion//doi').text}]
        end
      end
    end
  end

end
