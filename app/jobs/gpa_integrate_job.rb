class GpaIntegrateJob < ApplicationJob

  def integrate(params, _user_uploaded = true)
    f_name = params[:gpa_file].original_filename
    f_path = File.join('app', 'parsing_files', f_name)
    File.open(f_path, "wb") { |f| f.write(params[:gpa_file].read) }
    gpa_importer = ImportGpaData.new(f_path)
    gpa_importer.import
    gpa_xml_builder = GpaXmlBuilder.new.xmls_enumerator
    gpa_integration = IntegrateData.new(gpa_xml_builder, params[:target], :post)
    errors = gpa_integration.integrate
    File.delete(f_path) if File.exist?(f_path)
    errors
  end

  private

  def name
    'GPA Integration'
  end
end
