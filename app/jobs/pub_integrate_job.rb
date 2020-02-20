class PubIntegrateJob < ApplicationJob

  def perform(params, log_path)
    import_pubs = GetPubData.new(params[:college])
    error_logger = Logger.new("public/#{log_path}")
    error_logger.info "Publications Integration to #{params[:target]} initiated at: #{DateTime.now}"
    import_pubs.call(PubPopulateDB.new)
    my_integrate = IntegrateData.new(PubXMLBuilder.new, params[:target])
    errors = my_integrate.integrate
    error_logger.info "Errors for Publications Integration to #{params[:target]} at: #{DateTime.now}"
    error_logger.error errors
  end
end
