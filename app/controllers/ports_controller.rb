class PortsController < ApplicationController
  def index
    service = Service.find(params[:service_id])

    render :json => [1,2,3].to_json
  end

  def create
    service = Service.find(params[:service_id])

    machine = Machine.find(params[:machine_id])

    port_machines = service.ports.where(:machine_id => machine.id)
    port_machines.each &:destroy
    service.ports.each(&:clear)
  end
end
