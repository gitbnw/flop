module ApplicationHelper
    
  def omniauth_icon_for provider
    { google_oauth2: "google-logo", facebook: "fb-logo", twitter: "twitter-logo" } [provider.to_sym] || provider.to_s
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def resource_class
    devise_mapping.to
  end
  
end
