*** Settings ***
Library    SeleniumLibrary
Library    DateTime

*** Variables ***
${BROWSER}                chrome
${URL}                    http://localhost/Uniride/home/index.html
${BOTAO_TELA_CADASTRO}    xpath://a[contains(text(), 'CADASTRO')]
${CAMPO_NOME}             nome
${CAMPO_EMAIL}            email
${CAMPO_SENHA}            senha
${CAMPO_NASCIMENTO}       nascimento
${BOTAO_CADASTRAR}        id:enviar
${ICONE_SUCESSO}          css:.swal2-icon.swal2-success.swal2-icon-show
${ICONE_ERRO}             css:.swal2-icon.swal2-error.swal2-icon-show
${ICONE_AVISO}            css:.swal2-icon.swal2-warning.swal2-icon-show
${ERRO_NOME}              id:erroNome
${ERRO_EMAIL}             id:erroEmail
${ERRO_SENHA}             id:erroSenha
${ERRO_NASCIMENTO}        id:erroNascimento

${NOME_VALIDO}            Guilherme Teste
${EMAIL_BASE}             guilherme.teste
${DOMINIO_VALIDO}         @pucpr.edu.br
${EMAIL_NAO_INSTITUCIONAL}    guilherme.teste@gmail.com
${EMAIL_JA_CADASTRADO}    luana.mendes1@pucpr.edu.br
${SENHA_VALIDA}           1234
${NASCIMENTO_MAIOR}       2000-01-15
${MSG_MENOR_IDADE}        *Você precisa ter pelo menos 18 anos para se cadastrar.

*** Keywords ***
Abrir o navegador
    Open Browser    ${URL}    ${BROWSER}
    Set Screenshot Directory    ${CURDIR}/Outputs/${TEST NAME}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar area de cadastro
    Wait Until Page Contains Element    ${BOTAO_TELA_CADASTRO}    timeout=10s
    Click Element    ${BOTAO_TELA_CADASTRO}
    Wait Until Page Contains Element    ${CAMPO_NOME}    timeout=10s

Gerar email institucional unico
    ${agora}=    Get Current Date    result_format=%Y%m%d%H%M%S
    RETURN    ${EMAIL_BASE}${agora}${DOMINIO_VALIDO}

Preencher data de nascimento
    [Arguments]    ${data}
    Execute Javascript    document.getElementById('${CAMPO_NASCIMENTO}').value = '${data}'

Preencher formulario de cadastro
    [Arguments]    ${email}    ${nascimento}=${NASCIMENTO_MAIOR}
    Input Text    ${CAMPO_NOME}    ${NOME_VALIDO}
    Input Text    ${CAMPO_EMAIL}    ${email}
    Input Text    ${CAMPO_SENHA}    ${SENHA_VALIDA}
    Preencher data de nascimento    ${nascimento}

Calcular data de nascimento de menor de idade
    ${data}=    Get Current Date    increment=-3650 days    result_format=%Y-%m-%d
    RETURN    ${data}

Acionar o botao de cadastrar
    Click Element    ${BOTAO_CADASTRAR}

Verificar cadastro realizado com sucesso
    Wait Until Element Is Visible    ${ICONE_SUCESSO}    timeout=10s
    Capture Page Screenshot

Verificar mensagens de campos obrigatorios
    Element Should Be Visible    ${ERRO_NOME}
    Element Should Be Visible    ${ERRO_EMAIL}
    Element Should Be Visible    ${ERRO_SENHA}
    Element Should Be Visible    ${ERRO_NASCIMENTO}
    Element Should Not Be Visible    ${ICONE_SUCESSO}
    Capture Page Screenshot

Verificar aviso de cadastro rejeitado
    Wait Until Element Is Visible    ${ICONE_AVISO}    timeout=10s
    Element Should Not Be Visible    ${ICONE_SUCESSO}
    Capture Page Screenshot

Verificar erro de menor de idade
    Wait Until Element Is Visible    ${ERRO_NASCIMENTO}    timeout=5s
    Element Text Should Be    ${ERRO_NASCIMENTO}    ${MSG_MENOR_IDADE}
    Element Should Not Be Visible    ${ICONE_SUCESSO}
    Capture Page Screenshot
