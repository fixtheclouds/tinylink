class LinksController < ApplicationController

  def new; end

  def create
    link = Link.new(link_params)
    if link.save
      render json: { url: "#{request.protocol + request.host_with_port}/#{link.short_url}" }
    else
      render json: link.errors.full_messages, status: 422
    end
  end

  def redirect
    link = Link.find_by_short_url(params[:short_url])
    redirect_to link.url, status: 301
  end

  private

  def link_params
    params.permit(:url, :short_url)
  end

end
