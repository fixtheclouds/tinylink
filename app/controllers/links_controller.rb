class LinksController < ApplicationController
  def redirect

    link = Link.find_by_short_url(params[:short_url])
    redirect_to link.url

  end
end
