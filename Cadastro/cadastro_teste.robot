*** Settings ***
Documentation    Suite que testa o cadastro de usuario do UniRide (funcionalidade e validacoes)
Resource         cadastro_resources.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador

*** Test Cases ***
CT1 - Realizar cadastro de usuario com valores validos
    [Documentation]    Verifica se o sistema permite o cadastro de um passageiro com dados validos
    [Tags]    cadastro_valido
    ${email}=    Gerar email institucional unico
    Acessar area de cadastro
    Preencher formulario de cadastro    ${email}
    Acionar o botao de cadastrar
    Verificar cadastro realizado com sucesso

CT2 - Realizar cadastro de usuario com campos obrigatorios vazios
    [Documentation]    Verifica se o sistema exibe os erros de validacao ao cadastrar sem preencher nada
    [Tags]    cadastro_campos_vazios
    Acessar area de cadastro
    Acionar o botao de cadastrar
    Verificar mensagens de campos obrigatorios

CT3 - Realizar cadastro de usuario com email nao institucional
    [Documentation]    Verifica se o sistema rejeita emails que nao terminam em .edu.br
    [Tags]    cadastro_email_nao_institucional
    Acessar area de cadastro
    Preencher formulario de cadastro    ${EMAIL_NAO_INSTITUCIONAL}
    Acionar o botao de cadastrar
    Verificar aviso de cadastro rejeitado

CT4 - Realizar cadastro de usuario com email ja cadastrado
    [Documentation]    Verifica se o sistema impede o cadastro de um email que ja existe na base
    [Tags]    cadastro_email_duplicado
    Acessar area de cadastro
    Preencher formulario de cadastro    ${EMAIL_JA_CADASTRADO}
    Acionar o botao de cadastrar
    Verificar aviso de cadastro rejeitado

CT5 - Realizar cadastro de usuario menor de 18 anos
    [Documentation]    Verifica se o sistema rejeita o cadastro de usuario com menos de 18 anos
    [Tags]    cadastro_menor_idade
    ${nascimento}=    Calcular data de nascimento de menor de idade
    ${email}=    Gerar email institucional unico
    Acessar area de cadastro
    Preencher formulario de cadastro    ${email}    ${nascimento}
    Acionar o botao de cadastrar
    Verificar erro de menor de idade
