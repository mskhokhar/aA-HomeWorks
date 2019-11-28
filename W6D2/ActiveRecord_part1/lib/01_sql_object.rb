require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @column if @column
    col = DBConnection.execute2(<<-SQL).first
      Select * from #{self.table_name}
    SQL
    col.map!{|ele| ele.to_sym}
    @column = col
  end

  def self.finalize!
    col = self.columns
    col.each do |column|
      define_method(column) do 
        self.attributes[column]
      end
      define_method("#{column}=") do |input|
        self.attributes[column] = input
      end
    end
  end

  def self.table_name=(table_name)
    tabl_name = self.table_name
    define_method("#{tabl_name}=") do |table_name|
        self.instance_variable_set("@"+tabl_name.to_s, table_name)
    end
  end

  def self.table_name
    self.to_s.downcase + 's'
  end

  def self.all
    # ...
    col = DBConnection.execute(<<-SQL)
      Select * from #{self.table_name}
    SQL
    
    self.parse_all(col)
    
  end

  def self.parse_all(results)
    results.map do |ele| 
      el = ele.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      self.new(el)
    end
    # ...
  end

  def self.find(id)
    res = DBConnection.execute(<<-SQL, id)
      Select * from #{self.table_name} where #{self.table_name}.id = ?
    SQL
    self.parse_all(res).first
    # ...
  end

  def initialize(params = {})
    params.each do |key,value|
      raise Exception.new "unknown attribute '#{key}'" if !self.class.columns.include?(key)
      self.send("#{key}=", value)
    end
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.attributes.values
    # ...
  end

  def insert
    res_val_str = self.attribute_values.map{|ele| "'#{ele.to_s}'"}.join(", ")
    res_key_str = self.class.columns[1..-1].map{|ele| ele.to_s}.join(", ")
    DBConnection.execute(
      "INSERT INTO #{self.class.table_name} (#{res_key_str}) VALUES (#{res_val_str})"
    )
    self.id = DBConnection.last_insert_row_id
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
