require 'importers/importers_helper'

RSpec.describe GetUserData do

  let!(:faculty1) { FactoryBot.create :faculty, access_id: 'xxx111' }
  
  let(:fake_book) do
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.row(1).replace []
    sheet.row(2).replace ['Last Name', 'First Name', 'Middle Name', 'Email', 'Username', 'User ID', 'PSU ID #', 'Enabled?', 'Has Access to Manage Activities?',
                          'Date Created', 'Campus', 'Campus Name', 'College', 'College Name', 'Department', 'Division', 'Institute', 'School', 'Security']
    sheet.row(3).replace ['X', 'Bill', 'X', 'X', 'zzz999', '123', 'X', 'Yes', 'Yes', 'X', 'UP', 'X', 'BA', 'X', 'X', 'X', 'X', 'X', 'X']
    sheet.row(4).replace ['X', 'Jimmy', 'X', 'X', 'xxx111', '321', 'X', 'No', 'No', 'X', 'UP', 'X', 'AG', 'X', 'X', 'X', 'X', 'X', 'X']
    sheet
  end

  let(:get_user_data_obj) {GetUserData.new}

  describe '#call' do
    it 'should get user data' do
      expect(Faculty.find(faculty1.id)).to be_present
      allow(Spreadsheet).to receive_message_chain(:open, :worksheet) {fake_book}
      get_user_data_obj.call
      expect(Faculty.all.count).to eq(1)
      expect(Faculty.find_by(access_id: 'zzz999').f_name).to eq('Bill')
      expect(Faculty.find_by(access_id: 'zzz999').college).to eq('BA')
      expect(Faculty.find_by(access_id: 'zzz999').campus).to eq('UP')
    end
  end

end
