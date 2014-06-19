class Docthis::DocumentationController < Docthis::ApplicationController
  before_action :authenticate_if_required

  def show
    @pages = Docthis::Page.all
    @page = Docthis::Page.find(params[:id])
  end

  protected
  def authenticate_if_required
    if Docthis.use_basic_auth
      authenticated = authenticate_with_http_basic do |u, p|
        u == Docthis.basic_auth_username and p == Docthis.basic_auth_password
      end

      request_http_basic_authentication unless authenticated
    end
  end
end
