class StaticPagesController < ApplicationController
  before_action :has_access?, only:[:adminhome,:report]
  def home
  end

  def help
  end
  
  def adminhome
  end
  
  def report
    if params[:search]

      if params[:classification] && params[:dynasty]
       @users = User.where(:classification => params[:classification],:dynasty => params[:dynasty])
        @numbers = @users.count
         @total = 0
        @users.each do |user|
          @s = 0
          user.events.each do |event|
            @m = PointRule.find_by_name(event.category).score
            @s = @s + @m
          end
          @total = @total + @s
          @average = @total/@numbers
        end
         @report = {:total =>@total, :average =>@average}  
     elsif params[:classification]
     
        @users = User.where(:classification => params[:classification])
         @numbers = @users.count
         @total = 0
        @users.each do |user|
          @s = 0
          user.events.each do |event|
            @m = PointRule.find_by_name(event.category).score
            @s = @s + @m
          end
          @total = @total + @s
          @average = @total/@numbers
        end
         @report = {:total =>@total, :average =>@average}  
     elsif params[:dynasty]
        @users = User.where(:dynasty => params[:dynasty])
         @numbers = @users.count
         @total = 0
        @users.each do |user|
          @s = 0
          user.events.each do |event|
            @m = PointRule.find_by_name(event.category).score
            @s = @s + @m
          end
          @total = @total + @s
          @average = @total/@numbers
        end
      @report = {:total =>@total, :average =>@average}  
      end
    else
      @report = {:total =>"N/A", :average =>"N/A"} 
    end
  end
  
  def about
  end
  
  def contact
  end
  
  private
  
  
    def has_access?
      if (session[:admin_id] == nil)
      flash[:notice] ="You shoud have admin access to view this information"
      redirect_to root_url
      return
      end
    end

end
