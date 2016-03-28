class Column
  extend ActiveModel::Naming

  attr_reader :errors
  attr_accessor :table

  def initialize(table, ar_column)
    @table = table
    @ar_column = ar_column
    @errors = ActiveModel::Errors.new(self)
  end

  def name
    @ar_column.name
  end

  def inspect
    "<Column #{name}:#{@ar_column.type}>"
  end

  def as_json
    {
      name: name,
      type: @ar_column.type,
      precision: @ar_column.cast_type.precision,
      scale: @ar_column.cast_type.scale,
      limit: @ar_column.cast_type.limit,
      nullable: @ar_column.null,
      default: @ar_column.default
  end

  def alter(options)
    raise 'not yet implemented'
  end

  def drop
    raise 'not yet implemented'
  end
end
