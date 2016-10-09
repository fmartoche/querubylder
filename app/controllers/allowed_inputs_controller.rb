class AllowedInputsController < ApplicationController
  before_action :set_allowed_input, only: [:show, :edit, :update, :destroy]

  # GET /allowed_inputs
  # GET /allowed_inputs.json
  def index
    @allowed_inputs = AllowedInput.all
  end

  # GET /allowed_inputs/1
  # GET /allowed_inputs/1.json
  def show
  end

  # GET /allowed_inputs/new
  def new
    @allowed_input = AllowedInput.new
  end

  # GET /allowed_inputs/1/edit
  def edit
  end

  # POST /allowed_inputs
  # POST /allowed_inputs.json
  def create
    @allowed_input = AllowedInput.new(allowed_input_params)

    respond_to do |format|
      if @allowed_input.save
        format.html { redirect_to @allowed_input, notice: 'Allowed input was successfully created.' }
        format.json { render :show, status: :created, location: @allowed_input }
      else
        format.html { render :new }
        format.json { render json: @allowed_input.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /allowed_inputs/1
  # PATCH/PUT /allowed_inputs/1.json
  def update
    respond_to do |format|
      if @allowed_input.update(allowed_input_params)
        format.html { redirect_to @allowed_input, notice: 'Allowed input was successfully updated.' }
        format.json { render :show, status: :ok, location: @allowed_input }
      else
        format.html { render :edit }
        format.json { render json: @allowed_input.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allowed_inputs/1
  # DELETE /allowed_inputs/1.json
  def destroy
    @allowed_input.destroy
    respond_to do |format|
      format.html { redirect_to allowed_inputs_url, notice: 'Allowed input was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_allowed_input
      @allowed_input = AllowedInput.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allowed_input_params
      params.require(:allowed_input).permit(:name, :input_type, :alias)
    end
end
