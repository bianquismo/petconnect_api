class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]

  # GET /appointments
  def index
    @appointments = if params[:user_id]
                      Appointment.includes(:pet_shop).where(user_id: params[:user_id])
                    else
                      Appointment.includes(:pet_shop).all
                    end

    render json: @appointments.as_json(include: { pet_shop: { only: %i[id name address] } })
  end

  # GET /appointments/1
  def show
    render json: @appointment.as_json(include: { pet_shop: { only: %i[id name address] } })
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment.as_json(include: { pet_shop: { only: :name } }), status: :created,
             location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment.as_json(include: { pet_shop: { only: :name } })
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy!
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:time, :user_id, :pet_shop_id)
  end
end
