require "rexml/document"
class TeamsController < ApplicationController
include REXML

#=begin
  active_scaffold :teams do |config|
    config.columns = [:city, :name, :division, :players]
    list.sorting = {:city => 'ASC'}
    
    config.action_links.add 'upload_form', :label => "Upload", :type => :collection
  end

  ActiveScaffold.set_defaults do |config|
    config.ignore_columns.add [:created_at, :updated_at]
  end
#=end



  def upload_form
    #debugger
    render :partial => "upload"
  end
   
  def upload
    file = params[:file]
    doc = REXML::Document.new file
    Player.delete_all
    Team.delete_all
    Division.delete_all
    League.delete_all
    doc.elements.each("SEASON/LEAGUE"){ |league|
      currentleague = League.create(:name => league.elements[1].text)
      league.elements.each("DIVISION"){ |division|
      currentdivision = Division.create(:league_id => currentleague.id,
					:name => league.elements[1].text + ' ' + division.elements[1].text)
        division.elements.each("TEAM"){ |team|
        currentteam = Team.create(:division_id => currentdivision.id,
				  :city => team.elements[1].text,
				  :name => team.elements[2].text)
          team.elements.each("PLAYER"){ |player|
            if (Player.is_batter?(player))
              Player.create(:team_id => currentteam.id,
		            :name => player.elements[1].text + ' ' + player.elements[2].text,
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
end


=begin
  def index
    @teams = Team.find(:all, :order => "name")
    respond_to do |format|
      format.html
    end
  end

  def show
    team = params[:id]
    @teamname = Team.find(team).city + ' ' + Team.find(team).name
    @players = Team.find(team).players
    respond_to do |format|
      format.html
    end
  end
=end

