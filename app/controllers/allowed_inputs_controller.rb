class AllowedInputsController < ApplicationController
  load_and_authorize_resource

  def index
    @allowed_inputs = AllowedInput.all
  end

  def show
  end

  def new
    @allowed_input = AllowedInput.new
  end

  def edit
  end

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

  def destroy
    @allowed_input.destroy
    respond_to do |format|
      format.html { redirect_to allowed_inputs_url, notice: 'Allowed input was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def allowed_input_params
      params.require(:allowed_input).permit(:name, :input_type, :alias)
    end
end
