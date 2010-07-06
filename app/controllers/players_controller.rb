class PlayersController < ApplicationController
  def index
      @fields = ['Name', 'Team', 'AVG', 'HR', 'RBI', 'Runs', 'SB', 'OPS', 'Games']
      @conds = "NaN"
    if params[:dir] != "ASC" and params[:dir] != "DESC"
      params[:page] = "1"
      params[:dir] = "DESC"
      params[:field] = "AVG"
      @players = Player.paginate :page => Integer(params[:page]),
				 :conditions => ["AVG != ? AND OPS != ?", @conds, @conds],
				 :order => params[:field] + ' ' + params[:dir]
      respond_to do |format|
        format.html
      end
    else
      @players = Player.paginate :page => Integer(params[:page]),
				 :conditions => ["AVG != ? AND OPS != ?", @conds, @conds],
				 :order => params[:field] + ' ' + params[:dir]
      respond_to do |format|
        format.js
      end
    end 

  end

  def sort
    redirect_to :action => 'index', :field => params[:field], :dir => params[:dir], :page => params[:page]
  end



  def upload_file
    post = Player.save(params[:upload])
    render :text => "File has been uploaded successfully"
  end
    
end
