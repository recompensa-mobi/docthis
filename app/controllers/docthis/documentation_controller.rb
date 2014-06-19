class Docthis::DocumentationController < Docthis::ApplicationController
  def show
    @pages = Docthis::Page.all
    @page = Docthis::Page.find(params[:id])
  end
end
