class ProvisionsController < ApplicationController
  # GET /provisions
  # GET /provisions.json
  def index
    @provisions = Provision.all

    render json: @provisions
  end

  # GET /provisions/1
  # GET /provisions/1.json
  def show
    @provision = Provision.find(params[:id])

    render json: @provision
  end

  # POST /provisions
  # POST /provisions.json
  def create
    @provision = Provision.new(params[:provision])

    respond_to do |format|
      if @provision.save
        render json: @provision, status: :created, location: @provision
      else
        format.html { render action: "new" }
        render json: @provision.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /provisions/1
  # DELETE /provisions/1.json
  def destroy
    @provision = Provision.find(params[:id])
    @provision.destroy

    head :no_content
  end
end
