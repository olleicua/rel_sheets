class Table
  extend ActiveModel::Naming

  attr_reader :errors
  attr_accessor :table_name

  def initialize(table_name = nil)
    table_name = self.class.unique_table_name if table_name.nil?

    @table_name = table_name
    @errors = ActiveModel::Errors.new(self)
  end

  def self.all
    ActiveRecord::Base.connection.tables.map do |table_name|
      new(table_name)
    end
  end

  def self.first
    all.first
  end

  def self.find(table_name)
    all.detect { |t| t.table_name == table_name }
  end

  def inspect
    "<Table #{@table_name.camelize}>"
  end

  def model
    if @model
      @model
    else
      @model = Class.new(ActiveRecord::Base)
      _table_name = @table_name
      @model.define_singleton_method(:table_name) do
        _table_name
      end
      @model
    end
  end

  def columns
    @columns ||= model.columns.map do |column|
      Column.new(self, column)
    end
  end

  def persisted?
    ActiveRecord::Base.connection.tables.include?(@table_name)
  end

  def create
    if persisted?
      errors.add(:name, "Table #{@table.table_name} is already taken")
    else
      raise 'not yet implemented'
    end
  end

  def rename(new_name)
    if ActiveRecord::Base.connection.tables.include?(new_name)
      errors.add(:name, "Table #{new_name} is already taken")
    else
      raise 'not yet implemented'
    end
  end

  def add_column(options)
    raise 'not yet implemented'
  end

  def drop
    raise 'not yet implemented'
  end

  private

  def self.unique_table_name
    name = 'untitled'
    while ActiveRecord::Base.connection.tables.include?(name)
      n ||= 0
      n += 1
      name = "untitled#{n}"
    end
    name
  end
end
