class PlayersController < ApplicationController
  def index
    if params[:dir] != "ASC" and params[:dir] != "DESC"
      @players = Player.find(:all,
			     :conditions => "AVG != 'NaN'",
			     :order => "AVG DESC",
			     :limit => 25)
    else
      @players = Player.find(:all,
			     :conditions => ["AVG != 'NaN'", "OPS != 'NaN'"],
			     :order => params[:sort] + ' ' + params[:dir],
			     :limit => 25)
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def sort
    redirect_to :action => 'index', :sort => params[:sort], :dir => params[:dir]
  end
end
