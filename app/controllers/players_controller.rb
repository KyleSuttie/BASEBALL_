class PlayersController < ApplicationController
  include REXML
  # GET /players
  # GET /players.xml
  def index
    @players = Player.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end
 
  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to(@player, :notice => 'Player was successfully created.') }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(@player, :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end


  def clear_list
	Player.delete_all
	redirect_to :action => 'index'
  end

  def clear_all
	Player.delete_all
  end

  def default_data
	self.clear_all
	require "rexml/document"

	file = File.new("baseball_stats.xml")
	doc = REXML::Document.new file
	root = doc.root
	team = root.elements[2].elements[2].elements[2]
	inc = 19

	9.times{
		inc = inc + 1 
		player = team.elements[inc]

		player_name = player.elements[1].text + ' ' + player.elements[2].text
		player_team = team.elements[2].text
		player_avg = (Float(player.elements[8].text)) / (Float(player.elements[6].text))
		player_hr = Integer(player.elements[11].text)
		player_rbi = Integer(player.elements[12].text)
		player_runs = Integer(player.elements[7].text)
		player_sb = Integer(player.elements[13].text)

		hits = Float(player.elements[8].text)
		walks = Float(player.elements[18].text)
		hbp = Float(player.elements[20].text)
		sacs = Float(player.elements[16].text)
		bases = hits + ((Float(player.elements[9].text))*2) + ((Float(player.elements[10].text))*3) + 
			((Float(player.elements[11].text))*4)
		bats = Float(player.elements[6].text)
		
		obp = (hits + walks + hbp) / (bats + walks + sacs)
		sp = bases / bats
		player_ops = obp + sp


		Player.create(:name => player_name, :team => player_team, :AVG => player_avg, :HR => 					player_hr, :RBI => player_rbi, :RUNS => player_runs, :SB => player_sb,
				 :OPS => player_ops)
		
	}
	redirect_to :action => 'index'
  end

  def sort_name
	self.clear_all
	redirect_to :action => 'index'
  end

  def sort_team
	self.clear_all
	redirect_to :action => 'index'
  end

  def sort_avg
	self.clear_all
	redirect_to :action => 'index'
  end

  def sort_hr
	self.clear_all
	redirect_to :action => 'index'
  end

  def sort_rbi
	self.clear_all	
	redirect_to :action => 'index'
  end

  def sort_runs
	self.clear_all
	redirect_to :action => 'index'
  end

  def sort_sb
	self.clear_all
	redirect_to :action => 'index'
  end

  def sort_ops
	self.clear_all
	redirect_to :action => 'index'
  end








end
