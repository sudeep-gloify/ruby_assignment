class BookMailer < ApplicationMailer
    # default from: 'kotarisudeep@gmail.com'

    def book_update_email
        @user = User.find(params[:user])

        mail(to: @user.email, subject: 'Book updated')
  end
end
