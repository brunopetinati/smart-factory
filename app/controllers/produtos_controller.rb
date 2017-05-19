class ProdutosController < ApplicationController
  include AnexosHelper

  before_action { @configuracoes = true }
  before_action :set_produto, only: [:show, :edit, :update, :destroy]

  # GET /produtos
  # GET /produtos.json
  def index
    @produtos = Produto.all
  end

  # GET /produtos/1
  # GET /produtos/1.json
  def show
    load_anexos
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
    @produto.descricao = params[:descricao]
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos
  # POST /produtos.json
  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html do
          if params[:return_to].present?
            redirect_to params[:return_to], notice: 'Produto cadastrado com sucesso.' 
          else
            redirect_to @produto, notice: 'Produto cadastrado com sucesso.' 
          end
        end
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1
  # PATCH/PUT /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)
        format.html { redirect_to @produto, notice: 'Produto atualizado.' }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.json
  def destroy
    @produto.destroy
    respond_to do |format|
      format.html { redirect_to produtos_url, notice: 'Produto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produto_params
      params.require(:produto).permit(
        :codigo, 
        :descricao,
        :unidade_medida,
        :tipo,
        {:anexos_attributes => [:id, :tipo, :descricao, :codigo, :revisao, :arquivo, :_destroy]},
        {:materia_primas_attributes => [:id, :produto_id, :produto_usado_id, :quantidade, :_destroy]},
        {:operacoes_attributes => [:id, :ordem, :descricao, :maquina_id, :tempo_setup, :tempo_operacao, {:ferramenta_ids => []}, 
                                   :observacao, :_destroy]}
      )
    end
end