class ContactMessagesController < ApplicationController
  def create
    puts "hello"
    @name = params[:name]
    @email = params[:email]
    @subject = params[:subject]
    @content = params[:content]
    ContactMailer.welcome_email(@name, @email, @subject, @content).deliver
    redirect_to new_contact_message_path
  end

  def new
  end
end