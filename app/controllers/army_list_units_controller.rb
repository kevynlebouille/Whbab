class ArmyListUnitsController < ApplicationController
  before_filter :authenticate_user!

  # GET /army_list/1/army_list_units/new
  # GET /army_list/1/army_list_units/new.xml
  def new
    @army_list = current_user.army_lists.find(params[:army_list_id])
    @army_list_unit = @army_list.army_list_units.build()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @army_list_unit }
    end
  end

  # GET /army_list/1/army_list_units/1/edit
  def edit
    @army_list = current_user.army_lists.find(params[:army_list_id])
    @army_list_unit = @army_list.army_list_units.find(params[:id])

    @available_unit_options = @army_list_unit.unit.unit_options.only_parents.without_magics
    @magic_items_option = @army_list_unit.unit.unit_options.only_magic_items.first
    @magic_standards_option = @army_list_unit.unit.unit_options.only_magic_standards.first
  end

  # POST /army_list/1/army_list_units
  # POST /army_list/1/army_list_units.xml
  def create
    @army_list = current_user.army_lists.find(params[:army_list_id])
    @army_list_unit = @army_list.army_list_units.build(params[:army_list_unit])

    respond_to do |format|
      if @army_list_unit.save
        format.html { redirect_to @army_list }
        format.xml  { render :xml => @army_list_unit, :status => :created, :location => @army_list_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @army_list_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /army_list/1/army_list_units/1
  # PUT /army_list/1/army_list_units/1.xml
  def update
    params[:army_list_unit][:unit_option_ids] ||= []
    params[:army_list_unit][:magic_item_ids] ||= []

    @army_list = current_user.army_lists.find(params[:army_list_id])
    @army_list_unit = @army_list.army_list_units.find(params[:id])

    respond_to do |format|
      if @army_list_unit.update_attributes(params[:army_list_unit])
        format.html { redirect_to @army_list }
        format.xml  { head :ok }
      else
        @available_unit_options = @army_list_unit.unit.unit_options.only_parents.without_magics
        @magic_items_option = @army_list_unit.unit.unit_options.only_magic_items.first
        @magic_standards_option = @army_list_unit.unit.unit_options.only_magic_standards.first

        format.html { render :action => "edit" }
        format.xml  { render :xml => @army_list_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /army_list/1/army_list_units/1
  # DELETE /army_list/1/army_list_units/1.xml
  def destroy
    @army_list = current_user.army_lists.find(params[:army_list_id])
    @army_list_unit = @army_list.army_list_units.find(params[:id])
    @army_list_unit.destroy

    respond_to do |format|
      format.html { redirect_to @army_list }
      format.xml  { head :ok }
    end
  end

  # POST /army_lists/1/army_list_units/sort
  def sort
    params[:army_list_units].each_with_index do |id, index|
      ArmyListUnit.update_all({ :position => index + 1 }, { :army_list_id => params[:army_list_id], :id => id })
    end
    render :nothing => true
  end
end
