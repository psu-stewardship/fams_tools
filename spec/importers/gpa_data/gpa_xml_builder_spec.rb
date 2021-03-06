require 'importers/importers_helper'

RSpec.describe GpaXmlBuilder do

  let!(:faculty) { FactoryBot.create :faculty, college: 'LA' }
  let!(:gpa1) { FactoryBot.create :gpa, faculty: faculty }
  let!(:gpa2) { FactoryBot.create :gpa, faculty: faculty }
  let(:xml_builder_obj) { described_class.new }

  describe "#batched_gpa_xmls" do
    it "should return an array of gpa data xmls" do
      expect(xml_builder_obj.xmls_enumerator.first).to eq(
"<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<Data>
  <Record username=\"#{faculty.access_id}\">
    <GRADE_DIST_GPA>
      <TYT_TERM>Spring</TYT_TERM>
      <TYY_TERM>#{DateTime.now.year}</TYY_TERM>
      <COURSEPRE>CRIM</COURSEPRE>
      <COURSENUM>1</COURSENUM>
      <COURSENUM_SUFFIX/>
      <SECTION>001</SECTION>
      <CAMPUS>UP</CAMPUS>
      <NUMGRADES>15</NUMGRADES>
      <STEARNA>10</STEARNA>
      <STEARNAMINUS>9</STEARNAMINUS>
      <STEARNBPLUS>6</STEARNBPLUS>
      <STEARNB>8</STEARNB>
      <STEARNBMINUS>7</STEARNBMINUS>
      <STEARNCPLUS>4</STEARNCPLUS>
      <STEARNC>5</STEARNC>
      <STEARND>3</STEARND>
      <STEARNF>2</STEARNF>
      <STEARNW>1</STEARNW>
      <STEARNL>1</STEARNL>
      <STEARNOTHER>0</STEARNOTHER>
      <GPA>3.5</GPA>
    </GRADE_DIST_GPA>
    <GRADE_DIST_GPA>
      <TYT_TERM>Spring</TYT_TERM>
      <TYY_TERM>#{DateTime.now.year}</TYY_TERM>
      <COURSEPRE>CRIM</COURSEPRE>
      <COURSENUM>2</COURSENUM>
      <COURSENUM_SUFFIX/>
      <SECTION>001</SECTION>
      <CAMPUS>UP</CAMPUS>
      <NUMGRADES>15</NUMGRADES>
      <STEARNA>10</STEARNA>
      <STEARNAMINUS>9</STEARNAMINUS>
      <STEARNBPLUS>6</STEARNBPLUS>
      <STEARNB>8</STEARNB>
      <STEARNBMINUS>7</STEARNBMINUS>
      <STEARNCPLUS>4</STEARNCPLUS>
      <STEARNC>5</STEARNC>
      <STEARND>3</STEARND>
      <STEARNF>2</STEARNF>
      <STEARNW>1</STEARNW>
      <STEARNL>1</STEARNL>
      <STEARNOTHER>0</STEARNOTHER>
      <GPA>3.5</GPA>
    </GRADE_DIST_GPA>
  </Record>
</Data>
")
    end
  end
end