class ArmyListsController < ApplicationController
  before_filter :authenticate_user!

  # GET /army_lists
  # GET /army_lists.xml
  def index
    unless params.include?(:search) then
      params[:search] = {}
      params[:search][:army_id_eq] = current_user.favorite_army.try(:id)
    end

    @search = current_user.army_lists.includes(:army).order('value_points DESC').search(params[:search])
    @army_lists = @search.relation

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @army_lists }
    end
  end

  # GET /army_lists/1
  # GET /army_lists/1.xml
  def show
    @army_list = current_user.army_lists.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.pdf  { render :pdf => "whbab_#{@army_list.id}" } # show.pdf.erb
      format.xml  { render :xml => @army_list }
    end
  end

  # GET /army_lists/new
  # GET /army_lists/new.xml
  def new
    @army_list = ArmyList.new
    @army_list.army_id = params[:army_id] || current_user.favorite_army.try(:id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @army_list }
    end
  end

  # GET /army_lists/1/edit
  def edit
    @army_list = current_user.army_lists.find(params[:id])
  end

  # POST /army_lists
  # POST /army_lists.xml
  def create
    @army_list = ArmyList.new(params[:army_list])
    @army_list.user = current_user

    respond_to do |format|
      if @army_list.save
        format.html { redirect_to @army_list }
        format.xml  { render :xml => @army_list, :status => :created, :location => @army_list }
      else
        format.html { render :action => "new", :layout => nil }
        format.xml  { render :xml => @army_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /army_lists/1
  # PUT /army_lists/1.xml
  def update
    @army_list = current_user.army_lists.find(params[:id])

    respond_to do |format|
      if @army_list.update_attributes(params[:army_list])
        format.html { redirect_to @army_list }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @army_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /army_lists/1
  # DELETE /army_lists/1.xml
  def destroy
    @army_list = current_user.army_lists.find(params[:id])
    @army_list.destroy

    respond_to do |format|
      format.html { redirect_to army_lists_url }
      format.xml  { head :ok }
    end
  end
end
