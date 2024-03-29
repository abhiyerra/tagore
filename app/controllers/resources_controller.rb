class ResourcesController < ApplicationController
  # GET /resources
  # GET /resources.json
  def index
    @service = Service.find_by_name(params[:service][:name])
    @resources = @service.resources

    # @resources = Resource.all

 #   respond_to do |format|
#      format.html # index.html.erb
#      formaat.json {
      render json: @resources
 #   }
  #  end
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.json
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.json
  def create
    if params[:resource] && (resource_type = params[:resource][:type])
      resource_klass = Resource::TYPES[resource_type]

      return redirect_to :back, :error => "no such resource" unless resource_klass

      params[:resource].delete :type

      @resource = resource_klass.provision!(params[:resource])

      respond_to do |format|
        format.html { return redirect_to :back, notice: 'Resource was successfully created.' }
        format.json { render json: @resource, status: :created, location: resource_url(@resource) }
      end
    end

    return redirect_to :back
  end

  # PUT /resources/1
  # PUT /resources/1.json
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end
end
