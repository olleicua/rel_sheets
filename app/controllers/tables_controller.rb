class TablesController < ApplicationController
  def first
    @table = Table.first
    if @table.present?
      redirect_to table_path(table_name: @table.name)
    else
      redirect_to new_table_path
    end
  end

  def show
    require_table
    @columns = @table.columns
    @records = @table.model.all
  end

  def create
    @table = Table.new(table_params[:name])
    if @table.create
      redirect_to table_path(@table)
    else
      render :new
    end
  end

  def update
    require_table
    if @table.rename(table_params[:name])
      redirect_to table_path(@table)
    else
      render :edit
    end
 end

  def destroy
    require_table
    @table.drop
    redirect_to first_table_path
  end

  private

  def table_params
    params.require(:table).permit(:name)
  end
end
