module UsersHelper
  def show_email(email)
    email == 'noemail@stuff.com' ? '' : email
  end
end