# SIGEL - Etapa 02: Sistema de Checklist para Vistorias

**Data:** 03/02/2026
**Versão:** 1.0

---

## Objetivo

Implementar o sistema de checklist completo que será utilizado nas vistorias de veículos. Esta etapa cria a estrutura base de classificações, etapas e itens de verificação.

---

## Dependências

| Etapa | Descrição | Status |
|-------|-----------|--------|
| 01 | Autenticação e CRUD de Veículos | ✅ Concluída |

---

## Tecnologias Utilizadas

| Tecnologia | Versão | Finalidade |
|------------|--------|------------|
| Ruby on Rails | 8.1.2 | Framework MVC |
| PostgreSQL | - | Banco de dados |
| Bootstrap | 5.3 (CDN) | Framework CSS |
| Simple Form | 5.3 | Formulários |
| Pagy | 6.0 | Paginação |
| Ransack | 4.0 | Busca e filtros |
| Discard | 1.3 | Soft delete |
| Acts As List | 1.2 | Ordenação de itens |

---

## Estrutura do Banco de Dados

### Tabela: i_classificacoes_itens
```
- id (bigint, PK)
- descricao (string, not null) - Ex: Bom, Regular, Imprestável, Faltando
- codigo (string(1), unique, not null) - Ex: B, R, I, F
- peso_base (decimal(5,2), not null) - Peso para cálculo de pontuação
- discarded_at (datetime) - soft delete
- created_at (datetime)
- updated_at (datetime)
```

### Tabela: i_etapas_checklist
```
- id (bigint, PK)
- descricao (string, not null) - Ex: Motor, Lataria, Interior
- ordem (integer, not null, unique) - Sequência de exibição
- peso_etapa (decimal(5,2), not null, default: 1.0) - Peso da etapa no cálculo
- ativo (boolean, default: true) - Se a etapa está ativa
- discarded_at (datetime) - soft delete
- created_at (datetime)
- updated_at (datetime)
```

### Tabela: i_itens_checklist
```
- id (bigint, PK)
- descricao (string, not null) - Ex: Estado do motor, Lataria frontal
- i_etapa_checklist_id (bigint, FK, not null) - Referência à etapa
- peso_relativo (decimal(5,2), not null, default: 1.0) - Peso dentro da etapa
- obrigatorio (boolean, default: true) - Se é obrigatório preencher
- ativo (boolean, default: true) - Se o item está ativo
- ordem (integer) - Ordem dentro da etapa
- discarded_at (datetime) - soft delete
- created_at (datetime)
- updated_at (datetime)
```

---

## Diagrama de Relacionamentos

```
┌─────────────────────────────┐
│   i_classificacoes_itens    │
├─────────────────────────────┤
│ id                          │
│ descricao                   │
│ codigo (B, R, I, F)         │
│ peso_base                   │
└─────────────────────────────┘
        │
        │ (usado nas vistorias - etapa futura)
        ▼
┌─────────────────────────────┐         ┌─────────────────────────────┐
│    i_etapas_checklist       │ 1 ───── │     i_itens_checklist       │
├─────────────────────────────┤    N    ├─────────────────────────────┤
│ id                          │         │ id                          │
│ descricao                   │         │ descricao                   │
│ ordem                       │         │ i_etapa_checklist_id (FK)   │
│ peso_etapa                  │         │ peso_relativo               │
│ ativo                       │         │ obrigatorio                 │
└─────────────────────────────┘         │ ativo                       │
                                        │ ordem                       │
                                        └─────────────────────────────┘
```

---

## Arquivos a Criar/Modificar

### Migrations
| Arquivo | Descrição |
|---------|-----------|
| `db/migrate/*_create_i_classificacoes_itens.rb` | Criação da tabela de classificações |
| `db/migrate/*_create_i_etapas_checklist.rb` | Criação da tabela de etapas |
| `db/migrate/*_create_i_itens_checklist.rb` | Criação da tabela de itens |

### Models
| Arquivo | Descrição |
|---------|-----------|
| `app/models/i_classificacao_item.rb` | Model de classificações com validações |
| `app/models/i_etapa_checklist.rb` | Model de etapas com ordenação |
| `app/models/i_item_checklist.rb` | Model de itens com associações |

### Controllers
| Arquivo | Descrição |
|---------|-----------|
| `app/controllers/i_classificacoes_itens_controller.rb` | CRUD de classificações |
| `app/controllers/i_etapas_checklist_controller.rb` | CRUD de etapas com reordenação |
| `app/controllers/i_itens_checklist_controller.rb` | CRUD de itens com filtro por etapa |

### Views
| Diretório | Descrição |
|-----------|-----------|
| `app/views/i_classificacoes_itens/` | Views de classificações |
| `app/views/i_etapas_checklist/` | Views de etapas |
| `app/views/i_itens_checklist/` | Views de itens |

### Rotas
| Arquivo | Descrição |
|---------|-----------|
| `config/routes.rb` | Adicionar rotas dos novos recursos |

---

## Rotas a Implementar

### Classificações de Itens
```
GET    /i_classificacoes_itens           -> Listar classificações
GET    /i_classificacoes_itens/new       -> Formulário nova classificação
POST   /i_classificacoes_itens           -> Criar classificação
GET    /i_classificacoes_itens/:id       -> Visualizar classificação
GET    /i_classificacoes_itens/:id/edit  -> Editar classificação
PATCH  /i_classificacoes_itens/:id       -> Atualizar classificação
DELETE /i_classificacoes_itens/:id       -> Excluir (soft delete)
```

### Etapas do Checklist
```
GET    /i_etapas_checklist               -> Listar etapas (ordenadas)
GET    /i_etapas_checklist/new           -> Formulário nova etapa
POST   /i_etapas_checklist               -> Criar etapa
GET    /i_etapas_checklist/:id           -> Visualizar etapa com itens
GET    /i_etapas_checklist/:id/edit      -> Editar etapa
PATCH  /i_etapas_checklist/:id           -> Atualizar etapa
DELETE /i_etapas_checklist/:id           -> Excluir (soft delete)
POST   /i_etapas_checklist/:id/mover     -> Reordenar etapa (subir/descer)
```

### Itens do Checklist
```
GET    /i_itens_checklist                -> Listar itens (filtro por etapa)
GET    /i_itens_checklist/new            -> Formulário novo item
POST   /i_itens_checklist                -> Criar item
GET    /i_itens_checklist/:id            -> Visualizar item
GET    /i_itens_checklist/:id/edit       -> Editar item
PATCH  /i_itens_checklist/:id            -> Atualizar item
DELETE /i_itens_checklist/:id            -> Excluir (soft delete)
POST   /i_itens_checklist/:id/mover      -> Reordenar item dentro da etapa
```

---

## Funcionalidades a Implementar

### Classificações de Itens
- [ ] Listagem com paginação
- [ ] Indicador visual de cor por código (B=verde, R=amarelo, I=laranja, F=vermelho)
- [ ] Criação de novas classificações
- [ ] Edição de classificações existentes
- [ ] Visualização de detalhes
- [ ] Exclusão com soft delete
- [ ] Validação de código único (1 caractere)
- [ ] Validação de descrição única

### Etapas do Checklist
- [ ] Listagem ordenada por campo `ordem`
- [ ] Drag-and-drop ou botões para reordenar
- [ ] Criação com ordem automática (próxima disponível)
- [ ] Edição de etapas existentes
- [ ] Visualização com listagem de itens vinculados
- [ ] Toggle de ativo/inativo
- [ ] Exclusão com soft delete (verificar se tem itens vinculados)
- [ ] Contador de itens por etapa na listagem

### Itens do Checklist
- [ ] Listagem com filtro por etapa
- [ ] Agrupamento visual por etapa
- [ ] Criação vinculada a uma etapa
- [ ] Edição de itens existentes
- [ ] Visualização de detalhes
- [ ] Toggle de obrigatório/opcional
- [ ] Toggle de ativo/inativo
- [ ] Exclusão com soft delete
- [ ] Ordenação dentro da etapa
- [ ] Validação de descrição única dentro da mesma etapa

---

## Validações

### i_classificacao_item
```ruby
validates :descricao, presence: true, uniqueness: { case_sensitive: false }
validates :codigo, presence: true, uniqueness: true, length: { is: 1 }
validates :peso_base, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
```

### i_etapa_checklist
```ruby
validates :descricao, presence: true, uniqueness: { case_sensitive: false }
validates :ordem, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }
validates :peso_etapa, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
```

### i_item_checklist
```ruby
validates :descricao, presence: true
validates :descricao, uniqueness: { scope: :i_etapa_checklist_id, case_sensitive: false }
validates :i_etapa_checklist_id, presence: true
validates :peso_relativo, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
```

---

## Dados de Seed

### Classificações de Itens
| Código | Descrição | Peso Base | Cor Sugerida |
|--------|-----------|-----------|--------------|
| B | Bom | 10.00 | Verde (#28a745) |
| R | Regular | 6.00 | Amarelo (#ffc107) |
| I | Imprestável | 2.00 | Laranja (#fd7e14) |
| F | Faltando | 0.00 | Vermelho (#dc3545) |

### Etapas do Checklist
| Ordem | Descrição | Peso |
|-------|-----------|------|
| 1 | Motor e Mecânica | 2.0 |
| 2 | Lataria e Pintura | 1.5 |
| 3 | Interior e Acabamento | 1.0 |
| 4 | Elétrica e Iluminação | 1.5 |
| 5 | Pneus e Rodas | 1.0 |
| 6 | Documentação | 1.0 |

### Itens do Checklist (por Etapa)

#### Motor e Mecânica (Etapa 1)
| Ordem | Item | Obrigatório | Peso |
|-------|------|-------------|------|
| 1 | Estado geral do motor | Sim | 2.0 |
| 2 | Funcionamento do motor | Sim | 2.0 |
| 3 | Sistema de arrefecimento | Sim | 1.5 |
| 4 | Sistema de escapamento | Sim | 1.0 |
| 5 | Câmbio/Transmissão | Sim | 1.5 |
| 6 | Embreagem | Sim | 1.0 |
| 7 | Freios | Sim | 2.0 |
| 8 | Suspensão | Sim | 1.5 |
| 9 | Direção | Sim | 1.5 |
| 10 | Vazamentos | Sim | 1.0 |

#### Lataria e Pintura (Etapa 2)
| Ordem | Item | Obrigatório | Peso |
|-------|------|-------------|------|
| 1 | Lataria frontal | Sim | 1.5 |
| 2 | Lataria traseira | Sim | 1.5 |
| 3 | Lataria lateral esquerda | Sim | 1.5 |
| 4 | Lataria lateral direita | Sim | 1.5 |
| 5 | Teto | Sim | 1.0 |
| 6 | Para-choques dianteiro | Sim | 1.0 |
| 7 | Para-choques traseiro | Sim | 1.0 |
| 8 | Pintura geral | Sim | 1.5 |
| 9 | Corrosão/Ferrugem | Sim | 1.5 |

#### Interior e Acabamento (Etapa 3)
| Ordem | Item | Obrigatório | Peso |
|-------|------|-------------|------|
| 1 | Bancos dianteiros | Sim | 1.5 |
| 2 | Bancos traseiros | Sim | 1.0 |
| 3 | Painel/Dashboard | Sim | 1.5 |
| 4 | Forração do teto | Não | 0.5 |
| 5 | Forração das portas | Não | 0.5 |
| 6 | Carpete/Assoalho | Não | 0.5 |
| 7 | Volante | Sim | 1.0 |
| 8 | Console central | Não | 0.5 |
| 9 | Porta-luvas | Não | 0.5 |
| 10 | Retrovisores internos | Sim | 1.0 |

#### Elétrica e Iluminação (Etapa 4)
| Ordem | Item | Obrigatório | Peso |
|-------|------|-------------|------|
| 1 | Bateria | Sim | 1.5 |
| 2 | Faróis dianteiros | Sim | 1.5 |
| 3 | Lanternas traseiras | Sim | 1.5 |
| 4 | Setas/Piscas | Sim | 1.0 |
| 5 | Luz de freio | Sim | 1.0 |
| 6 | Luz de ré | Sim | 1.0 |
| 7 | Iluminação interna | Não | 0.5 |
| 8 | Limpador de para-brisa | Sim | 1.0 |
| 9 | Ar condicionado | Não | 0.5 |
| 10 | Vidros elétricos | Não | 0.5 |
| 11 | Travas elétricas | Não | 0.5 |
| 12 | Alarme | Não | 0.5 |

#### Pneus e Rodas (Etapa 5)
| Ordem | Item | Obrigatório | Peso |
|-------|------|-------------|------|
| 1 | Pneu dianteiro esquerdo | Sim | 1.5 |
| 2 | Pneu dianteiro direito | Sim | 1.5 |
| 3 | Pneu traseiro esquerdo | Sim | 1.5 |
| 4 | Pneu traseiro direito | Sim | 1.5 |
| 5 | Estepe | Sim | 1.0 |
| 6 | Rodas/Calotas | Sim | 1.0 |
| 7 | Macaco e chave de roda | Não | 0.5 |

#### Documentação (Etapa 6)
| Ordem | Item | Obrigatório | Peso |
|-------|------|-------------|------|
| 1 | CRLV em dia | Sim | 2.0 |
| 2 | Débitos IPVA | Sim | 2.0 |
| 3 | Multas | Sim | 1.5 |
| 4 | Restrições judiciais | Sim | 2.0 |
| 5 | Recall pendente | Não | 1.0 |

---

## Interface de Usuário

### Tela de Listagem de Etapas
```
┌─────────────────────────────────────────────────────────────────────────┐
│ Sistema de Checklist > Etapas                              [+ Nova Etapa]│
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌────┬──────────────────────────┬───────┬────────┬───────┬──────────┐  │
│  │ #  │ Descrição                │ Peso  │ Itens  │ Ativo │ Ações    │  │
│  ├────┼──────────────────────────┼───────┼────────┼───────┼──────────┤  │
│  │ 1  │ Motor e Mecânica         │ 2.0   │ 10     │ ✓     │ ↑ ↓ ✎ 🗑 │  │
│  │ 2  │ Lataria e Pintura        │ 1.5   │ 9      │ ✓     │ ↑ ↓ ✎ 🗑 │  │
│  │ 3  │ Interior e Acabamento    │ 1.0   │ 10     │ ✓     │ ↑ ↓ ✎ 🗑 │  │
│  │ 4  │ Elétrica e Iluminação    │ 1.5   │ 12     │ ✓     │ ↑ ↓ ✎ 🗑 │  │
│  │ 5  │ Pneus e Rodas            │ 1.0   │ 7      │ ✓     │ ↑ ↓ ✎ 🗑 │  │
│  │ 6  │ Documentação             │ 1.0   │ 5      │ ✓     │ ↑ ↓ ✎ 🗑 │  │
│  └────┴──────────────────────────┴───────┴────────┴───────┴──────────┘  │
│                                                                          │
│  Total: 6 etapas | 53 itens                                              │
└─────────────────────────────────────────────────────────────────────────┘
```

### Tela de Visualização de Etapa (com Itens)
```
┌─────────────────────────────────────────────────────────────────────────┐
│ Etapa: Motor e Mecânica                                    [Editar] [←] │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  Peso da Etapa: 2.0    │    Status: Ativo    │    Itens: 10             │
│                                                                          │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                          │
│  Itens desta Etapa                                          [+ Novo Item]│
│                                                                          │
│  ┌────┬─────────────────────────────┬───────┬─────────────┬──────────┐  │
│  │ #  │ Item                        │ Peso  │ Obrigatório │ Ações    │  │
│  ├────┼─────────────────────────────┼───────┼─────────────┼──────────┤  │
│  │ 1  │ Estado geral do motor       │ 2.0   │ ✓           │ ↑ ↓ ✎ 🗑 │  │
│  │ 2  │ Funcionamento do motor      │ 2.0   │ ✓           │ ↑ ↓ ✎ 🗑 │  │
│  │ 3  │ Sistema de arrefecimento    │ 1.5   │ ✓           │ ↑ ↓ ✎ 🗑 │  │
│  │ ...│ ...                         │ ...   │ ...         │ ...      │  │
│  └────┴─────────────────────────────┴───────┴─────────────┴──────────┘  │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### Tela de Classificações
```
┌─────────────────────────────────────────────────────────────────────────┐
│ Sistema de Checklist > Classificações                                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌────────┬──────────────┬───────────┬─────────────────────────────────┐ │
│  │ Código │ Descrição    │ Peso Base │ Indicador                       │ │
│  ├────────┼──────────────┼───────────┼─────────────────────────────────┤ │
│  │   B    │ Bom          │   10.00   │ ████████████████████ (100%)     │ │
│  │   R    │ Regular      │    6.00   │ ████████████         (60%)      │ │
│  │   I    │ Imprestável  │    2.00   │ ████                 (20%)      │ │
│  │   F    │ Faltando     │    0.00   │                      (0%)       │ │
│  └────────┴──────────────┴───────────┴─────────────────────────────────┘ │
│                                                                          │
│  ⚠️ Atenção: Alterações nas classificações afetam o cálculo de todas    │
│     as avaliações futuras.                                               │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Regras de Negócio

### RN01 - Exclusão de Etapa
> Uma etapa só pode ser excluída (soft delete) se não houver vistorias vinculadas a ela.
> Se houver itens vinculados mas sem vistorias, os itens também serão desativados.

### RN02 - Exclusão de Item
> Um item só pode ser excluído (soft delete) se não houver registros de vistoria usando este item.
> Itens podem ser desativados a qualquer momento (não aparecem em novas vistorias).

### RN03 - Alteração de Classificação
> Alterações no peso_base das classificações só afetam avaliações futuras.
> Avaliações já realizadas mantêm os valores calculados na época.

### RN04 - Ordenação
> A ordem das etapas deve ser única e sequencial (1, 2, 3...).
> Ao reordenar, as demais etapas são ajustadas automaticamente.

### RN05 - Itens Obrigatórios
> Itens marcados como obrigatórios devem ser preenchidos em toda vistoria.
> A vistoria não pode ser concluída sem todos os itens obrigatórios.

---

## Menu de Navegação

Adicionar ao menu principal:

```
Cadastros
├── Veículos
├── Tipos de Veículos
└── Checklist
    ├── Classificações
    ├── Etapas
    └── Itens
```

---

## Helpers e Concerns

### Concern: Ordenavel
```ruby
# app/models/concerns/ordenavel.rb
module Ordenavel
  extend ActiveSupport::Concern

  included do
    scope :ordenado, -> { order(ordem: :asc) }
  end

  def mover_para_cima
    return if ordem == 1
    trocar_ordem_com(self.class.find_by(ordem: ordem - 1))
  end

  def mover_para_baixo
    proximo = self.class.find_by(ordem: ordem + 1)
    return unless proximo
    trocar_ordem_com(proximo)
  end

  private

  def trocar_ordem_com(outro)
    return unless outro
    self.class.transaction do
      ordem_atual = self.ordem
      self.update!(ordem: outro.ordem)
      outro.update!(ordem: ordem_atual)
    end
  end
end
```

### Helper: ChecklistHelper
```ruby
# app/helpers/checklist_helper.rb
module ChecklistHelper
  def cor_classificacao(codigo)
    cores = {
      'B' => 'success',   # Verde
      'R' => 'warning',   # Amarelo
      'I' => 'orange',    # Laranja (custom)
      'F' => 'danger'     # Vermelho
    }
    cores[codigo] || 'secondary'
  end

  def badge_classificacao(classificacao)
    content_tag :span, classificacao.codigo,
      class: "badge bg-#{cor_classificacao(classificacao.codigo)}",
      title: classificacao.descricao
  end

  def barra_peso(peso, max: 10)
    percentual = (peso / max.to_f * 100).round
    content_tag :div, class: 'progress', style: 'height: 20px;' do
      content_tag :div, "#{peso}",
        class: 'progress-bar',
        style: "width: #{percentual}%",
        role: 'progressbar'
    end
  end
end
```

---

## Testes Sugeridos

### Model Tests
```ruby
# test/models/i_classificacao_item_test.rb
- test "deve ter descrição"
- test "deve ter código único de 1 caractere"
- test "deve ter peso_base entre 0 e 10"
- test "código deve ser maiúsculo"

# test/models/i_etapa_checklist_test.rb
- test "deve ter descrição única"
- test "deve ter ordem única"
- test "deve ter peso_etapa positivo"
- test "mover_para_cima deve trocar ordem"
- test "mover_para_baixo deve trocar ordem"
- test "não deve mover para cima se for primeiro"

# test/models/i_item_checklist_test.rb
- test "deve pertencer a uma etapa"
- test "descrição deve ser única dentro da etapa"
- test "deve ter peso_relativo positivo"
```

### Controller Tests
```ruby
# test/controllers/i_etapas_checklist_controller_test.rb
- test "index deve listar etapas ordenadas"
- test "show deve incluir itens da etapa"
- test "create deve criar com próxima ordem disponível"
- test "destroy deve fazer soft delete"
- test "mover deve reordenar etapas"
```

---

## Estimativa de Arquivos

| Tipo | Quantidade | Arquivos |
|------|------------|----------|
| Migrations | 3 | create_i_classificacoes_itens, create_i_etapas_checklist, create_i_itens_checklist |
| Models | 3 | i_classificacao_item, i_etapa_checklist, i_item_checklist |
| Controllers | 3 | i_classificacoes_itens, i_etapas_checklist, i_itens_checklist |
| Views | ~15 | index, show, new, edit, _form, _item para cada |
| Concerns | 1 | ordenavel |
| Helpers | 1 | checklist_helper |
| Seeds | 1 | Atualização do db/seeds.rb |
| **Total** | **~27** | |

---

## Comandos para Implementação

```bash
# 1. Gerar migrations
rails generate migration CreateIClassificacoesItens descricao:string codigo:string:uniq peso_base:decimal discarded_at:datetime:index
rails generate migration CreateIEtapasChecklist descricao:string ordem:integer:uniq peso_etapa:decimal ativo:boolean discarded_at:datetime:index
rails generate migration CreateIItensChecklist descricao:string i_etapa_checklist:references peso_relativo:decimal obrigatorio:boolean ativo:boolean ordem:integer discarded_at:datetime:index

# 2. Executar migrations
rails db:migrate

# 3. Gerar scaffolds (opcional - para acelerar)
rails generate scaffold_controller IClassificacoesItens descricao codigo peso_base --skip-routes
rails generate scaffold_controller IEtapasChecklist descricao ordem peso_etapa ativo --skip-routes
rails generate scaffold_controller IItensChecklist descricao i_etapa_checklist_id peso_relativo obrigatorio ativo ordem --skip-routes

# 4. Executar seeds
rails db:seed

# 5. Iniciar servidor
rails server
```

---

## Próximas Etapas (Após Conclusão)

- [ ] **Etapa 03**: Tipos e Status de Vistorias (`i_tipos_vistorias`, `i_status_vistorias`)
- [ ] **Etapa 04**: Vistorias (`i_vistorias`, `i_vistorias_itens`)
- [ ] **Etapa 05**: Modelos de Avaliação e Faixas (`i_modelos_avaliacao`, `i_faixas_estado_conservacao`)
- [ ] **Etapa 06**: Avaliações (`i_avaliacoes`) com cálculo automático

---

## Observações Técnicas

1. **Acts As List**: Gem recomendada para gerenciar ordenação. Alternativa: implementar manualmente com concern `Ordenavel`.

2. **Nested Resources**: Os itens podem ser tratados como nested de etapas:
   ```ruby
   resources :i_etapas_checklist do
     resources :i_itens_checklist, shallow: true
   end
   ```

3. **Turbo Frames**: Considerar uso de Turbo Frames para reordenação dinâmica sem reload.

4. **Cache de Contagem**: Usar `counter_cache` para evitar N+1 na contagem de itens por etapa:
   ```ruby
   belongs_to :i_etapa_checklist, counter_cache: :itens_count
   ```

5. **Soft Delete em Cascata**: Ao desativar uma etapa, considerar desativar todos os itens automaticamente.
