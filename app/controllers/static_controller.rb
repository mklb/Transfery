class StaticController < ApplicationController
  before_action :authenticate_user!, only: [:faq]

  def home
  end

  def imprint
  end

  def privacy
  end

  def terms
  end

  def faq
    render layout: "user_dashboard"
  end
end
