class Api::V0::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)
    subscription.save!
    render json: { message: "#{Subscription.last.title} added."}, status: 201
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency)
  end
end