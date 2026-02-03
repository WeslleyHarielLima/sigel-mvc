# SIGEL - Etapa 01: Autenticação e CRUD de Veículos

**Data:** 03/02/2026
**Versão:** 1.0

---

## Objetivo

Implementar o sistema de autenticação de usuários e o CRUD completo de veículos e tipos de veículos.

---

## Tecnologias Utilizadas

| Tecnologia | Versão | Finalidade |
|------------|--------|------------|
| Ruby on Rails | 8.1.2 | Framework MVC |
| PostgreSQL | - | Banco de dados |
| Devise | 4.9 | Autenticação |
| Bootstrap | 5.3 (CDN) | Framework CSS |
| Simple Form | 5.3 | Formulários |
| Pagy | 6.0 | Paginação |
| Ransack | 4.0 | Busca e filtros |
| Discard | 1.3 | Soft delete |

---

## Estrutura do Banco de Dados

### Tabela: users
```
- id (integer, PK)
- email (string, unique, not null)
- encrypted_password (string, not null)
- reset_password_token (string)
- reset_password_sent_at (datetime)
- remember_created_at (datetime)
- sign_in_count (integer)
- current_sign_in_at (datetime)
- last_sign_in_at (datetime)
- current_sign_in_ip (string)
- last_sign_in_ip (string)
- nome (string, not null)
- cpf (string, unique, not null)
- role (string, default: 'user')
- created_at (datetime)
- updated_at (datetime)
```

### Tabela: g_tipos_veiculos
```
- id (integer, PK)
- descricao (string, not null)
- discarded_at (datetime) - soft delete
- created_at (datetime)
- updated_at (datetime)
```

### Tabela: g_veiculos
```
- id (integer, PK)
- numero_interno (string)
- placa (string)
- chassi (string)
- renavam (string)
- marca (string)
- modelo (string)
- ano (integer)
- cor (string)
- motor (string)
- tombamento (string)
- apto (boolean, default: false)
- status (string, default: 'pendente')
- g_tipo_veiculo_id (integer, FK)
- discarded_at (datetime) - soft delete
- created_at (datetime)
- updated_at (datetime)
```

---

## Arquivos Criados/Modificados

### Models
| Arquivo | Descrição |
|---------|-----------|
| `app/models/user.rb` | Model de usuário com Devise e validações |
| `app/models/g_tipo_veiculo.rb` | Model de tipos de veículos com soft delete |
| `app/models/g_veiculo.rb` | Model de veículos com associações e scopes |

### Controllers
| Arquivo | Descrição |
|---------|-----------|
| `app/controllers/application_controller.rb` | Controller base com autenticação |
| `app/controllers/g_tipos_veiculos_controller.rb` | CRUD de tipos de veículos |
| `app/controllers/g_veiculos_controller.rb` | CRUD de veículos com filtros |

### Views
| Diretório | Descrição |
|-----------|-----------|
| `app/views/layouts/application.html.erb` | Layout principal com Bootstrap |
| `app/views/shared/_navbar.html.erb` | Barra de navegação |
| `app/views/shared/_flash.html.erb` | Mensagens flash |
| `app/views/g_tipos_veiculos/` | Views de tipos de veículos |
| `app/views/g_veiculos/` | Views de veículos |
| `app/views/devise/` | Views de autenticação customizadas |

### Configurações
| Arquivo | Descrição |
|---------|-----------|
| `config/routes.rb` | Rotas da aplicação |
| `config/initializers/devise.rb` | Configuração do Devise |
| `config/initializers/pagy.rb` | Configuração da paginação |

### Migrations
| Arquivo | Descrição |
|---------|-----------|
| `db/migrate/*_devise_create_users.rb` | Criação da tabela users |
| `db/migrate/*_create_g_tipos_veiculos.rb` | Criação da tabela g_tipos_veiculos |
| `db/migrate/*_create_g_veiculos.rb` | Criação da tabela g_veiculos |

---

## Rotas Implementadas

### Autenticação (Devise)
```
GET    /users/sign_in          -> Login
POST   /users/sign_in          -> Processar login
DELETE /users/sign_out         -> Logout
GET    /users/sign_up          -> Registro
POST   /users                  -> Criar conta
GET    /users/edit             -> Editar conta
GET    /users/password/new     -> Recuperar senha
```

### Tipos de Veículos
```
GET    /g_tipos_veiculos       -> Listar tipos
GET    /g_tipos_veiculos/new   -> Formulário novo tipo
POST   /g_tipos_veiculos       -> Criar tipo
GET    /g_tipos_veiculos/:id   -> Visualizar tipo
GET    /g_tipos_veiculos/:id/edit -> Editar tipo
PATCH  /g_tipos_veiculos/:id   -> Atualizar tipo
DELETE /g_tipos_veiculos/:id   -> Excluir tipo (soft delete)
```

### Veículos
```
GET    /g_veiculos             -> Listar veículos (com filtros)
GET    /g_veiculos/new         -> Formulário novo veículo
POST   /g_veiculos             -> Criar veículo
GET    /g_veiculos/:id         -> Visualizar veículo
GET    /g_veiculos/:id/edit    -> Editar veículo
PATCH  /g_veiculos/:id         -> Atualizar veículo
DELETE /g_veiculos/:id         -> Excluir veículo (soft delete)
```

---

## Funcionalidades Implementadas

### Autenticação
- [x] Login com email e senha
- [x] Registro de novos usuários (nome, CPF, email, senha)
- [x] Logout
- [x] Recuperação de senha
- [x] Edição de conta
- [x] Proteção de rotas (requer autenticação)
- [x] Rastreamento de login (trackable)

### Tipos de Veículos
- [x] Listagem com paginação
- [x] Criação de novos tipos
- [x] Edição de tipos existentes
- [x] Visualização de detalhes
- [x] Exclusão com soft delete
- [x] Validação de descrição única

### Veículos
- [x] Listagem com paginação
- [x] Filtros por: placa, marca, modelo, status, tipo, apto
- [x] Criação de novos veículos
- [x] Edição de veículos existentes
- [x] Visualização de detalhes completos
- [x] Exclusão com soft delete
- [x] Status: Pendente, Verificado/Apto, Em Leilão, Arrematado, Impedido

---

## Status de Veículos

| Status | Descrição |
|--------|-----------|
| `pendente` | Veículo aguardando verificação |
| `verificado_apto` | Veículo verificado e apto para leilão |
| `em_leilao` | Veículo atualmente em processo de leilão |
| `arrematado` | Veículo já foi arrematado em leilão |
| `impedido` | Veículo com impedimento legal ou técnico |

---

## Dados de Seed

### Usuário Administrador
```
Email: admin@sigel.com
Senha: password123
Role: admin
```

### Tipos de Veículos Criados
- Automóvel
- Motocicleta
- Caminhão
- Ônibus
- Van
- Utilitário
- Reboque
- Trator

### Veículos de Exemplo
- Volkswagen Gol (ABC1234) - Pendente
- Fiat Uno (DEF5678) - Verificado/Apto
- Honda CG 160 (GHI9012) - Em Leilão
- Yamaha Factor 150 (JKL3456) - Arrematado
- Chevrolet Onix (MNO7890) - Impedido
- Mercedes-Benz Atego 1719 (PQR1234) - Pendente

---

## Como Executar

```bash
# Instalar dependências
bundle install

# Criar banco de dados
rails db:create

# Executar migrations
rails db:migrate

# Popular banco com dados iniciais
rails db:seed

# Iniciar servidor
rails server
```

Acessar: `http://localhost:3000`

---

## Próximas Etapas

- [ ] Implementar CRUD de Leilões (GLeilao)
- [ ] Implementar associação Leilão-Veículo (GLeilaoVeiculo)
- [ ] Implementar sistema de autorização (Pundit)
- [ ] Adicionar upload de fotos dos veículos
- [ ] Implementar relatórios

---

## Observações Técnicas

1. **Bootstrap via CDN**: O Bootstrap 5.3 é carregado via CDN no layout principal para evitar conflitos com o Propshaft (asset pipeline do Rails 8).

2. **Soft Delete**: Utiliza a gem `discard` em vez de `paranoia` (incompatível com Rails 8). Os registros excluídos são marcados com `discarded_at` e filtrados automaticamente via `default_scope`.

3. **Paginação**: Configurada para 10 itens por página com tratamento de overflow.

4. **Filtros**: Implementados com Ransack, permitindo busca combinada por múltiplos campos.
