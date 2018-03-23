class CreateContractFacultyLinks < ActiveRecord::Migration[5.1]
  def up
    create_table :contract_faculty_links do |t|
      t.references :contract, foreign_key: true
      t.references :faculty, foreign_key: true
      t.string :role
      t.integer :pct_credit

    end
  end
  
  def down
    if ActiveRecord::Base.connection.data_source_exists? 'contract_faculty_links'
      drop_table :contract_faculty_links
    end
  end
end