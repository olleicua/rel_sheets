class RecordsController < ApplicationController
  def create
    @record = @table.model.new(record_params)
    if @record.save
      render json: { success: true }
    else
      render error: { error: @record.errors.full_messages }
    end
  end

  def update
    if @record.update(record_params)
      render json: { success: true }
    else
      render error: { error: @record.errors.full_messages }
    end
  end

  def destroy
    @record.destroy
    render json: { success: true }
  end

  private

  def record_params
    params.require(:record).permit(*@table.columns.map(&:name))
  end
end
