class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do
    if params[:table_name].present?
      @table = Table.find(params[:table_name])
    end

    if params[:column_name].present?
      require_table
      @column = @table.columns.detect do |c|
        c.name == params[:column_name]
      end
    end

    if params[:id].present?
      require_table
      @record = @table.model.find(params[:id])
    end
  end

  def require_table
    raise ActiveRecord::RecordNotFound if @table.nil?
  end

  def require_column
    raise ActiveRecord::RecordNotFound if @column.nil?
  end
end
