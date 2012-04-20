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
    @service = Service.find_by_name(params[:service][:name])

    debugger; 1

    resource_klass = case params[:resource_type]
    when "redis"
      RedisResource
    when "mongo"
      MongoResource
    when "memcached"
      MemcachedResource
    when "web"
      WebResource
    when "worker"
      WorkerResource
    else
      raise "Not such resource"
    end

    @resource = resource_klass.new
    @resource.service_id = @service.id

    respond_to do |format|
      if @resource.save
#        format.html { redirect_to @resource, notice: 'Resource was successfully created.' }
#        format.json {
        render json: @resource, status: :created, location: resource_url(@resource)
#}
      else
 #       format.html { render action: "new" }
  #      format.json {
        render json: @resource.errors, status: :unprocessable_entity
      #}
      end
    end
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
