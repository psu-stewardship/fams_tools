require 'rails_helper'

describe "#pub_integrate" do
  let!(:faculty_1) {
    Faculty.create(access_id: 'ljs123',
                   user_id:   '123456',
                   f_name:    'Larry',
                   l_name:    'Smith',
                   m_name:    '',
                   college:   'BA')
  }
  let!(:faculty_2) {
    Faculty.create(access_id: 'ajl123',
                   user_id:   '345678',
                   f_name:    'Abraham',
                   l_name:    'Lincoln',
                   m_name:    '',
                   college:   'LA')
  }

  let(:passcode) {
    Rails.application.config_for(:integration_passcode)[:passcode]
  }

  context 'when Publications Integration is selected', type: :feature, js: true do
    before do
      @pubs = File.read('spec/fixtures/metadata_pub_json.json').to_s

      stub_request(:post, "https://stage.metadata.libraries.psu.edu/v1/users/publications").
          with(
              body: "[\"ajl123\", \"ljs123\"]",
              headers: {
                  'Accept'=>'application/json',
                  'Content-Type'=>'application/json'
              }).
          to_return(status: 200, body: @pubs, headers: {})

      stub_request(:post, "https://betawebservices.digitalmeasures.com/login/service/v4/SchemaData/INDIVIDUAL-ACTIVITIES-University").
          with(
              body: pubs_body,
              headers: {
                  'Content-Type'=>'text/xml'
              }).
          to_return(status: 200, body: error_message, headers: {})
    end

    it "gets publication data sends data to activity insight" do
      visit ai_integration_path
      select("Publications Integration", from: "label_integration_type").select_option
      logger = double('logger')
      allow(Logger).to receive(:new).and_return(logger)
      expect(logger).to receive(:info).with(/Errors for Publications/)
      expect(logger).to receive(:error).with([/Unexpected EOF in prolog/])
      expect(page).to have_content("AI-Integration")
      within('#publications') do
        page.fill_in 'passcode', :with => passcode
        click_on 'Beta'
      end
      expect(page).to have_content("Integration completed")
    end

    it "redirects when wrong passcode supplied" do
      visit ai_integration_path
      select("Publications Integration", from: "label_integration_type").select_option
      expect(page).to have_content("AI-Integration")
      within('#publications') do
        click_on 'Beta'
      end
      expect(page).to have_content("Wrong Passcode")
    end
  end

  private

  def pubs_body
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<Data>\n  <Record username=\"ljs123\">\n    <INTELLCONT>\n      <TITLE access=\"READ_ONLY\">Title2</TITLE>\n      <TITLE_SECONDARY access=\"READ_ONLY\">Secondary Title2</TITLE_SECONDARY>\n      <CONTYPE access=\"READ_ONLY\">Academic Journal Article</CONTYPE>\n      <STATUS access=\"READ_ONLY\">Published</STATUS>\n      <JOURNAL_NAME access=\"READ_ONLY\">Another Journal</JOURNAL_NAME>\n      <VOLUME access=\"READ_ONLY\">2</VOLUME>\n      <DTY_PUB access=\"READ_ONLY\">2016</DTY_PUB>\n      <DTM_PUB access=\"READ_ONLY\">January (1st Quarter/Winter)</DTM_PUB>\n      <DTD_PUB access=\"READ_ONLY\">12</DTD_PUB>\n      <ABSTRACT access=\"READ_ONLY\">This is an abstract.</ABSTRACT>\n      <PAGENUM access=\"READ_ONLY\">200-250</PAGENUM>\n      <CITATION_COUNT access=\"READ_ONLY\">1</CITATION_COUNT>\n      <INTELLCONT_AUTH>\n        <FACULTY_NAME access=\"READ_ONLY\">123456</FACULTY_NAME>\n      </INTELLCONT_AUTH>\n      <INTELLCONT_AUTH>\n        <FNAME access=\"READ_ONLY\">Larry J.</FNAME>\n        <LNAME access=\"READ_ONLY\">Smith</LNAME>\n      </INTELLCONT_AUTH>\n    </INTELLCONT>\n  </Record>\n</Data>\n"
  end

  def error_message
    '<?xml version="1.0" encoding="UTF-8"?>

<Error>The following errors were detected:
  <Message>Unexpected EOF in prolog at [row,col {unknown-source}]: [1,0] Nested exception: Unexpected EOF in prolog at [row,col {unknown-source}]: [1,0]</Message>
</Error>'
  end
end