require 'test_helper'

describe 'Geometry Migrations' do
  after { connection.drop_table :data_types }

  it 'creates geometry columns' do
    connection.create_table :data_types do |t|
      t.geometry :geo_1
      t.column   :geo_2, :geometry
    end

    columns = connection.columns(:data_types)
    geo_1 = columns.find { |c| c.name == 'geo_1' }
    geo_2 = columns.find { |c| c.name == 'geo_2' }

    geo_1.sql_type.must_equal 'geometry'
    geo_2.sql_type.must_equal 'geometry'
  end

  it 'creates geometry columns with type and SRID' do
    connection.create_table :data_types do |t|
      t.geometry :geo_1, spatial_type: :linestring, srid: 4326
      t.column   :geo_2, :geometry, spatial_type: :linestring, srid: 4326
    end

    columns = connection.columns(:data_types)
    geo_1 = columns.find { |c| c.name == 'geo_1' }
    geo_2 = columns.find { |c| c.name == 'geo_2' }

    geo_1.sql_type.must_equal 'geometry(LineString,4326)'
    geo_2.sql_type.must_equal 'geometry(LineString,4326)'
  end

  it 'adds geometry columns with type and SRID' do
    connection.create_table :data_types do |t|
    end

    connection.add_column  :data_types, :geo_1, :geometry

    columns = connection.columns(:data_types)
    geo_1 = columns.find { |c| c.name == 'geo_1' }

    geo_1.sql_type.must_equal 'geometry'
  end

  it 'adds geometry columns with type and SRID' do
    connection.create_table :data_types do |t|
    end

    connection.add_column  :data_types, :geo_1, :geometry, spatial_type: :linestring, srid: 4326

    columns = connection.columns(:data_types)
    geo_1 = columns.find { |c| c.name == 'geo_1' }

    geo_1.sql_type.must_equal 'geometry(LineString,4326)'
  end
end
