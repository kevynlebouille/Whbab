class ArmyListsController < ApplicationController
  before_filter do |controller|
    unless controller.action_name == 'export'
      authenticate_user!
    end
  end

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
    if request.format.pdf?
      # @army_list = ArmyList.find(params[:id])
    end

    @army_list = current_user.army_lists.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @army_list }
    end
  end

  # GET /army_lists/1/export
  # GET /army_lists/1/export_:verbosity.html
  # GET /army_lists/1/export_:verbosity.pdf
  def export
    @army_list = ArmyList.find(params[:id])
    @verbosity = params[:verbosity]

    respond_to do |format|
      format.html { render :template => @verbosity.nil? ? "army_lists/export" : "army_lists/export_#{@verbosity}", :layout => @verbosity.nil? ? nil : "pdf.html.erb" }
      format.pdf  { render :template => "army_lists/export_#{@verbosity}", :pdf => "whbab_#{@verbosity}_#{@army_list.id}" }
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

  # GET /army_list/1/new_from
  def new_from
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

  # GET /army_lists/1/delete
  def delete
    @army_list = current_user.army_lists.find(params[:id])
  end

  # DELETE /army_lists/1
  # DELETE /army_lists/1.xml
  def destroy
    @army_list = current_user.army_lists.find(params[:id])
    @army_list.destroy

    respond_to do |format|
      format.html { redirect_to army_lists_url(:search => { :army_id_eq => @army_list.army }) }
      format.xml  { head :ok }
    end
  end

  # POST /army_list/1/duplicate
  def duplicate
    @base_army_list = current_user.army_lists.find(params[:id])

    @army_list = ArmyList.new
    @army_list.user = @base_army_list.user
    @army_list.army = @base_army_list.army
    @army_list.name = @base_army_list.name + " copie"
    @army_list.notes = @base_army_list.notes
    @army_list.save

    @base_army_list.army_list_units.each do |base_army_list_unit|
      army_list_unit = @army_list.army_list_units.build({
        :unit_id => base_army_list_unit.unit_id,
        :unit_category_id => base_army_list_unit.unit_category_id,
        :value_points => base_army_list_unit.value_points,
        :size => base_army_list_unit.size
      })
      army_list_unit.army_list_unit_troops << base_army_list_unit.army_list_unit_troops.collect do |alut|
        army_list_unit_troop = alut.dup
        army_list_unit_troop.army_list_unit = army_list_unit
        army_list_unit_troop
      end
      army_list_unit.army_list_unit_magic_items << base_army_list_unit.army_list_unit_magic_items.collect do |alumi|
        army_list_unit_magic_item = alumi.dup
        army_list_unit_magic_item.army_list_unit = army_list_unit
        army_list_unit_magic_item
      end
      army_list_unit.unit_options << base_army_list_unit.unit_options
      army_list_unit.magic_standards << base_army_list_unit.magic_standards
      army_list_unit.extra_items << base_army_list_unit.extra_items
    end

    respond_to do |format|
      if @army_list.save
        @army_list.reload

        format.html { redirect_to @army_list }
        format.xml  { render :xml => @army_list, :status => :created, :location => @army_list }
        format.js   { render :action => "create" }
      else
        format.html { render :action => "new_from" }
        format.xml  { render :xml => @army_list.errors, :status => :unprocessable_entity }
      end
    end
  end
end
