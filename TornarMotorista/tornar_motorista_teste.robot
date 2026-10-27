*** Settings ***
Documentation    Suite que testa o cadastro de motorista (CPF e CNH) do UniRide (funcionalidade e validacoes)
Resource         tornar_motorista_resources.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador

*** Test Cases ***
CT1 - Realizar cadastro de motorista com campos obrigatorios vazios
    [Documentation]    Verifica se o sistema exibe os erros de validacao ao cadastrar sem preencher nada
    [Tags]    motorista_campos_vazios
    Realizar login
    Acessar area de tornar motorista
    Acionar o botao de cadastrar
    Verificar mensagens de campos obrigatorios

CT2 - Realizar cadastro de motorista com CPF menor que 11 digitos
    [Documentation]    Verifica se o sistema rejeita um CPF com menos de 11 digitos
    [Tags]    motorista_cpf_curto
    ${vencimento}=    Calcular data de vencimento futura
    Realizar login
    Acessar area de tornar motorista
    Preencher formulario de motorista    ${CPF_CURTO}    ${vencimento}    ${REGISTRO_VALIDO}
    Acionar o botao de cadastrar
    Verificar erro de CPF invalido

CT3 - Realizar cadastro de motorista com CPF de digito verificador invalido
    [Documentation]    Verifica se o sistema rejeita um CPF com 11 digitos mas digito verificador incorreto
    [Tags]    motorista_cpf_digito_invalido
    ${vencimento}=    Calcular data de vencimento futura
    Realizar login
    Acessar area de tornar motorista
    Preencher formulario de motorista    ${CPF_DV_INVALIDO}    ${vencimento}    ${REGISTRO_VALIDO}
    Acionar o botao de cadastrar
    Verificar erro de CPF invalido

CT4 - Realizar cadastro de motorista com CNH vencida
    [Documentation]    Verifica se o sistema rejeita uma CNH com data de vencimento anterior a hoje
    [Tags]    motorista_cnh_vencida
    ${vencimento}=    Calcular data de vencimento vencida
    Realizar login
    Acessar area de tornar motorista
    Preencher formulario de motorista    ${CPF_VALIDO}    ${vencimento}    ${REGISTRO_VALIDO}
    Acionar o botao de cadastrar
    Verificar erro de CNH vencida

CT5 - Realizar cadastro de motorista com valores validos
    [Documentation]    Verifica se o sistema permite que um usuario se torne motorista com CPF e CNH validos
    [Tags]    motorista_valido
    ${vencimento}=    Calcular data de vencimento futura
    Realizar login
    Acessar area de tornar motorista
    Preencher formulario de motorista    ${CPF_VALIDO}    ${vencimento}    ${REGISTRO_VALIDO}
    Acionar o botao de cadastrar
    Verificar cadastro de motorista realizado com sucesso
