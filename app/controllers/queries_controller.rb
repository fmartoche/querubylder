class QueriesController < ApplicationController
  load_and_authorize_resource

  def index
    @queries = Query.all
  end

  def show
    @generated_sql = @query.build_query
  end

  def new
    @query = Query.new
  end

  def edit
  end

  def create
    @query = Query.new(query_params)
    
    if query_params
      if @query.save
        redirect_to @query, notice: 'Query was successfully created.'
      else
        render :new
      end
    else
      flash[:notice] = 'Please indicate at least a dimension or a metric.'
      render :new
    end
  end

  def update
    if query_params
      if @query.update(query_params)
        redirect_to @query, notice: 'Query was successfully updated.'
      else
        render :edit
      end
    else 
      flash[:notice] = 'Please indicate at least a dimension or a metric.'
      render :edit
    end
  end

  def destroy
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url, notice: 'Query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def query_params
      if params[:query]
        p = params.require(:query).permit(:dimensions, :metrics, :conditions)
        p[:dimensions] = params[:query][:dimensions].to_yaml
        p[:metrics] = params[:query][:metrics].to_yaml
        p
      else
        nil
      end
    end
end
