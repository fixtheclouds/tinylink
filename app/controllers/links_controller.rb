class LinksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new; end

  def create
    link = Link.new(link_params)
    link.short_url = generate_short_url unless params[:short_url].present?
    link.url = sanitize_url(params[:url])
    link.save_http_status
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
    params.permit(:url, :short_url, :http_status)
  end

  # Produces random Base36 8-character sequence
  def generate_short_url
    ("%d%d" % [rand(100), Time.now.to_i]).to_i.to_s(36)
  end

  def sanitize_url(url)
    url=~/^https?:\/\// ? url : "http://#{url}"
  end

end
