class PlayersController < ApplicationController
  def index
    #debugger
      @fields = ['Name', 'Team', 'AVG', 'HR', 'RBI', 'Runs', 'SB', 'OPS', 'Games']
    if params[:dir] != "ASC" and params[:dir] != "DESC"
      params[:page] = "1"
      params[:dir] = "DESC"
      params[:sort] = "AVG"
      @players = Player.paginate :page => Integer(params[:page]),
			         :conditions => "AVG != 'NaN' AND OPS != 'NaN'",
			         :order => params[:sort] + ' ' + params[:dir]
      respond_to do |format|
        format.html
      end 
    else
    #debugger
      @players = Player.paginate :page => Integer(params[:page]),
			         :conditions => "AVG != 'NaN' AND OPS != 'NaN'",
			         :order => params[:sort] + ' ' + params[:dir] 
      respond_to do |format|
        format.js
      end
    end 
  end

  def sort
    redirect_to :action => 'index', :sort => params[:sort], :dir => params[:dir], :page => params[:page]
  end
end
