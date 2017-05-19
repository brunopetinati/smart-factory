class Pedido < ApplicationRecord
  extend Enumerize

  enumerize :status, in: %w(vendas engenharia producao finalizado), default: :vendas, scope: true

  belongs_to :cliente

  has_many :etapas, dependent: :destroy
  accepts_nested_attributes_for :etapas, allow_destroy: true

  has_many :item_pedidos, dependent: :destroy
  accepts_nested_attributes_for :item_pedidos, allow_destroy: true

  has_many :anexos, dependent: :destroy, as: :anexavel
  accepts_nested_attributes_for :anexos, allow_destroy: true

  has_many :operacoes, dependent: :destroy, class_name: "PedidoOperacao"
  accepts_nested_attributes_for :operacoes, allow_destroy: true

  validates :cliente_id, :descricao, presence: true

  after_create :set_numero

  belongs_to :responsavel, class_name: "Usuario"

  def set_numero
    numero = "#{created_at.strftime('%Y.%m.%d')}.#{cliente_id}.#{id}"
    update_attributes numero: numero
  end
end