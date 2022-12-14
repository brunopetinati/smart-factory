class Usuario < ActiveRecord::Base
  include Codigo
  include Enderecos

  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :nome, presence: true

  enumerize :escolaridade, in: %w(01 02 03 04 05 06 07 08 09 10 11 12)
  enumerize :perfil, in: [:administrador, :vendas, :engenharia, :pcp, :operador], default: :operador, predicates: true, scope: true
  enumerize :tipo_sanguineo, in: %w(a+ a- b+ b- ab+ ab- o+ o-)

  scope :ativo, -> { where(ativo: true) }

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100#" }, default_url: "/assets/fallback/:style/avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_and_belongs_to_many :maquinas

  belongs_to :turno

  scope :with_query, -> (q) { where("nome ilike '%' || ? || '%'", q) }
  scope :por_nome,   -> { order('nome ASC') }

  def active_for_authentication?
    ativo
  end

  def minhas_maquinas
    if perfil.operador?
      maquinas
    else
      Maquina.all
    end
  end

end
