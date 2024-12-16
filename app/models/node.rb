class Node < ApplicationRecord
  has_many :logs, dependent: :destroy
  has_many :node_neighbors
  has_many :neighbors, through: :node_neighbors

  def initialize(id)
    super()  # Call the base class initializer (ApplicationRecord) / Llamamos al inicializador de la clase base (ApplicationRecord)
    self.id = id  # Manually assign the id / Asignamos el id manualmente
  end

  # Method to add a neighbor to a node / Método para agregar un vecino a un nodo
  def add_neighbor(neighbor)
    save! unless persisted?  # Save the node if it is not already saved / Guardamos el nodo si no está guardado
    node_neighbors.create(neighbor: neighbor) unless neighbors.include?(neighbor)  # Create a node neighbor unless it already exists / Creamos un vecino del nodo a menos que ya exista
  end

  # Method to propose a new state / Método para proponer un nuevo estado
  def propose_state(new_state)
    # Log the proposal / Registra la propuesta en el log
    log_message = "Node #{id} proposed state #{new_state}"
    logs.create(message: log_message)

    # Log the message in the neighbors' logs / Registrar el mensaje en los logs de los nodos vecinos
    neighbors.each do |neighbor|
      neighbor.logs.create(message: "Node #{id} proposed state #{new_state}.")
    end
  
    # Send proposal to neighbors / Enviar propuesta a los vecinos
    successful_proposals = 0
    neighbors.each do |neighbor|
      # Simulate sending the proposal to neighbors and get the response / Simula el envío de la propuesta a los vecinos y obtiene la respuesta
      response = neighbor.receive_proposal(new_state)
      if response == 'accepted'
        successful_proposals += 1
      end
    end
  
    # If the majority of neighbors accepted the proposal, consensus is reached / Si la mayoría de los vecinos aceptaron la propuesta, se alcanza el consenso
    if successful_proposals > neighbors.count / 2
      # Accept the new state as the agreed state / Aceptar el nuevo estado como el estado consensuado
      self.update(state: new_state)
  
      # Log the state transition / Log de la transición de estado
      logs.create(message: "Node #{id} reached consensus on state #{new_state}")
      
      neighbors.each do |neighbor|
        neighbor.logs.create(message: "Node #{id} reached consensus on state #{new_state}")
      end
    else
      # If consensus is not reached, a failure can be logged / Si no se alcanza consenso, se puede registrar un fallo
      logs.create(message: "Node #{id} failed to reach consensus on state #{new_state}")
    end
  end

  def receive_proposal(proposed_state)
    # Check if the proposal has a value greater than the current state / Verifica si la propuesta tiene un valor mayor que el estado actual
    if self.state.nil? || proposed_state > self.state
      # If the proposal is accepted, the node responds with 'accepted' / Si la propuesta es aceptada, el nodo responde con 'accepted'
      self.update(state: proposed_state)
      return 'accepted'
    else
      # If the proposal is rejected, the node responds with 'rejected' / Si la propuesta es rechazada, el nodo responde con 'rejected'
      return 'rejected'
    end
  end

  # Method to simulate a network partition / Método para simular una partición de red
  def simulate_partition(partition_nodes)
    # Disable communications with nodes that are in the partition / Desactiva las comunicaciones con los nodos que están en la partición
    partition_nodes.each do |partition_node|
      # Simulate that it cannot communicate with these nodes / Simula que no puede comunicarse con estos nodos
      log_message = "Node #{id} cannot communicate with Node #{partition_node.id} due to network partition."
      logs.create(message: log_message)
      
      # Remove these nodes from the neighbors list / Elimina a estos nodos de la lista de vecinos
      node_neighbors.where(neighbor_id: partition_node.id).destroy_all
    end
  end

  # Method to retrieve the log / Método para recuperar el log
  def retrieve_log
    logs.order(created_at: :asc).pluck(:message)  # Order logs by creation date and extract messages / Ordena los logs por fecha de creación y extrae los mensajes
  end
end