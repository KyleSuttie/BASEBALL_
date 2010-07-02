class PlayersController < ApplicationController
  def index
    #debugger
      @sorts = ['Name', 'Team', 'AVG', 'HR', 'RBI', 'RUNS', 'SB', 'OPS', 'GAMES']
    if params[:dir] != "ASC" and params[:dir] != "DESC"
      @players = Player.find(:all,
			     :conditions => "AVG != 'NaN'",
			     :order => "AVG DESC",
			     :limit => 25)
      params[:dir] = "DESC"
      params[:sort] = "AVG"
      respond_to do |format|
        format.html
      end
    else
      @players = Player.find(:all,
			     :conditions => "AVG != 'NaN' AND OPS != 'NaN'",
			     :order => params[:sort] + ' ' + params[:dir],
			     :limit => 25)
      respond_to do |format|
        format.js
      end
    end 
  end

  def sort
    redirect_to :action => 'index', :sort => params[:sort], :dir => params[:dir]
  end
end
