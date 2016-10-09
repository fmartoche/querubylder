class TableColumnsController < ApplicationController
  load_and_authorize_resource

  def index
    @table_columns = TableColumn.all
  end

  def show
  end

  def new
    @table_column = TableColumn.new
  end

  def edit
  end

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

  def destroy
    @table_column.destroy
    respond_to do |format|
      format.html { redirect_to table_columns_url, notice: 'Table column was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def table_column_params
      params.require(:table_column).permit(:name, :type)
    end
end
