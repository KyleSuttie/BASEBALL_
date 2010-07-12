class PlayersController < ApplicationController
  def index
      @fields = ['Name', 'Team', 'AVG', 'HR', 'RBI', 'Runs', 'SB', 'OPS', 'Games']
      @conds = "NaN"
      @conds_two = "AVG != ? AND OPS != ?"
    if params[:dir] != "ASC" and params[:dir] != "DESC"
      params[:page] = "1"
      params[:dir] = "DESC"
      params[:field] = "AVG"
      @order = params[:field] + ' ' + params[:dir]
      @players = Player.paginate :page => Integer(params[:page]),
				 :conditions => [@conds_two, @conds, @conds],
				 :order => @order
      respond_to do |format|
        format.html
      end
    else
      @order = params[:field] + ' ' + params[:dir]
      @players = Player.paginate :page => Integer(params[:page]),
				 :conditions => [@conds_two, @conds, @conds],
				 :order => @order
      respond_to do |format|
        format.js
      end
    end

  end

  def sort
    redirect_to :action => 'index', :field => params[:field], :dir => params[:dir], :page => params[:page]
  end

  def upload
    debugger
    file = params[:file]
    fname = file.original_filename
    redirect_to :action => 'index', :tester => fname
  end

end
