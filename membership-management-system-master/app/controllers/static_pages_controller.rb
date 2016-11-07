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
         @point = {}
        @users.each do |user|
          @s = 0
          user.events.each do |event|
            @m = PointRule.find_by_name(event.category).score
            @s = @s + @m
          end
          @point[user.uin] = @s
          @total = @total + @s
          @average = @total/@numbers
        end
         @report = {:Total =>@total, :Average =>@average}  
     elsif params[:classification]
     
        @users = User.where(:classification => params[:classification])
         @numbers = @users.count
         @total = 0
        @point = {}
        @users.each do |user|
          @s = 0
          user.events.each do |event|
            @m = PointRule.find_by_name(event.category).score
            @s = @s + @m
          end
          @point[user.uin] = @s
          @total = @total + @s
          @average = @total/@numbers
        end
         @report = {:Total =>@total, :Average =>@average}  
     elsif params[:dynasty]
        @users = User.where(:dynasty => params[:dynasty])
         @numbers = @users.count
         @total = 0
        @point = {}
        @users.each do |user|
          @s = 0
          user.events.each do |event|
            @m = PointRule.find_by_name(event.category).score
            @s = @s + @m
          end
          @point[user.uin] = @s
          @total = @total + @s
          @average = @total/@numbers
        end
      @report = {:Total =>@total, :Average =>@average}  
      end
    else
      @point={}
      @users={}
      @report = {:Total =>"N/A", :Average =>"N/A"} 
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
