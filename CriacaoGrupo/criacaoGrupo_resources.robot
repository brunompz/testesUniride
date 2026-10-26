*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${Browser}              Google Chrome
${URL}                  http://localhost/Uniride/home/index.html
${LOGIN_SUCESSO}        id:boasVindas
${CAMPO_USUARIO}        email
${CAMPO_SENHA}          senha
${USUARIO_MOTORISTA}    motorista.teste@pucpr.edu.br
${SENHA_PADRAO}         1234
${BOTAO_LOGIN}          id:enviar
${BOTAO_TELA_LOGIN}     xpath://a[contains(text(), 'LOGIN')]
${BOTAO_NOVA_VIAGEM}    id:novaViagem
${ICONE_ERRO}           css=.swal2-icon.swal2-error.swal2-icon-show
${ICONE_SUCESSO}        css=.swal2-icon.swal2-success.swal2-icon-show

${CAMPO_TITULO}         id:titulo
${CAMPO_DESCRICAO}      id:descricao
${CAMPO_PARTIDA}        id:pontoPartida
${CAMPO_CHEGADA}        id:pontoChegada
${SELECT_RECORRENCIA}   id:tipoRecorrencia
${CAMPO_DATA_HORA}      id:dataHora
${CHECKBOX_SEGUNDA}     xpath://input[@name='dias[]' and @value='1']
${CHECKBOX_QUARTA}      xpath://input[@name='dias[]' and @value='3']
${CAMPO_HORA}           id:hora
${CAMPO_DATA_INICIO}    id:data_inicio
${SELECT_TIPO_CARONA}   id:tipoCarona
${SELECT_VEICULO}       id:veiculo_id
${CAMPO_CAPACIDADE}     id:capacidade
${CAMPO_PRECO}          id:preco
${BOTAO_CADASTRAR}      id:enviar
${ERRO_DATA_HORA}       id:erroDataHora

${TITULO_OFERTA}        Carona Recorrente Engenharia
${DESCRICAO_OFERTA}     Carona diaria ida e volta para a universidade
${PARTIDA_PADRAO}       Rua XV de Novembro, Centro
${CHEGADA_PADRAO}       PUCPR Campus Curitiba
${HORA_PADRAO}          07:30
${DATA_INICIO_FUTURA}   2026-11-20
${CAPACIDADE_PADRAO}    3
${PRECO_PADRAO}         10.00

${TITULO_SOLICITACAO}   Preciso de Carona para Prova
${DESCRICAO_SOLICITACAO}  Ida para a faculdade no dia da avaliacao
${DATA_HORA_FUTURA}     2026-11-25T18:00
${DATA_HORA_PASSADA}    2020-01-01T08:00

*** Keywords ***
Abrir o navegador
    Open Browser  ${URL}  ${Browser}
    Set Screenshot Directory    ${CURDIR}/Outputs/${TEST NAME}
    Maximize Browser Window

Fechar o navegador
    Close Browser

Acessar area de login
    Wait Until Page Contains Element  ${BOTAO_TELA_LOGIN}  timeout=10s
    Click Element  ${BOTAO_TELA_LOGIN}

Digitar no campo usuario o motorista ativo
    Wait Until Page Contains Element  ${CAMPO_USUARIO}  timeout=10s
    Input Text  ${CAMPO_USUARIO}  ${USUARIO_MOTORISTA}

Digitar no campo senha a senha padrao
    Input Text  ${CAMPO_SENHA}  ${SENHA_PADRAO}

Acionar o botao de login
    Click Element  ${BOTAO_LOGIN}

Verificar sessao
    Wait Until Page Contains Element  ${LOGIN_SUCESSO}  timeout=10s

Acionar botao de adicionar grupo de viagem
    Wait Until Element Is Visible    ${BOTAO_NOVA_VIAGEM}    timeout=10s
    Click Element                    ${BOTAO_NOVA_VIAGEM}
    Wait Until Element Is Visible    ${CAMPO_TITULO}         timeout=10s

Preencher dados basicos da viagem titulo= "${titulo}", descricao= "${descricao}", partida= "${partida}" e chegada= "${chegada}"
    Input Text  ${CAMPO_TITULO}     ${titulo}
    Input Text  ${CAMPO_DESCRICAO}  ${descricao}
    Input Text  ${CAMPO_PARTIDA}    ${partida}
    Input Text  ${CAMPO_CHEGADA}    ${chegada}

Selecionar tipo de recorrencia como recorrente
    Select From List By Value  ${SELECT_RECORRENCIA}  recorrente
    Wait Until Element Is Visible  ${CAMPO_DATA_INICIO}  timeout=5s

Selecionar tipo de recorrencia como avulsa
    Select From List By Value  ${SELECT_RECORRENCIA}  avulsa
    Wait Until Element Is Visible  ${CAMPO_DATA_HORA}  timeout=5s

Selecionar dias da semana segunda e quarta
    Select Checkbox  ${CHECKBOX_SEGUNDA}
    Select Checkbox  ${CHECKBOX_QUARTA}

Preencher horario da viagem recorrente
    Input Text  ${CAMPO_HORA}  ${HORA_PADRAO}

Preencher data de inicio futura da viagem recorrente
    Execute Javascript  document.getElementById('data_inicio').value = '${DATA_INICIO_FUTURA}';

Preencher data e hora futura da carona avulsa
    Execute Javascript  document.getElementById('dataHora').value = '${DATA_HORA_FUTURA}';

Preencher data e hora no passado da carona avulsa
    Execute Javascript  document.getElementById('dataHora').value = '${DATA_HORA_PASSADA}';

Selecionar tipo de carona como motorista oferta
    Wait Until Element Is Visible  ${SELECT_TIPO_CARONA}  timeout=5s
    Select From List By Value      ${SELECT_TIPO_CARONA}  motorista
    Wait Until Element Is Visible  ${SELECT_VEICULO}      timeout=5s

Selecionar veiculo cadastrado
    Wait Until Element Is Visible  ${SELECT_VEICULO}  timeout=5s
    Select From List By Index      ${SELECT_VEICULO}  1

Preencher capacidade e preco da oferta
    Input Text  ${CAMPO_CAPACIDADE}  ${CAPACIDADE_PADRAO}
    Input Text  ${CAMPO_PRECO}       ${PRECO_PADRAO}

Acionar botao de cadastrar grupo de viagem
    Click Element  ${BOTAO_CADASTRAR}

Verificar mensagem de sucesso do grupo de viagem
    Wait Until Page Contains Element  ${ICONE_SUCESSO}  timeout=10s
    Capture Page Screenshot

Verificar erro de data e hora anterior a atual
    Wait Until Element Is Visible  ${ERRO_DATA_HORA}  timeout=5s
    Element Should Not Be Visible  ${ICONE_SUCESSO}
    Capture Page Screenshot
