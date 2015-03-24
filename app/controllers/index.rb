# ----- index -----

get "/" do
  @urls = Url.all.order(updated_at: :desc)
  erb :index
end

# ---- route for generating short url for long urls both from index and from profile ----

post "/urls" do
  long_url = params[:long_url_input]
  short_url = Url.generate_short_url(long_url)
  if session_logged_in?
    user_id = session_current_user.id
    Url.create(full_url: long_url, shortened_url: short_url, user_id: user_id)
    redirect ("/accounts/"+ session_current_user.username)
  else
    Url.create(full_url: long_url, shortened_url: short_url)
    redirect ("/")
  end
end

# NOTE: get "/:short_url" is at the bottom to avoid conflicts with other /some_word routes

# ----- registration -----

get "/accounts/register" do
  erb :register
end

post "/accounts/register" do
  @user = User.new(
    name: params[:name],
    username: params[:username],
    email: params[:email],
    password_hash: params[:password]
    )
  if @user.save
    session[:current_user_id] = @user.id
    username = session_current_user.username
    redirect ("/accounts/"+ username)
  else
    @errors = @user.errors.full_messages
    erb :register #add error messages
  end
end

# ----- log in -----

get "/accounts/login" do
  erb :login
end

post "/accounts/login" do
  @user = User.find_by(username: params[:username])
  if @user.password_hash == params[:password] #BCRYPT DOCS
    session[:current_user_id] = @user.id
    username = session_current_user.username
    redirect ("/accounts/"+ username)
  else
    # currently breaks if username does not exist, works if username exists, but password is wrong
    @error = "Sorry, your username or password did not match. Please try again."
    erb :login
  end
end

get "/accounts/logout" do
  session.clear
  redirect ("/")
end

# ----- profile -----
get "/accounts/:username" do
  @user = session_current_user
  @users_urls = @user.urls.order(updated_at: :desc)
  erb :profile
end

# ----- redirecting short urls to long urls -----
# must be below "/some_route" or else routing gets confused

get "/:short_url" do
  @full_url_for_redirect = Url.find_by(shortened_url: params[:short_url]).full_url
  Url.update_click_count(params[:short_url])
  redirect to(@full_url_for_redirect)
end