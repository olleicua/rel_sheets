class ColumnsController < ApplicationController
  before_action :require_table

  def index
    render json: @table.columns
  end

  def show
    require_column
    render json: @column
  end

  def new
  end

  def create
    if @table.add_column(column_params)
      render json: { success: true }
    else
      render json: { error: true, messages: @table.errors.full_messages }
    end
  end

  def edit
    require_column
  end

  def update
    require_column
    if @column.alter(column_params)
      render json: { success: true }
    else
      render json: { error: true, messages: @column.errors.full_messages }
    end
  end

  def destroy
    require_column
    @column.drop
    render json: { success: true }
  end

  private

  def column_params
    {}
  end
end
