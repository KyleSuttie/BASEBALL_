require "rexml/document"
class PlayersController < ApplicationController
include REXML
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
    Player.delete_all
    file = params[:file]
    doc = REXML::Document.new file
    doc.elements.each("SEASON/LEAGUE/DIVISION/TEAM"){ |team|
      Team.create(:city => team.elements[1].text,
		  :name => team.elements[2].text)
      }
    doc.elements.each("SEASON/LEAGUE/DIVISION/TEAM/PLAYER"){ |player|
      if (Player.is_batter?(player))
        Player.create(:team_id => Team.find(2),
		      :name => player.elements[1].text + ' ' + player.elements[2].text,
		      :team => player.parent.elements[1].text + ' ' + player.parent.elements[2].text,
		      :avg => Player.get_avg(player),
		      :hr => Player.get_hr(player),
		      :rbi => Float(player.elements[12].text),
		      :runs => Integer(player.elements[7].text),
		      :sb => Float(player.elements[13].text),
		      :ops => Player.get_ops(player),
		      :games => Integer(player.elements[4].text))
            end
           }
    redirect_to :action => 'index'
  end

  def delete
    Team.delete_all
    Player.delete_all
    redirect_to :action => 'index', :dir => 'nil'
  end

end
