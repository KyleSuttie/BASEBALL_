require "rexml/document"
class PlayersController < ApplicationController
include REXML
  def index
      debugger
      @teams = Team.find(:all, :order => 'name')
      @fields = ['name', 'teamname', 'avg', 'hr', 'rbi', 'runs', 'sb', 'ops', 'games']
      currentteam = Integer(params[:currentteam])
    if params[:dir] != "ASC" and params[:dir] != "DESC"
      params[:page] = "1"
      params[:dir] = "DESC"
      params[:field] = "avg"
      
      @order = params[:field] + ' ' + params[:dir]
      @players = Player.paginate :page => Integer(params[:page]),
				 :conditions => "avg != 'NaN' AND ops != 'NaN'",
				 :order => @order
      respond_to do |format|
        format.html
      end
    else
      #debugger
      
      @order = params[:field] + ' ' + params[:dir]
      if currentteam == 0
        @players = Player.paginate :page => Integer(params[:page]),
				   :conditions => "avg != 'NaN' AND ops != 'NaN'",
				   :order => @order
      else
        @players = Team.find(:first, :conditions => ["id = ?", currentteam]).players.paginate :page => Integer(params[:page]),
			     :conditions => "avg != 'NaN' AND ops != 'NaN'",
			     :order => @order
      end
      respond_to do |format|
        format.js
      end
    end
  end

  def sort
    redirect_to :action => 'index', :field => params[:field], :dir => params[:dir], :page => params[:page], :currentteam => params[:currentteam]
  end

  def upload
    Player.delete_all
    Team.delete_all
    Division.delete_all
    League.delete_all

    file = params[:file]
    doc = REXML::Document.new file

    doc.elements.each("SEASON/LEAGUE"){ |league|
      currentleague = League.create(:name => league.elements[1].text)
      league.elements.each("DIVISION"){ |division|
      currentdivision = Division.create(:league_id => currentleague.id,
		        :name => division.elements[1].text)
        division.elements.each("TEAM"){ |team|
        currentteam = Team.create(:division_id => currentdivision.id,
		      :city => team.elements[1].text,
		      :name => team.elements[2].text)
          team.elements.each("PLAYER"){ |player|
            if (Player.is_batter?(player))
              Player.create(:team_id => currentteam.id,
		            :name => player.elements[1].text + ' ' + player.elements[2].text,
		            :teamname => currentteam.city + ' ' + currentteam.name,
		            :avg => Player.get_avg(player),
		            :hr => Player.get_hr(player),
		            :rbi => Float(player.elements[12].text),
		            :runs => Integer(player.elements[7].text),
		            :sb => Float(player.elements[13].text),
		            :ops => Player.get_ops(player),
		            :games => Integer(player.elements[4].text))
            end
          }
        }
      }
    }
    redirect_to :action => 'index'
  end

  def delete
    params[:currentteam] = nil
    redirect_to :action => 'index', :currentteam => params[:currentteam]
  end

end
