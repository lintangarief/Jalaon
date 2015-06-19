class AccountController < ApplicationController
  before_action :set_account, only: [:edit, :profile]
  before_action :set_verify, only: [:verify]
  before_action :set_conversation, only: [:show_message]

  def profile
    @services = @user.services
    @statusverify = @user.verify_user
  end

  def edit
  end

  def update

  end
  
  def verify
    
  end

  def update_verify
    respond_to do |format|
      if current_user.verify_user.update(params_verify)
        format.html { redirect_to edit_verify_account_path(params[:id]), notice: 'Request Verify was successfully Send.' }
      else
        format.html { redirect_to edit_verify_account_path(params[:id]), notice: 'Request Verify was Unsuccessfully Send.' }
      end
    end
  end

  def setting

  end

  def send_message
    @user = User.find(params[:message][:owner_id])
    current_user.send_message(@user, params[:message][:body], params[:message][:subject])
    if params[:message][:type] == "show_service"
      redirect_to service_path(params[:message][:service_id])
    end
  end

  def message
    @inbox = current_user.mailbox.inbox
    @send_box = current_user.mailbox.sentbox
    @trash = current_user.mailbox.trash
  end

  def sendbox
    @send_box = current_user.mailbox.sentbox
  end

  def trash
    
  end

  def show_message

  end

  def reply
    @conversation = current_user.mailbox.conversations.find(params[:reply][:conversation_id])
    current_user.reply_to_conversation(@conversation, params[:reply][:body])
    redirect_to detail_message_url(params[:reply][:conversation_id])
  end

  def move_trash

    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.move_to_trash(current_user)
    redirect_to show_message_url
  end

  def move_untrash
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.untrash(current_user)
    redirect_to show_message_url
  end

  def mark_delete
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.mark_as_deleted(current_user)
    redirect_to show_message_url
  end

  private
    def set_account
      @user = User.find(params[:id])
    end

    def set_conversation
      @message = current_user.mailbox.conversations.find(params[:id])
    end

    def set_verify
      @verify = current_user.verify_user
    end
    
    def params_verify
      params.require(:verify).permit(:id, :foto_ktp)
    end
end