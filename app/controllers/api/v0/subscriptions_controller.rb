class Api::V0::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.new(subscription_params)
    subscription.save!
    render json: { message: "#{Subscription.last.title} added."}, status: 201
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription_title = subscription.title
    subscription.destroy!
    render json: { message: "#{subscription_title} deleted." }
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end