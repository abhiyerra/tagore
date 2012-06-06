class ProvisionsController < ApplicationController
  # GET /provisions
  # GET /provisions.json
  def index
    @provisions = Provision.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @provisions }
    end
  end

  # GET /provisions/1
  # GET /provisions/1.json
  def show
    @provision = Provision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provision }
    end
  end

  # GET /provisions/new
  # GET /provisions/new.json
  def new
    @provision = Provision.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provision }
    end
  end

  # GET /provisions/1/edit
  def edit
    @provision = Provision.find(params[:id])
  end

  # POST /provisions
  # POST /provisions.json
  def create
    @provision = Provision.new(params[:provision])

    respond_to do |format|
      if @provision.save
        format.html { redirect_to @provision, notice: 'Provision was successfully created.' }
        format.json { render json: @provision, status: :created, location: @provision }
      else
        format.html { render action: "new" }
        format.json { render json: @provision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /provisions/1
  # PUT /provisions/1.json
  def update
    @provision = Provision.find(params[:id])

    respond_to do |format|
      if @provision.update_attributes(params[:provision])
        format.html { redirect_to @provision, notice: 'Provision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @provision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provisions/1
  # DELETE /provisions/1.json
  def destroy
    @provision = Provision.find(params[:id])
    @provision.destroy

    respond_to do |format|
      format.html { redirect_to provisions_url }
      format.json { head :no_content }
    end
  end
end
