class ArmyListChoicesController < ApplicationController
  before_filter :authenticate_user!

  # GET /army_list_choices
  # GET /army_list_choices.xml
  def index
    @army_list_choices = ArmyListChoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @army_list_choices }
    end
  end

  # GET /army_list_choices/1
  # GET /army_list_choices/1.xml
  def show
    @army_list_choice = ArmyListChoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @army_list_choice }
    end
  end

  # GET /army_list/1/army_list_choices/new
  # GET /army_list/1/army_list_choices/new.xml
  def new
    @army_list = current_user.army_lists.find(params[:army_list_id])
    @army_list_choice = @army_list.army_list_choices.build()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @army_list_choice }
    end
  end

  # GET /army_list_choices/1/edit
  def edit
    @army_list_choice = ArmyListChoice.find(params[:id])
  end

  # POST /army_list/1/army_list_choices
  # POST /army_list/1/army_list_choices.xml
  def create
    @army_list = current_user.army_lists.find(params[:army_list_id])
    @army_list_choice = @army_list.army_list_choices.build(params[:army_list_choice])

    respond_to do |format|
      if @army_list_choice.save
        format.html { redirect_to(@army_list_choice, :notice => 'Army list choice was successfully created.') }
        format.xml  { render :xml => @army_list_choice, :status => :created, :location => @army_list_choice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @army_list_choice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /army_list_choices/1
  # PUT /army_list_choices/1.xml
  def update
    @army_list_choice = ArmyListChoice.find(params[:id])

    respond_to do |format|
      if @army_list_choice.update_attributes(params[:army_list_choice])
        format.html { redirect_to(@army_list_choice, :notice => 'Army list choice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @army_list_choice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /army_list_choices/1
  # DELETE /army_list_choices/1.xml
  def destroy
    @army_list_choice = ArmyListChoice.find(params[:id])
    @army_list_choice.destroy

    respond_to do |format|
      format.html { redirect_to(army_list_choices_url) }
      format.xml  { head :ok }
    end
  end
end
