# testesUniride 

Case Tests com Robot Framework no projeto acadêmico Uniride
---

## Resumo dos Testes Implementados

Atualmente, o projeto conta com **15 casos de teste automatizados**, divididos em 4 suítes funcionais:

| Módulo / Suíte | ID | Caso de Teste |
| :--- | :--- | :--- |
| **Login** | CT1 | Realizar login com senha incorreta |
| **Login** | CT2 | Realizar login com email não cadastrado |
| **Login** | CT3 | Realizar login com campos vazios |
| **Login** | CT4 | Realizar login com injeção de SQL no campo email |
| **Login** | CT5 | Bloquear acesso após 5 tentativas consecutivas com senha incorreta |

| **Cadastro de Carro** | CT1 | Realizar cadastro de carro com valores válidos |
| **Cadastro de Carro** | CT2 | Realizar cadastro de carro com campo de capacidade de passageiro -1 |
| **Cadastro de Carro** | CT3 | Realizar cadastro de carro com campo de capacidade de passageiro 100 |
| **Cadastro de Carro** | CT4 | Realizar cadastro de carro com campo de RENAVAM inválido |
| **Cadastro de Carro** | CT5 | Realizar cadastro de carro com campos obrigatórios vazios |

| **Criação de Grupo** | CT1 | Criar grupo de oferta de carona recorrente válido |
| **Criação de Grupo** | CT2 | Criar grupo de solicitação de carona única válido |
| **Criação de Grupo** | CT3 | Criar grupo de solicitação com data menor que data atual |

| **Tela Inicial** | CT1 | Visualizar grupo criado por outra conta na aba inicial |
| **Tela Inicial** | CT2 | Filtrar grupos de carona exclusivamente por solicitação |
