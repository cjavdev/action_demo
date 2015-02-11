class WebhooksController < ApplicationController
  wrap_parameters :webhook, include: [:action]

  def new
  end

  def create
    render json: params
  end
end
