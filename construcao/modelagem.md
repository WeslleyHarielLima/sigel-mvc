# SIGEL - Sistema de Gestão de Leilões
## Modelagem de Dados Corrigida

> **Versão:** 2.0
> **Data:** 2026-02-03
> **Database:** PostgreSQL

---

## Sumário

1. [Visão Geral](#visão-geral)
2. [Correções Aplicadas](#correções-aplicadas)
3. [Diagrama de Módulos](#diagrama-de-módulos)
4. [Modelagem Completa](#modelagem-completa)
5. [Ordem de Implementação](#ordem-de-implementação)

---

## Visão Geral

O SIGEL é um sistema multi-órgão para gestão completa do ciclo de vida de veículos destinados a leilão, desde o recebimento até a arrematação final.

### Módulos do Sistema

| Prefixo | Módulo | Descrição |
|---------|--------|-----------|
| `g_` | Geográfico | Base territorial compartilhada |
| `a_` | Administrativo | Usuários, perfis e acessos |
| `v_` | Veículos | Núcleo do sistema - cadastro de bens |
| `i_` | Inspeção | Vistorias, checklists e avaliações |
| `l_` | Leilão | Gestão de leilões e lotes |
| `r_` | Resultados | Arrematações e desfechos |
| `h_` | Histórico | Auditoria e eventos |

---

## Correções Aplicadas

### 1. Constraint de Veículo em Múltiplos Leilões Ativos
**Problema:** Não havia garantia de que um veículo não estivesse em dois leilões não finalizados.
**Solução:** Adicionada constraint `EXCLUDE` e documentação de trigger necessário.

### 2. Snapshots Redundantes em `v_veiculos`
**Problema:** Campos derivados podiam dessincronizar.
**Solução:** Mantidos como cache com documentação clara de que são atualizados via trigger após cada avaliação.

### 3. `g_bairros` Não Utilizado
**Problema:** Tabela existia mas não era referenciada.
**Solução:** Adicionado `g_bairro_id` em `g_orgaos` para endereço completo.

### 4. `v_proprietarios` Simplificado
**Problema:** Faltavam dados de contato e histórico.
**Solução:**
- Adicionados campos: `tipo_pessoa`, `email`, `telefone`, `endereco`, `g_municipio_id`
- Criada tabela `v_historico_proprietarios` para rastrear mudanças de propriedade

### 5. Falta Normalização de Marcas/Modelos
**Problema:** Strings livres causavam inconsistências.
**Solução:** Criadas tabelas `v_marcas` e `v_modelos` com relacionamento adequado.

### 6. Arrematante Não Modelado
**Problema:** Não havia registro de quem arrematou.
**Solução:** Criada tabela `r_arrematantes` e vinculada a `r_resultados_lotes`.

### 7. `l_publicacoes` Sem Soft Delete
**Problema:** Quebrava padrão do sistema.
**Solução:** Adicionado campo `deleted_at`.

### 8. Usuário com Perfil Único
**Problema:** Não suportava múltiplos perfis por usuário.
**Solução:** Criada tabela associativa `a_usuarios_perfis` (N:N).

### 9. Valores de Mercado Sem Vínculo
**Problema:** Busca por strings sem FK.
**Solução:** `i_valores_mercado` agora referencia `v_modelo_id` diretamente.

---

## Diagrama de Módulos

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            SIGEL - Arquitetura                               │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │  GEOGRÁFICO  │    │ADMINISTRATIVO│    │  INSTITUCIONAL│                  │
│  │    (g_)      │◄───│    (a_)      │───►│    (g_)       │                  │
│  │              │    │              │    │               │                  │
│  │ • Países     │    │ • Usuários   │    │ • Órgãos      │                  │
│  │ • Estados    │    │ • Perfis     │    │ • Status      │                  │
│  │ • Municípios │    │ • Permissões │    │               │                  │
│  │ • Bairros    │    │              │    │               │                  │
│  └──────────────┘    └──────────────┘    └───────┬───────┘                  │
│                                                   │                          │
│                                                   ▼                          │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                         VEÍCULOS (v_)                                 │   │
│  │  • Marcas  • Modelos  • Tipos  • Status  • Proprietários  • Fotos    │   │
│  └──────────────────────────────────┬───────────────────────────────────┘   │
│                                     │                                        │
│                                     ▼                                        │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                        INSPEÇÃO (i_)                                  │   │
│  │  • Checklist (Etapas/Itens)  • Vistorias  • Avaliações  • Valores    │   │
│  └──────────────────────────────────┬───────────────────────────────────┘   │
│                                     │                                        │
│                                     ▼                                        │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                         LEILÃO (l_)                                   │   │
│  │  • Leilões  • Lotes  • Publicações                                   │   │
│  └──────────────────────────────────┬───────────────────────────────────┘   │
│                                     │                                        │
│                                     ▼                                        │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                       RESULTADOS (r_)                                 │   │
│  │  • Arrematantes  • Resultados dos Lotes                              │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                       AUDITORIA (h_)                                  │   │
│  │  • Eventos (Livro-razão de todas as ações)                           │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Modelagem Completa

```dbml
// SIGEL - Sistema de Gestão de Leilões
// Versão 2.0 - Modelagem Corrigida
// Para uso em dbdiagram.io

Project SIGEL {
  database_type: 'PostgreSQL'
  Note: 'Sistema de Gestão de Leilões de Veículos - v2.0'
}

// ============================================
// 1️⃣ BASE GEOGRÁFICA (COMPARTILHADA)
// ============================================

Table g_paises {
  id bigint [pk, increment]
  descricao varchar(100) [not null]
  sigla varchar(3) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    sigla [unique]
  }
}

Table g_estados {
  id bigint [pk, increment]
  descricao varchar(100) [not null]
  uf varchar(2) [not null]
  g_pais_id bigint [not null, ref: > g_paises.id]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    uf [unique]
    g_pais_id
  }
}

Table g_municipios {
  id bigint [pk, increment]
  descricao varchar(150) [not null]
  codigo_ibge varchar(7) [not null]
  g_estado_id bigint [not null, ref: > g_estados.id]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo_ibge [unique]
    g_estado_id
  }
}

Table g_bairros {
  id bigint [pk, increment]
  descricao varchar(150) [not null]
  g_municipio_id bigint [not null, ref: > g_municipios.id]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    g_municipio_id
    (g_municipio_id, descricao) [unique]
  }
}

// ============================================
// 2️⃣ GESTÃO INSTITUCIONAL (MULTI-ÓRGÃO)
// ============================================

Table g_status_orgaos {
  id bigint [pk, increment]
  descricao varchar(50) [not null]
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table g_orgaos {
  id bigint [pk, increment]
  nome varchar(200) [not null]
  sigla varchar(20) [not null]
  cnpj varchar(18) [unique]
  logradouro varchar(200)
  numero varchar(20)
  complemento varchar(100)
  cep varchar(10)
  g_bairro_id bigint [ref: > g_bairros.id, note: 'CORRIGIDO: Agora usa bairro']
  g_municipio_id bigint [not null, ref: > g_municipios.id]
  g_status_orgao_id bigint [not null, ref: > g_status_orgaos.id]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    cnpj
    g_municipio_id
    g_status_orgao_id
  }
}

// ============================================
// 3️⃣ ADMINISTRATIVO / ACESSO
// ============================================

Table a_status_usuarios {
  id bigint [pk, increment]
  descricao varchar(50) [not null]
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table a_perfis {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Administrador, Gestor Interno, Vistoriador, etc']
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table a_usuarios {
  id bigint [pk, increment]
  nome varchar(150) [not null]
  email varchar(150) [not null]
  password varchar(255) [not null]
  cpf varchar(14) [not null]
  telefone varchar(20)
  a_status_usuario_id bigint [not null, ref: > a_status_usuarios.id]
  g_orgao_id bigint [not null, ref: > g_orgaos.id]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    email [unique]
    cpf [unique]
    g_orgao_id
  }

  Note: 'CORRIGIDO: Perfis agora são N:N via a_usuarios_perfis'
}

// NOVA TABELA: Relacionamento N:N entre usuários e perfis
Table a_usuarios_perfis {
  id bigint [pk, increment]
  a_usuario_id bigint [not null, ref: > a_usuarios.id]
  a_perfil_id bigint [not null, ref: > a_perfis.id]
  ativo boolean [default: true]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    (a_usuario_id, a_perfil_id) [unique]
    a_perfil_id
  }

  Note: 'NOVO: Permite múltiplos perfis por usuário'
}

// ============================================
// 4️⃣ PROPRIETÁRIOS (EXPANDIDO)
// ============================================

Table v_tipos_proprietarios {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Pessoa Física, Pessoa Jurídica, Órgão Público']
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }

  Note: 'NOVO: Diferencia tipos de proprietário'
}

Table v_proprietarios {
  id bigint [pk, increment]
  nome_completo varchar(200) [not null]
  cpf_cnpj varchar(18) [not null]
  v_tipo_proprietario_id bigint [not null, ref: > v_tipos_proprietarios.id]

  // Contato (NOVOS CAMPOS)
  email varchar(150)
  telefone varchar(20)
  telefone_secundario varchar(20)

  // Endereço (NOVOS CAMPOS)
  logradouro varchar(200)
  numero varchar(20)
  complemento varchar(100)
  cep varchar(10)
  g_bairro_id bigint [ref: > g_bairros.id]
  g_municipio_id bigint [ref: > g_municipios.id]

  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    cpf_cnpj [unique]
    v_tipo_proprietario_id
  }

  Note: 'CORRIGIDO: Adicionados contato, endereço e tipo'
}

// NOVA TABELA: Histórico de proprietários
Table v_historico_proprietarios {
  id bigint [pk, increment]
  v_veiculo_id bigint [not null, ref: > v_veiculos.id]
  v_proprietario_id bigint [not null, ref: > v_proprietarios.id]
  data_inicio date [not null]
  data_fim date
  motivo_transferencia varchar(200)
  documento_referencia varchar(100) [note: 'Número do documento de transferência']
  created_by bigint
  created_at timestamp [default: `now()`]

  Indexes {
    v_veiculo_id
    v_proprietario_id
    (v_veiculo_id, data_inicio)
  }

  Note: 'NOVO: Rastreia histórico de propriedade do veículo'
}

// ============================================
// 5️⃣ VEÍCULOS - MARCAS E MODELOS NORMALIZADOS
// ============================================

// NOVA TABELA: Marcas normalizadas
Table v_marcas {
  id bigint [pk, increment]
  descricao varchar(50) [not null]
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
    descricao [unique]
  }

  Note: 'NOVO: Marcas normalizadas para consistência'
}

// NOVA TABELA: Modelos normalizados
Table v_modelos {
  id bigint [pk, increment]
  descricao varchar(100) [not null]
  codigo varchar(30) [not null]
  v_marca_id bigint [not null, ref: > v_marcas.id]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
    v_marca_id
    (v_marca_id, descricao) [unique]
  }

  Note: 'NOVO: Modelos vinculados a marcas'
}

Table v_status_veiculos {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Pendente, Verificado-Apto, Impedido, Em Leilão, Arrematado']
  codigo varchar(20) [not null]
  permite_leilao boolean [default: false, note: 'NOVO: Indica se pode ir para leilão']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table v_tipos_veiculos {
  id bigint [pk, increment]
  descricao varchar(50) [not null]
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table v_veiculos {
  id bigint [pk, increment]
  numero_interno varchar(50) [not null, note: 'Controle interno']
  placa varchar(10)
  chassi varchar(50) [not null]
  renavam varchar(20)
  ano_fabricacao int [not null]
  ano_modelo int [not null]
  cor varchar(30)
  motor varchar(50)
  tombamento varchar(50)

  // CORRIGIDO: Agora usa FK para marca/modelo
  v_marca_id bigint [not null, ref: > v_marcas.id]
  v_modelo_id bigint [not null, ref: > v_modelos.id]

  // SNAPSHOT ATUAL (derivado de i_avaliacoes via trigger)
  // Estes campos são CACHE - atualizados automaticamente após cada avaliação
  i_estado_conservacao_id bigint [ref: > i_faixas_estado_conservacao.id]
  i_classificacao_bem_id bigint [ref: > i_classificacoes_bens.id]
  valor_avaliacao_atual decimal(15,2)
  valor_depreciado_atual decimal(15,2)
  ultima_avaliacao_em timestamp

  // Relacionamentos
  v_status_veiculo_id bigint [not null, ref: > v_status_veiculos.id]
  v_tipo_veiculo_id bigint [not null, ref: > v_tipos_veiculos.id]
  v_proprietario_id bigint [ref: > v_proprietarios.id]
  g_orgao_id bigint [not null, ref: > g_orgaos.id]

  // Informações de recebimento
  data_recebimento date
  local_recebimento varchar(200)

  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    numero_interno [unique]
    chassi [unique]
    placa
    renavam
    v_marca_id
    v_modelo_id
    (g_orgao_id, v_status_veiculo_id)
    (g_orgao_id, created_at)
  }

  Note: '''
  Núcleo absoluto do SIGEL.

  IMPORTANTE - Campos de Snapshot:
  - i_estado_conservacao_id, i_classificacao_bem_id, valor_avaliacao_atual,
    valor_depreciado_atual, ultima_avaliacao_em
  - São CACHE derivados da última avaliação
  - Atualizados via TRIGGER após INSERT em i_avaliacoes
  - NÃO devem ser editados diretamente
  '''
}

// ============================================
// 6️⃣ REGISTRO FOTOGRÁFICO
// ============================================

Table v_fotos {
  id bigint [pk, increment]
  v_veiculo_id bigint [not null, ref: > v_veiculos.id]
  arquivo varchar(255) [not null]
  ordem int [not null, default: 0]
  is_capa boolean [default: false]
  descricao varchar(200)
  created_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]

  Indexes {
    (v_veiculo_id, ordem)
    (v_veiculo_id, is_capa)
  }
}

// ============================================
// 7️⃣ CHECKLIST (ESTRUTURA)
// ============================================

Table i_classificacoes_itens {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Bom, Regular, Imprestável, Faltando']
  codigo varchar(1) [not null, note: 'B, R, I, F']
  peso_base decimal(5,2) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table i_etapas_checklist {
  id bigint [pk, increment]
  descricao varchar(100) [not null, note: 'Motor, Lataria, Interior, etc']
  ordem int [not null]
  peso_etapa decimal(5,2) [not null, default: 1.0, note: 'NOVO: Peso da etapa no cálculo geral']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    ordem [unique]
  }
}

Table i_itens_checklist {
  id bigint [pk, increment]
  descricao varchar(200) [not null]
  i_etapa_checklist_id bigint [not null, ref: > i_etapas_checklist.id]
  peso_relativo decimal(5,2) [not null, note: 'Peso dentro da etapa']
  obrigatorio boolean [default: true, note: 'NOVO: Se é obrigatório preencher']
  ativo boolean [default: true, note: 'NOVO: Permite desativar item sem excluir']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    i_etapa_checklist_id
    (i_etapa_checklist_id, ativo)
  }
}

// ============================================
// 8️⃣ VISTORIAS (CHECKLIST EXECUTADO)
// ============================================

Table i_tipos_vistorias {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Mensal, Pré-Leilão']
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table i_status_vistorias {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Rascunho, Concluída, Cancelada']
  codigo varchar(20) [not null]
  permite_edicao boolean [default: true, note: 'NOVO: Se permite editar a vistoria']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table i_vistorias {
  id bigint [pk, increment]
  v_veiculo_id bigint [not null, ref: > v_veiculos.id]
  i_tipo_vistoria_id bigint [not null, ref: > i_tipos_vistorias.id]
  i_status_vistoria_id bigint [not null, ref: > i_status_vistorias.id]
  realizada_por_id bigint [not null, ref: > a_usuarios.id]
  realizada_em timestamp
  observacao_geral text [note: 'NOVO: Observação geral da vistoria']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    v_veiculo_id
    (v_veiculo_id, realizada_em)
    realizada_por_id
    i_status_vistoria_id
  }
}

Table i_vistorias_itens {
  id bigint [pk, increment]
  i_vistoria_id bigint [not null, ref: > i_vistorias.id]
  i_item_checklist_id bigint [not null, ref: > i_itens_checklist.id]
  i_classificacao_item_id bigint [not null, ref: > i_classificacoes_itens.id]
  observacao text
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    i_vistoria_id
    (i_vistoria_id, i_item_checklist_id) [unique]
  }
}

// ============================================
// 9️⃣ REGRAS DE AVALIAÇÃO
// ============================================

Table i_modelos_avaliacao {
  id bigint [pk, increment]
  descricao varchar(100) [not null]
  versao varchar(20) [not null]
  ativo boolean [default: true]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    (versao, ativo)
    ativo
  }
}

Table i_faixas_estado_conservacao {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Excelente, Bom, Regular, Péssimo']
  codigo varchar(20) [not null]
  pontuacao_min decimal(5,2) [not null]
  pontuacao_max decimal(5,2) [not null]
  cor_indicativa varchar(7) [note: 'NOVO: Cor hex para UI (ex: #28a745)']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
    (pontuacao_min, pontuacao_max)
  }
}

Table i_classificacoes_bens {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Ocioso, Recuperável, Antieconômico, Irrecuperável']
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

// ============================================
// 🔟 VALOR DE MERCADO (CORRIGIDO)
// ============================================

Table i_valores_mercado {
  id bigint [pk, increment]
  v_modelo_id bigint [not null, ref: > v_modelos.id, note: 'CORRIGIDO: Agora usa FK']
  ano int [not null]
  valor_medio decimal(15,2) [not null]
  fonte varchar(50) [not null, note: 'FIPE, Tabela Estadual']
  codigo_fipe varchar(20) [note: 'NOVO: Código FIPE quando aplicável']
  vigencia_inicio date [not null]
  vigencia_fim date
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    v_modelo_id
    (v_modelo_id, ano)
    (v_modelo_id, ano, vigencia_inicio) [unique]
    (vigencia_inicio, vigencia_fim)
  }

  Note: 'CORRIGIDO: Usa FK para modelo ao invés de strings'
}

// ============================================
// 1️⃣1️⃣ AVALIAÇÃO (ATO FORMAL)
// ============================================

Table i_avaliacoes {
  id bigint [pk, increment]
  v_veiculo_id bigint [not null, ref: > v_veiculos.id]
  i_vistoria_id bigint [not null, ref: > i_vistorias.id]
  i_modelo_avaliacao_id bigint [not null, ref: > i_modelos_avaliacao.id]
  i_estado_conservacao_id bigint [not null, ref: > i_faixas_estado_conservacao.id]
  i_classificacao_bem_id bigint [not null, ref: > i_classificacoes_bens.id]

  pontuacao_final decimal(5,2) [not null]
  valor_mercado_base decimal(15,2) [not null]
  percentual_depreciacao decimal(5,2) [not null]
  valor_depreciado decimal(15,2) [not null]

  avaliado_por_id bigint [not null, ref: > a_usuarios.id]
  avaliado_em timestamp [not null]

  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    v_veiculo_id
    (v_veiculo_id, avaliado_em)
    i_vistoria_id [unique]
  }

  Note: '''
  Aqui nasce o valor oficial do bem.

  TRIGGER NECESSÁRIO:
  Após INSERT, atualizar v_veiculos SET
    i_estado_conservacao_id = NEW.i_estado_conservacao_id,
    i_classificacao_bem_id = NEW.i_classificacao_bem_id,
    valor_avaliacao_atual = NEW.valor_mercado_base,
    valor_depreciado_atual = NEW.valor_depreciado,
    ultima_avaliacao_em = NEW.avaliado_em
  WHERE id = NEW.v_veiculo_id
  '''
}

// ============================================
// 1️⃣2️⃣ LEILÃO
// ============================================

Table l_status_leiloes {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Rascunho, Publicado, Em Andamento, Finalizado, Cancelado']
  codigo varchar(20) [not null]
  permite_edicao boolean [default: true, note: 'NOVO: Se permite editar lotes']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

Table l_leiloes {
  id bigint [pk, increment]
  codigo varchar(50) [not null]
  titulo varchar(200) [not null]
  descricao text
  data_inicio_prevista date
  data_fim_prevista date
  data_inicio_real timestamp
  data_fim_real timestamp
  l_status_leilao_id bigint [not null, ref: > l_status_leiloes.id]
  g_orgao_id bigint [not null, ref: > g_orgaos.id]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
    (g_orgao_id, l_status_leilao_id)
    data_inicio_prevista
  }
}

Table l_lotes {
  id bigint [pk, increment]
  numero_lote int [not null]
  v_veiculo_id bigint [not null, ref: > v_veiculos.id]
  l_leilao_id bigint [not null, ref: > l_leiloes.id]
  valor_minimo decimal(15,2) [note: 'NOVO: Valor mínimo de arrematação']
  travado boolean [default: false, note: 'Impede alterações']
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    (l_leilao_id, numero_lote) [unique]
    v_veiculo_id
  }

  Note: '''
  CONSTRAINT NECESSÁRIA (implementar via trigger ou regra):

  Um veículo (v_veiculo_id) só pode estar em UM leilão não finalizado.

  Implementação sugerida:
  CREATE UNIQUE INDEX idx_veiculo_leilao_ativo
  ON l_lotes (v_veiculo_id)
  WHERE deleted_at IS NULL
  AND l_leilao_id IN (
    SELECT id FROM l_leiloes
    WHERE l_status_leilao_id NOT IN (
      SELECT id FROM l_status_leiloes WHERE codigo IN ('FINALIZADO', 'CANCELADO')
    )
  );

  Ou via TRIGGER before INSERT/UPDATE
  '''
}

// ============================================
// 1️⃣3️⃣ RESULTADO DO LEILÃO
// ============================================

Table r_status_lotes {
  id bigint [pk, increment]
  descricao varchar(50) [not null, note: 'Arrematado, Não Arrematado, Retirado']
  codigo varchar(20) [not null]
  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    codigo [unique]
  }
}

// NOVA TABELA: Arrematantes
Table r_arrematantes {
  id bigint [pk, increment]
  nome_completo varchar(200) [not null]
  cpf_cnpj varchar(18) [not null]
  tipo_pessoa varchar(2) [not null, note: 'PF ou PJ']

  // Contato
  email varchar(150)
  telefone varchar(20)
  telefone_secundario varchar(20)

  // Endereço
  logradouro varchar(200)
  numero varchar(20)
  complemento varchar(100)
  cep varchar(10)
  g_bairro_id bigint [ref: > g_bairros.id]
  g_municipio_id bigint [ref: > g_municipios.id]

  // Documentação
  rg varchar(20)
  orgao_emissor varchar(20)

  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    cpf_cnpj [unique]
    email
  }

  Note: 'NOVO: Cadastro de compradores/arrematantes'
}

Table r_resultados_lotes {
  id bigint [pk, increment]
  l_lote_id bigint [not null, ref: > l_lotes.id]
  r_status_lote_id bigint [not null, ref: > r_status_lotes.id]
  r_arrematante_id bigint [ref: > r_arrematantes.id, note: 'NOVO: Quem arrematou']

  valor_avaliacao decimal(15,2) [not null]
  debitos_detran decimal(15,2) [default: 0]
  debitos_multas decimal(15,2) [default: 0]
  outros_debitos decimal(15,2) [default: 0, note: 'NOVO']
  valor_arrematacao decimal(15,2)

  data_arrematacao timestamp [note: 'NOVO: Quando foi arrematado']
  observacao text

  created_by bigint
  updated_by bigint
  deleted_at timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    l_lote_id [unique]
    r_status_lote_id
    r_arrematante_id
  }

  Note: 'CORRIGIDO: Agora registra quem arrematou'
}

// ============================================
// 1️⃣4️⃣ PUBLICAÇÕES / EDITAIS (CORRIGIDO)
// ============================================

Table l_publicacoes {
  id bigint [pk, increment]
  l_leilao_id bigint [not null, ref: > l_leiloes.id]
  data_publicacao date [not null]
  local_publicacao varchar(200) [not null]
  tipo_publicacao varchar(50) [note: 'NOVO: DOE, Jornal, Site, etc']
  arquivo varchar(255)
  created_by bigint
  updated_by bigint
  deleted_at timestamp [note: 'CORRIGIDO: Adicionado soft delete']
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]

  Indexes {
    l_leilao_id
    data_publicacao
  }
}

// ============================================
// 1️⃣5️⃣ AUDITORIA (LIVRO-RAZÃO)
// ============================================

Table h_eventos {
  id bigint [pk, increment]
  entidade varchar(50) [not null, note: 'v_veiculo, i_vistoria, i_avaliacao, l_leilao, etc']
  entidade_id bigint [not null]
  acao varchar(50) [not null, note: 'create, update, conclude, lock, arrematacao, etc']
  descricao text [not null]
  dados_anteriores jsonb [note: 'NOVO: Snapshot do estado anterior']
  dados_novos jsonb [note: 'NOVO: Snapshot do estado novo']
  ip_origem varchar(45) [note: 'NOVO: IP de onde veio a ação']
  executado_por_id bigint [not null, ref: > a_usuarios.id]
  executado_em timestamp [not null, default: `now()`]

  Indexes {
    (entidade, entidade_id)
    executado_por_id
    executado_em
    acao
  }

  Note: '''
  Livro-razão do SIGEL - registra todas as ações críticas.
  CORRIGIDO: Adicionados campos para auditoria completa.
  Esta tabela NUNCA deve ter UPDATE ou DELETE.
  '''
}
```

---

## Ordem de Implementação

A implementação segue uma estratégia de **dependências mínimas**, onde cada etapa só depende das anteriores já implementadas.

### Fase 1: Fundação (Base do Sistema)

| Etapa | Tabelas | Dependências | Complexidade |
|-------|---------|--------------|--------------|
| 1.1 | `g_paises`, `g_estados`, `g_municipios`, `g_bairros` | Nenhuma | Baixa |
| 1.2 | `g_status_orgaos`, `g_orgaos` | 1.1 | Baixa |
| 1.3 | `a_status_usuarios`, `a_perfis` | Nenhuma | Baixa |
| 1.4 | `a_usuarios`, `a_usuarios_perfis` | 1.2, 1.3 | Média |

**Entregável:** Sistema de autenticação e gestão de usuários multi-órgão funcionando.

---

### Fase 2: Núcleo de Veículos

| Etapa | Tabelas | Dependências | Complexidade |
|-------|---------|--------------|--------------|
| 2.1 | `v_marcas`, `v_modelos` | Nenhuma | Baixa |
| 2.2 | `v_status_veiculos`, `v_tipos_veiculos` | Nenhuma | Baixa |
| 2.3 | `v_tipos_proprietarios`, `v_proprietarios` | 1.1 | Média |
| 2.4 | `v_veiculos` | 1.2, 2.1, 2.2, 2.3 | Alta |
| 2.5 | `v_fotos` | 2.4 | Baixa |
| 2.6 | `v_historico_proprietarios` | 2.3, 2.4 | Baixa |

**Entregável:** Cadastro completo de veículos com marcas/modelos normalizados, proprietários e fotos.

---

### Fase 3: Sistema de Inspeção

| Etapa | Tabelas | Dependências | Complexidade |
|-------|---------|--------------|--------------|
| 3.1 | `i_classificacoes_itens` | Nenhuma | Baixa |
| 3.2 | `i_etapas_checklist`, `i_itens_checklist` | 3.1 | Média |
| 3.3 | `i_tipos_vistorias`, `i_status_vistorias` | Nenhuma | Baixa |
| 3.4 | `i_vistorias`, `i_vistorias_itens` | 2.4, 3.2, 3.3, 1.4 | Alta |

**Entregável:** Sistema de checklist e vistorias funcionando.

---

### Fase 4: Avaliação e Valores

| Etapa | Tabelas | Dependências | Complexidade |
|-------|---------|--------------|--------------|
| 4.1 | `i_faixas_estado_conservacao`, `i_classificacoes_bens` | Nenhuma | Baixa |
| 4.2 | `i_modelos_avaliacao` | Nenhuma | Baixa |
| 4.3 | `i_valores_mercado` | 2.1 | Média |
| 4.4 | `i_avaliacoes` + Trigger de snapshot | 3.4, 4.1, 4.2, 4.3 | Alta |

**Entregável:** Sistema de avaliação com cálculo automático de valores.

---

### Fase 5: Gestão de Leilões

| Etapa | Tabelas | Dependências | Complexidade |
|-------|---------|--------------|--------------|
| 5.1 | `l_status_leiloes` | Nenhuma | Baixa |
| 5.2 | `l_leiloes` | 1.2, 5.1 | Média |
| 5.3 | `l_lotes` + Constraint de unicidade | 2.4, 5.2 | Alta |
| 5.4 | `l_publicacoes` | 5.2 | Baixa |

**Entregável:** Criação e gestão de leilões com controle de lotes.

---

### Fase 6: Resultados e Arrematação

| Etapa | Tabelas | Dependências | Complexidade |
|-------|---------|--------------|--------------|
| 6.1 | `r_status_lotes` | Nenhuma | Baixa |
| 6.2 | `r_arrematantes` | 1.1 | Média |
| 6.3 | `r_resultados_lotes` | 5.3, 6.1, 6.2 | Alta |

**Entregável:** Registro completo de resultados de leilão com arrematantes.

---

### Fase 7: Auditoria

| Etapa | Tabelas | Dependências | Complexidade |
|-------|---------|--------------|--------------|
| 7.1 | `h_eventos` | 1.4 | Média |
| 7.2 | Triggers de auditoria | Todas anteriores | Alta |

**Entregável:** Livro-razão completo de todas as ações do sistema.

---

## Próximo CRUD a Implementar

Considerando que **Veículos (2.4)** já foi implementado, o próximo CRUD na sequência é:

### Opção A: Seguir ordem natural
**`v_fotos` (2.5)** - Registro fotográfico dos veículos

### Opção B: Completar Fase 2
**`v_historico_proprietarios` (2.6)** - Histórico de propriedade

### Opção C: Iniciar Fase 3 (Inspeção)
**`i_classificacoes_itens` (3.1) + `i_etapas_checklist` + `i_itens_checklist` (3.2)** - Base do checklist

### Recomendação

Sugiro seguir com **Opção C (Checklist)** pois:
1. É a próxima dependência crítica para o fluxo principal do sistema
2. Permite que vistorias sejam implementadas em seguida
3. Fotos podem ser adicionadas a qualquer momento sem bloquear o fluxo

---

## Triggers e Constraints Necessários

### 1. Trigger: Atualizar snapshot do veículo após avaliação
```sql
CREATE OR REPLACE FUNCTION fn_atualizar_snapshot_veiculo()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE v_veiculos SET
    i_estado_conservacao_id = NEW.i_estado_conservacao_id,
    i_classificacao_bem_id = NEW.i_classificacao_bem_id,
    valor_avaliacao_atual = NEW.valor_mercado_base,
    valor_depreciado_atual = NEW.valor_depreciado,
    ultima_avaliacao_em = NEW.avaliado_em,
    updated_at = NOW()
  WHERE id = NEW.v_veiculo_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_snapshot_veiculo
AFTER INSERT ON i_avaliacoes
FOR EACH ROW EXECUTE FUNCTION fn_atualizar_snapshot_veiculo();
```

### 2. Trigger: Impedir veículo em múltiplos leilões ativos
```sql
CREATE OR REPLACE FUNCTION fn_verificar_veiculo_leilao_unico()
RETURNS TRIGGER AS $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM l_lotes l
  JOIN l_leiloes le ON le.id = l.l_leilao_id
  JOIN l_status_leiloes s ON s.id = le.l_status_leilao_id
  WHERE l.v_veiculo_id = NEW.v_veiculo_id
    AND l.deleted_at IS NULL
    AND s.codigo NOT IN ('FINALIZADO', 'CANCELADO')
    AND l.id != COALESCE(NEW.id, 0);

  IF v_count > 0 THEN
    RAISE EXCEPTION 'Veículo já está em um leilão ativo';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_veiculo_leilao_unico
BEFORE INSERT OR UPDATE ON l_lotes
FOR EACH ROW EXECUTE FUNCTION fn_verificar_veiculo_leilao_unico();
```

### 3. Trigger: Registrar eventos de auditoria
```sql
CREATE OR REPLACE FUNCTION fn_registrar_evento()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO h_eventos (
    entidade, entidade_id, acao, descricao,
    dados_anteriores, dados_novos,
    executado_por_id, executado_em
  ) VALUES (
    TG_TABLE_NAME,
    COALESCE(NEW.id, OLD.id),
    TG_OP,
    TG_OP || ' em ' || TG_TABLE_NAME,
    CASE WHEN TG_OP IN ('UPDATE', 'DELETE') THEN row_to_json(OLD) ELSE NULL END,
    CASE WHEN TG_OP IN ('INSERT', 'UPDATE') THEN row_to_json(NEW) ELSE NULL END,
    COALESCE(NEW.updated_by, NEW.created_by, OLD.updated_by, OLD.created_by),
    NOW()
  );
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;
```

---

## Convenções do Projeto

| Item | Convenção |
|------|-----------|
| Nomenclatura de tabelas | `prefixo_nome_plural` (ex: `v_veiculos`) |
| Chave primária | `id bigint auto-increment` |
| Chave estrangeira | `tabela_referenciada_id` (ex: `g_orgao_id`) |
| Soft delete | `deleted_at timestamp null` |
| Auditoria básica | `created_by`, `updated_by`, `created_at`, `updated_at` |
| Status | Tabela separada com `codigo` único |
| Código de status | UPPER_SNAKE_CASE (ex: `PENDENTE`, `EM_ANALISE`) |
