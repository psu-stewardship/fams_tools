class LdapIntegrateJob < ApplicationJob

  def perform(params, log_path)
    error_logger = Logger.new("public/#{log_path}")
    error_logger.info "Personal & Contact Info Integration to #{params[:target]} initiated at: #{DateTime.now}"
    import_ldap = ImportLdapData.new
    import_ldap.import_ldap_data
    ldap_integrate = IntegrateData.new(LdapXmlBuilder.new, params[:target])
    errors = ldap_integrate.integrate
    error_logger.info "Errors for Personal & Contact Info Integration to #{params[:target]} at: #{DateTime.now}"
    error_logger.error errors
  end
end
