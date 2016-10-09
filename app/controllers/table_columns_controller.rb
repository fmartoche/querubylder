class TableColumnsController < ApplicationController
  before_action :set_table_column, only: [:show, :edit, :update, :destroy]

  # GET /table_columns
  # GET /table_columns.json
  def index
    @table_columns = TableColumn.all
  end

  # GET /table_columns/1
  # GET /table_columns/1.json
  def show
  end

  # GET /table_columns/new
  def new
    @table_column = TableColumn.new
  end

  # GET /table_columns/1/edit
  def edit
  end

  # POST /table_columns
  # POST /table_columns.json
  def create
    @table_column = TableColumn.new(table_column_params)

    respond_to do |format|
      if @table_column.save
        format.html { redirect_to @table_column, notice: 'Table column was successfully created.' }
        format.json { render :show, status: :created, location: @table_column }
      else
        format.html { render :new }
        format.json { render json: @table_column.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /table_columns/1
  # PATCH/PUT /table_columns/1.json
  def update
    respond_to do |format|
      if @table_column.update(table_column_params)
        format.html { redirect_to @table_column, notice: 'Table column was successfully updated.' }
        format.json { render :show, status: :ok, location: @table_column }
      else
        format.html { render :edit }
        format.json { render json: @table_column.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /table_columns/1
  # DELETE /table_columns/1.json
  def destroy
    @table_column.destroy
    respond_to do |format|
      format.html { redirect_to table_columns_url, notice: 'Table column was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table_column
      @table_column = TableColumn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_column_params
      params.require(:table_column).permit(:name, :type)
    end
end
