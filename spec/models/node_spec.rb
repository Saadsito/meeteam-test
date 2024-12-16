require 'rails_helper'

RSpec.describe Node, type: :model do
  # Create test nodes / Crea nodos de prueba
  let(:node1) { Node.create(id: 1) }
  let(:node2) { Node.create(id: 2) }
  let(:node3) { Node.create(id: 3) }

  before do
    # Set neighbors for each node / Establece vecinos para cada nodo
    node1.add_neighbor(node2)
    node1.add_neighbor(node3)
    node2.add_neighbor(node1)
    node2.add_neighbor(node3)
    node3.add_neighbor(node1)
    node3.add_neighbor(node2)
  end

  describe '#propose_state' do
    it "should propose state and reach consensus" do
      # Node1 proposes state 1 / Node1 propone el estado 1
      node1.propose_state(1)
      # Node2 proposes state 2 / Node2 propone el estado 2
      node2.propose_state(2)

      # Recargar los nodos para obtener el estado actualizado desde la base de datos
      node1.reload
      node2.reload
      node3.reload

      # Assert that the nodes reached consensus on the highest state / Afirmar que los nodos alcanzaron consenso sobre el estado más alto
      expect(node1.state).to eq(2)
      expect(node2.state).to eq(2)
      expect(node3.state).to eq(2)

      # Check the logs to verify consensus messages / Verifica los logs para confirmar los mensajes de consenso
      expect(node1.retrieve_log.any? { |log| log.include?("reached consensus on state 2") }).to be_truthy
      expect(node2.retrieve_log.any? { |log| log.include?("reached consensus on state 2") }).to be_truthy
      expect(node3.retrieve_log.any? { |log| log.include?("reached consensus on state 2") }).to be_truthy
    end
  end

  describe '#simulate_partition' do
    it "should simulate network partition" do
      # Simulate network partition where node3 cannot communicate with node1 / Simula una partición de red donde node3 no puede comunicarse con node1
      node3.simulate_partition([node1])

      # Assert that node1 and node3 cannot communicate / Afirmar que node1 y node3 no pueden comunicarse
      expect(node3.retrieve_log.any? { |log| log.include?("cannot communicate with") && log.include?("due to network partition") }).to be_truthy

      # Assert that node1 and node3 no longer have each other as neighbors / Afirmar que node1 y node3 ya no son vecinos
      expect(node3.neighbors).not_to include(node1)
    end
  end

  describe '#handle_node_failure' do
    it "should handle node failure gracefully" do
      # Node1 and Node2 propose state 3 / Node1 y Node2 proponen el estado 3
      node1.propose_state(3)
      node2.propose_state(3)

      node1.reload
      node2.reload
      node3.reload

      # Assert that all nodes reached state 3 / Afirmar que todos los nodos alcanzaron el estado 3
      expect(node1.state).to eq(3)
      expect(node2.state).to eq(3)
      expect(node3.state).to eq(3)

      # Check logs for consensus messages / Verifica los logs para mensajes de consenso
      expect(node1.retrieve_log.any? { |log| log.include?("reached consensus on state 3") }).to be_truthy
      expect(node2.retrieve_log.any? { |log| log.include?("reached consensus on state 3") }).to be_truthy
    end
  end
end