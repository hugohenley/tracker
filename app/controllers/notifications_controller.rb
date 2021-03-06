class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
    @notification.contact_notifications.build
  end
  
  def edit
    @notification = Notification.find(params[:id])
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to notifications_path, notice: "Notification saved with success!"
    else
      render :new, error: "Something went wrong, please try again."
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    if @notification.delete
      redirect_to notifications_path, notice: "Notification deleted with success!"
    else
      redirect_to notifications_path, error: "Something went wrong, please try again."
    end
  end


  private
  def notification_params
    params.require(:notification).permit(:name, :project_id, :notification_type, contact_notifications_attributes: [:id, :contact_id, :_destroy])
  end

end
