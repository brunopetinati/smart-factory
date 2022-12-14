class CreateItemPedidos < ActiveRecord::Migration[5.0]
  def change
    create_table :item_pedidos do |t|
      t.references :pedido, foreign_key: true
      t.string :descricao_produto
      t.references :produto, foreign_key: true
      t.integer :quantidade

      t.timestamps
    end
  end
end
