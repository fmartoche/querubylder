# q=Query.new;q.build_query
# q=Query.new;q.find_relationships_between('sessions', 'hits')
# q=Query.new;q.find_relationships_between('hits', 'sessions')

class Query < ActiveRecord::Base
  require 'djikstra.rb'

  def build_query
    self.dimensions=Marshal.dump(['sessions.start_date', 'hits.type'])
    self.metrics=Marshal.dump(['COUNT(custom_dimensions.id)'])

    tables = get_all_tables_needed
    puts "Tables: #{tables}"
    table_graph = build_table_graph
    puts "Table graph: #{table_graph}"
    puts "Table graph edges: #{table_graph.edges}"
    table_path = build_table_path_from_table_graph(table_graph, tables)
    p "Table path: #{table_path}"
    joins = generate_joins_from_path(table_path)
    p "joins: #{joins}"
    selects = build_select(get_dimensions, get_metrics)
    p "selects: #{selects}"
    group_by = build_group_by(get_dimensions, get_metrics)
    p "group_by: #{group_by}"
    final_query = build_query_from_strings(selects, joins, group_by)
    p "final query: #{final_query}"
  end

  def get_all_tables_needed
    (get_dimensions+get_metrics).map do |s|
      get_tables_from_string(s)
    end.flatten.uniq
  end

  def get_tables_from_string(s)
    s.scan(/[a-zA-Z\_]+\.[a-zA-Z]+/).map do |str|
      str.split(".").first
    end
  end

  def build_table_graph
    graph = Graph.new
    Table.all.each {|table| graph.push table.name }
    Table.all.each do |table| 
      table.table_columns.map(&:name).each do |column_name|
        target_table_name = self.extract_table_name_from_relationship(column_name)
        if target_table_name
          target_table_name = target_table_name.pluralize
          graph.connect table.name, target_table_name
          graph.connect target_table_name, table.name
        end
      end
    end
    graph
  end

  def extract_table_name_from_relationship(str)
    s = str.scan(/[a-zA-Z0-9]+\_id$/).first
    s ? s[0..-4].pluralize : nil
  end

  def build_table_path_from_table_graph(graph, table_names)
    out = []
    (table_names.length - 1).times do |i|
      path = graph.dijkstra(table_names[i], table_names[i+1])
      if path
        out += path[:path]
      end
    end
    return out.uniq
  end

  def generate_joins_from_path(path)
    joins = "FROM #{path[0]}
"
    path[1..-1].each_with_index do |table, i|
      joins += "INNER JOIN #{table}
  ON  1=1
      "
      p "#{i} vs #{path[i]} vs #{table}"
      relationships = find_relationships_between(path[i], table)
      relationships.each do |relationship|
        joins += "AND #{relationship.first} = #{relationship.second}
      "
      end
    end
    return joins
  end

  def find_relationships_between(table1_str, table2_str, first_run=true)
    table1 = Table.find_by_name(table1_str)
    table2 = Table.find_by_name(table2_str)

    relationships = []
    table2_cols = table2.table_columns.map(&:name)
    table1.table_columns.each do |table1_col|
      table1_foreign_table_name = self.extract_table_name_from_relationship(table1_col.name)
      if table1_foreign_table_name and table2_cols.include? table1_col.name
        relationships += [["#{table1_str}.#{table1_col.name}", "#{table2_str}.#{table1_col.name}"].sort]
      elsif table1_foreign_table_name == table2.name
        relationships += [["#{table1_str}.#{table1_col.name}", "#{table2_str}.id"].sort]
      end
    end

    if first_run
      (relationships + self.find_relationships_between(table2_str, table1_str, false)).uniq
    else 
      relationships.uniq
    end
  end

  def build_select(dimensions, metrics)
    out = "SELECT
  "
    (dimensions+metrics).each do |s|
      out += ", #{s}
  "
    end

    out
  end  

  def build_group_by(dimensions, metrics)
    if metrics.length > 0
      out = "GROUP BY "

      dimensions.length.times do |i| 
        if i == 0
          out += (i+1).to_s
        else
          out += ", #{i+1}"
        end
      end

      out
    else
      ""
    end
  end

  def build_query_from_strings(selects, joins, group_by)
    "#{selects} 

#{joins}

#{group_by}"
  end

  def get_metrics
    Marshal.load(self.metrics)
  end

  def get_dimensions
    Marshal.load(self.dimensions)
  end
end
