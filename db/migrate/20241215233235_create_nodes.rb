class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    # Crear la tabla 'nodes'
    # Create the 'nodes' table
    create_table :nodes do |t|
      t.integer :state, null: true

      t.timestamps
    end

    # Crear la tabla 'logs' para almacenar los mensajes de cada nodo
    # Create the 'logs' table to store messages from each node
    create_table :logs do |t|
      t.text :message
      t.references :node, null: false, foreign_key: true

      t.timestamps
    end

    # Crear la tabla 'node_neighbors' para almacenar las relaciones de vecinos entre nodos
    # Create the 'node_neighbors' table to store neighbor relationships between nodes
    create_table :node_neighbors do |t|
      t.references :node, null: false, foreign_key: true
      t.references :neighbor, null: false, foreign_key: { to_table: :nodes }

      t.timestamps
    end
  end
end
