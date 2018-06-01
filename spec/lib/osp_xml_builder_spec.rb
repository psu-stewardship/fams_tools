require 'rails_helper'
require 'osp_xml_builder'
require 'byebug'

RSpec.describe OspXMLBuilder do

  let(:data_sets) do
    [{'ospkey' => 123456, 'title' => 'Title', 'status' => 'Pending', 'submitted' => '2016-01-01',
      'awarded' => '', 'requested' => 1000, 'funded' => '', 'totalanticipated' => '', 'startdate' => '',
      'enddate' => '', 'grantcontract' => '', 'baseagreement' => '', 'accessid' => 'aaa111', 'f_name' => 'Bill',
      'l_name' => 'Billy', 'm_name' => 'Billiam', 'sponsor' => 'Sponsor', 'sponsortype' => 'Big Sponsor',
      'role' => 'Principal Investigator', 'pctcredit' => 100, 'id_number' => 123},
      {'ospkey' => 654321, 'title' => 'Title', 'status' => 'Pending', 'submitted' => '2016-01-01',
      'awarded' => '', 'requested' => 1000, 'funded' => '', 'totalanticipated' => '', 'startdate' => '',
      'enddate' => '', 'grantcontract' => '', 'baseagreement' => '', 'accessid' => 'bbb222', 'f_name' => 'Bill',
      'l_name' => 'Billy', 'm_name' => 'Billiam', 'sponsor' => 'Sponsor2', 'sponsortype' => 'Big Sponsor',
      'role' => 'Principal Investigator', 'pctcredit' => 100, 'id_number' => 321}]
  end

  let(:osp_xml_builder_obj) {OspXMLBuilder.new}

  describe '#batched_osp_xml' do
    it 'should return an xml of CONGRANT records' do
      data_sets.each do |row|
        sponsor = Sponsor.create(sponsor_name: row['sponsor'],
                                 sponsor_type: row['sponsortype'])

        contract = Contract.create(osp_key:           row['ospkey'],
                                   title:             row['title'],
                                   sponsor:           sponsor,
                                   status:            row['status'],
                                   submitted:         row['submitted'],
                                   awarded:           row['awarded'],
                                   requested:         row['requested'],
                                   funded:            row['funded'],
                                   total_anticipated: row['totalanticipated'],
                                   start_date:        row['startdate'],
                                   end_date:          row['enddate'],
                                   grant_contract:    row['grantcontract'],
                                   base_agreement:    row['baseagreement'])

        faculty = Faculty.create(access_id: row['accessid'],
                                 f_name:    row['f_name'],
                                 l_name:    row['l_name'],
                                 m_name:    row['m_name'])

        ContractFacultyLink.create(contract:   contract,
                                   faculty:    faculty,
                                   role:       row['role'],
                                   pct_credit: row['pctcredit'])

        UserNum.create(faculty:   faculty,
                       id_number: row['id_number'])
      end
      expect(osp_xml_builder_obj.batched_osp_xml).to eq([
'<?xml version="1.0" encoding="UTF-8"?>
<Data>
  <Record username="aaa111">
    <CONGRANT>
      <OSPKEY access="LOCKED">123456</OSPKEY>
      <BASE_AGREE access="LOCKED"/>
      <TYPE access="LOCKED"/>
      <TITLE access="LOCKED">Title</TITLE>
      <SPONORG access="LOCKED">Sponsor</SPONORG>
      <AWARDORG access="LOCKED">Big Sponsor</AWARDORG>
      <CONGRANT_INVEST>
        <FACULTY_NAME>123</FACULTY_NAME>
        <FNAME>Bill</FNAME>
        <MNAME>Billiam</MNAME>
        <LNAME>Billy</LNAME>
        <ROLE>Principal Investigator</ROLE>
        <ASSIGN>100</ASSIGN>
      </CONGRANT_INVEST>
      <AMOUNT_REQUEST access="LOCKED">1000</AMOUNT_REQUEST>
      <AMOUNT_ANTICIPATE access="LOCKED"/>
      <AMOUNT access="LOCKED"/>
      <STATUS access="LOCKED">Pending</STATUS>
      <DTM_SUB access="LOCKED">January</DTM_SUB>
      <DTD_SUB access="LOCKED">01</DTD_SUB>
      <DTY_SUB access="LOCKED">2016</DTY_SUB>
      <DTM_AWARD/>
      <DTD_AWARD/>
      <DTY_AWARD/>
      <DTM_START/>
      <DTD_START/>
      <DTY_START/>
      <DTM_END/>
      <DTD_END/>
      <DTY_END/>
    </CONGRANT>
  </Record>
  <Record username="bbb222">
    <CONGRANT>
      <OSPKEY access="LOCKED">654321</OSPKEY>
      <BASE_AGREE access="LOCKED"/>
      <TYPE access="LOCKED"/>
      <TITLE access="LOCKED">Title</TITLE>
      <SPONORG access="LOCKED">Sponsor2</SPONORG>
      <AWARDORG access="LOCKED">Big Sponsor</AWARDORG>
      <CONGRANT_INVEST>
        <FACULTY_NAME>321</FACULTY_NAME>
        <FNAME>Bill</FNAME>
        <MNAME>Billiam</MNAME>
        <LNAME>Billy</LNAME>
        <ROLE>Principal Investigator</ROLE>
        <ASSIGN>100</ASSIGN>
      </CONGRANT_INVEST>
      <AMOUNT_REQUEST access="LOCKED">1000</AMOUNT_REQUEST>
      <AMOUNT_ANTICIPATE access="LOCKED"/>
      <AMOUNT access="LOCKED"/>
      <STATUS access="LOCKED">Pending</STATUS>
      <DTM_SUB access="LOCKED">January</DTM_SUB>
      <DTD_SUB access="LOCKED">01</DTD_SUB>
      <DTY_SUB access="LOCKED">2016</DTY_SUB>
      <DTM_AWARD/>
      <DTD_AWARD/>
      <DTY_AWARD/>
      <DTM_START/>
      <DTD_START/>
      <DTY_START/>
      <DTM_END/>
      <DTD_END/>
      <DTY_END/>
    </CONGRANT>
  </Record>
</Data>
'
      ])
        end
      end
    end

