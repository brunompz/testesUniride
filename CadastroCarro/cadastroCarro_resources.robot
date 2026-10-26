*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${Browser}  Google Chrome
${URL}  http://localhost/Uniride/home/index.html
${LOGIN_SUCESSO}  id:boasVindas
${CAMPO_USUARIO}  email
${CAMPO_SENHA}  senha
${USUARIO_ATIVO}  bruno.parizotto@pucpr.edu.br 
${SENHA_ATIVA}  1234
${BOTAO_LOGIN}  id:enviar
${BOTAO_TELA_LOGIN}  xpath://a[contains(text(), 'LOGIN')]
${BOTAO_PERFIL}  id:navPerfilFoto
${BOTAO_CARRO}  id:novoCarro
${ICONE_ERRO}       css=.swal2-icon.swal2-error.swal2-icon-show
${ICONE_SUCESSO}    css=.swal2-icon.swal2-success.swal2-icon-show
${CADASTRAR_VEICULO}  id:enviar
${CAMPO_PLACA}  placa
${CAMPO_MARCA}  marca
${CAMPO_MODELO}  modelo
${CAMPO_ANO}  ano
${CAMPO_COR}  cor
${CAMPO_RENAVAM}  renavam
${CAMPO_CATEGORIA}  categoria
${CAMPO_CAPACIDADE}  capacidade
${PLACA_VALIDA}  IVY98F2
${MARCA_VALIDA}  Renault
${MODELO_VALIDA}  Uno
${ANO_VALIDA}  2010
${COR_VALIDA}  Azul
${RENAVAM_VALIDA}  123456789
${CATEGORIA_VALIDA}  SUV
${CAPACIDADE_COMUM}  5
${CAPACIDADE_NEGATIVA}  -1
${CAPACIDADE_LIMITE}  100
${RENAVAM_INVALIDO}  123
${ERRO_PLACA}         id=erroPlaca
${ERRO_MARCA}         id=erroMarca
${ERRO_MODELO}        id=erroModelo
${ERRO_ANO}           id=erroAno
${ERRO_COR}           id=erroCor
${ERRO_RENAVAM}       id=erroRenavam
${ERRO_CAPACIDADE}    id=erroCapacidade
${ERRO_CATEGORIA}     id=erroCategoria
    
*** Keywords ***
Abrir o navegador
    Open Browser  ${URL}  ${Browser}
    Set Screenshot Directory    ${CURDIR}/Outputs/${TEST NAME}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar area de login
    Wait Until Page Contains Element  ${BOTAO_TELA_LOGIN}  timeout=10s
    Click Element  ${BOTAO_TELA_LOGIN}

Digitar no campo usuario o usuario ativo
    Wait Until Page Contains Element  ${CAMPO_USUARIO}  timeout=10s
    Input Text  ${CAMPO_USUARIO}  ${USUARIO_ATIVO}

Digitar no campo senha a senha do usuario ativo
    Input Text  ${CAMPO_SENHA}  ${SENHA_ATIVA}

Acionar o botao de login
    Click Element  ${BOTAO_LOGIN}

Acessar area de perfil
    Wait Until Element Is Visible    ${BOTAO_PERFIL}    timeout=10s
    Wait Until Element Is Enabled    ${BOTAO_PERFIL}    timeout=10s
    Scroll Element Into View         ${BOTAO_PERFIL}
    Click Element                    ${BOTAO_PERFIL}
    Wait Until Element Is Visible    ${BOTAO_CARRO}     timeout=10s


Acionar botao de adicionar novo veiculo na secao Carros Cadastrados
    Scroll Element Into View         ${BOTAO_CARRO}
    Wait Until Element Is Enabled    ${BOTAO_CARRO}     timeout=10s
    Click Element                    ${BOTAO_CARRO}
    Wait Until Element Is Visible    ${CAMPO_PLACA}     timeout=10s

Preencher campos do cadastro de carro placa= IVY98F2, marca= Renault, modelo= Uno, ano= 2010, cor= Azul, renavam= 123456789, capacidade=5 e categoria= SUV
    Input Text  ${CAMPO_PLACA}  ${PLACA_VALIDA}
    Input Text  ${CAMPO_MARCA}  ${MARCA_VALIDA}
    Input Text  ${CAMPO_MODELO}  ${MODELO_VALIDA}
    Input Text  ${CAMPO_ANO}  ${ANO_VALIDA}
    Input Text  ${CAMPO_COR}  ${COR_VALIDA}
    Input Text  ${CAMPO_RENAVAM}  ${RENAVAM_VALIDA}
    Input Text  ${CAMPO_CATEGORIA}  ${CATEGORIA_VALIDA}
    Input Text  ${CAMPO_CAPACIDADE}  ${CAPACIDADE_COMUM}

Preencher campos do cadastro de carro placa= IVY98F2, marca= Renault, modelo= Uno, ano= 2010, cor= Azul, renavam= 123456789 e categoria= SUV
    Input Text  ${CAMPO_PLACA}  ${PLACA_VALIDA}
    Input Text  ${CAMPO_MARCA}  ${MARCA_VALIDA}
    Input Text  ${CAMPO_MODELO}  ${MODELO_VALIDA}
    Input Text  ${CAMPO_ANO}  ${ANO_VALIDA}
    Input Text  ${CAMPO_COR}  ${COR_VALIDA}
    Input Text  ${CAMPO_RENAVAM}  ${RENAVAM_VALIDA}
    Input Text  ${CAMPO_CATEGORIA}  ${CATEGORIA_VALIDA}

Preencher campos do cadastro de carro placa= IVY98F2, marca= Renault, modelo= Uno, ano= 2010, cor= Azul, capacidade=5 e categoria= SUV
    Input Text  ${CAMPO_PLACA}  ${PLACA_VALIDA}
    Input Text  ${CAMPO_MARCA}  ${MARCA_VALIDA}
    Input Text  ${CAMPO_MODELO}  ${MODELO_VALIDA}
    Input Text  ${CAMPO_ANO}  ${ANO_VALIDA}
    Input Text  ${CAMPO_COR}  ${COR_VALIDA}
    Input Text  ${CAMPO_CATEGORIA}  ${CATEGORIA_VALIDA}
    Input Text  ${CAMPO_CAPACIDADE}  ${CAPACIDADE_COMUM}

Preencher campo capacidade de passageiros -1
    Input Text  ${CAMPO_CAPACIDADE}  ${CAPACIDADE_NEGATIVA}
    Capture Page Screenshot

Preencher campo capacidade de passageiros 100
    Input Text  ${CAMPO_CAPACIDADE}  ${CAPACIDADE_LIMITE}

Acionar botao de cadastrar veiculo
    Click Element  ${CADASTRAR_VEICULO}

Verificar sessao
    Wait Until Page Contains Element  ${LOGIN_SUCESSO}  timeout=10s

Verificar mensagem do cadastro de carro
    Wait Until Page Contains Element  ${ICONE_SUCESSO}  timeout=10s
    Capture Page Screenshot

Preencher campo RENAVAM 123
    Input Text  ${CAMPO_RENAVAM}  ${RENAVAM_INVALIDO}

Verificar que o cadastro foi rejeitado
    Wait Until Element Is Visible    ${ICONE_ERRO}    timeout=3s
    Element Should Not Be Visible    ${ICONE_SUCESSO}
    Capture Page Screenshot

Verificar mensagens de erro
    Element Should Be Visible    ${ERRO_PLACA}
    Element Should Be Visible    ${ERRO_MARCA}
    Element Should Be Visible    ${ERRO_MODELO}
    Element Should Be Visible    ${ERRO_ANO}
    Element Should Be Visible    ${ERRO_COR}
    Element Should Be Visible    ${ERRO_RENAVAM}
    Element Should Be Visible    ${ERRO_CAPACIDADE}
    Element Should Be Visible    ${ERRO_CATEGORIA}
    Capture Page Screenshot