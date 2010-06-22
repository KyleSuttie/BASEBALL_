class PlayersController < ApplicationController
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

  def sort_name
	self.clear_all
	25.times{Player.create(:name => 'John Smith', :team => 'Boston Red Sox', :AVG => 0.300, :HR => 					20, :RBI => 40, :RUNS => 30, :SB => 3, :OPS => 0.800)
		}
	redirect_to :action => 'index'
  end

  def sort_team
	self.clear_all
	Player.create(:name => 'Joe Namath', :team => 'Chicago White Sox', :AVG => 0.200, :HR => 					10, :RBI => 43, :RUNS => 20, :SB => 6, :OPS => 0.726)
	redirect_to :action => 'index'
  end

  def sort_avg
	self.clear_all
	Player.create(:name => 'Babe Ruth', :team => 'NY Yankees', :AVG => 0.600, :HR => 					200, :RBI => 400, :RUNS => 300, :SB => 30, :OPS => 0.900)
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
