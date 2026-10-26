*** Settings ***
Documentation  Essa suite testa a criacao de grupos de carona no Uniride
Resource  criacaoGrupo_resources.robot
Test Setup  Abrir o navegador
Test Teardown  Fechar o navegador

*** Test Cases ***
CT1- Criar grupo de oferta de carona recorrente valido
    [Documentation]  Esse teste busca verificar se o motorista consegue criar um grupo de oferta de carona recorrente com valores validos
    [Tags]  oferta_recorrente_valida
    Acessar area de login
    Digitar no campo usuario o motorista ativo
    Digitar no campo senha a senha padrao
    Acionar o botao de login
    Verificar sessao
    Acionar botao de adicionar grupo de viagem
    Preencher dados basicos da viagem titulo= "${TITULO_OFERTA}", descricao= "${DESCRICAO_OFERTA}", partida= "${PARTIDA_PADRAO}" e chegada= "${CHEGADA_PADRAO}"
    Selecionar tipo de recorrencia como recorrente
    Selecionar dias da semana segunda e quarta
    Preencher horario da viagem recorrente
    Preencher data de inicio futura da viagem recorrente
    Selecionar tipo de carona como motorista oferta
    Selecionar veiculo cadastrado
    Preencher capacidade e preco da oferta
    Acionar botao de cadastrar grupo de viagem
    Verificar mensagem de sucesso do grupo de viagem

CT2- Criar grupo de solicitacao de carona unica valido
    [Documentation]  Esse teste busca verificar se o usuario consegue criar um grupo de solicitacao de carona unica (avulsa) com valores validos
    [Tags]  solicitacao_unica_valida
    Acessar area de login
    Digitar no campo usuario o motorista ativo
    Digitar no campo senha a senha padrao
    Acionar o botao de login
    Verificar sessao
    Acionar botao de adicionar grupo de viagem
    Preencher dados basicos da viagem titulo= "${TITULO_SOLICITACAO}", descricao= "${DESCRICAO_SOLICITACAO}", partida= "${PARTIDA_PADRAO}" e chegada= "${CHEGADA_PADRAO}"
    Selecionar tipo de recorrencia como avulsa
    Preencher data e hora futura da carona avulsa
    Acionar botao de cadastrar grupo de viagem
    Verificar mensagem de sucesso do grupo de viagem

CT3- Criar grupo de solicitacao com data menor que data atual
    [Documentation]  Esse teste busca verificar se o sistema rejeita a criacao de um grupo avulso com data e hora anterior ao momento atual
    [Tags]  data_menor_que_atual
    Acessar area de login
    Digitar no campo usuario o motorista ativo
    Digitar no campo senha a senha padrao
    Acionar o botao de login
    Verificar sessao
    Acionar botao de adicionar grupo de viagem
    Preencher dados basicos da viagem titulo= "${TITULO_SOLICITACAO}", descricao= "${DESCRICAO_SOLICITACAO}", partida= "${PARTIDA_PADRAO}" e chegada= "${CHEGADA_PADRAO}"
    Selecionar tipo de recorrencia como avulsa
    Preencher data e hora no passado da carona avulsa
    Acionar botao de cadastrar grupo de viagem
    Verificar erro de data e hora anterior a atual
