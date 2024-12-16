class NodeNeighbor < ApplicationRecord
  belongs_to :node
  belongs_to :neighbor, class_name: 'Node'
end
