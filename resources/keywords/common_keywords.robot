*** Settings ***
Documentation    Keywords comuns a todo framework

Library         SeleniumLibrary
Library         FakerLibrary    locale=pt_BR
Library         String
Library         ScreenCapLibrary
Library         BuiltIn
Library         DateTime

Resource        ../locators/common_locators.robot

Variables    ../utils/config_variables.py

*** Keywords ***

Retornar os dados do ambiente de testes

    ${test_environment}=    Set Variable If    
    ...        '${ENVIRONMENT}' == 'UAT'    ${UAT_ENVIRONMENT}
    ...        '${ENVIRONMENT}' == 'RC'    ${RC_ENVIRONMENT}

    Set Global Variable    ${DB_ENVIRONMENT_CONFIG}    ${test_environment}

Abrir o navegador

    Retornar os dados do ambiente de testes

    Open Browser    ${DB_ENVIRONMENT_CONFIG}[TESTED_HOST]    ${BROWSER}    None    ${SELENIUM_HOST}   options=${BROWSER_OPTIONS}
    Maximize Browser Window

Abrir a página home

    Abrir o navegador
    # Adicionar keywords para validar a home do site

Fechar o browser
   
    Close Browser

Fechar todos os browsers

    Close All Browsers

Mouse Over If Element Is Visible
    [Arguments]   ${element}  ${wait_time}=10s

    Wait Until Element Is Visible     ${element}    ${wait_time}
    Mouse Over    ${element}

Click If Element Is Visible
    [Arguments]   ${element}  ${wait_time}=10s

    Mouse Over If Element Is Visible     ${element}    ${wait_time}
    Click Element  ${element}

Double Click If Element Is Visible
    [Arguments]   ${element}  ${wait_time}=10s

    Mouse Over If Element Is Visible     ${element}    ${wait_time}
    Double Click Element  ${element}

Click If Button Is Visible
    [Arguments]   ${element}  ${wait_time}=10s

    Mouse Over If Element Is Visible     ${element}    ${wait_time}
    Click Button  ${element}

Click If Link Is Visible
    [Arguments]   ${element}  ${wait_time}=10s

    Mouse Over If Element Is Visible     ${element}    ${wait_time}
    Click Link  ${element}

Input Text If Element Is Visible
    [Arguments]   ${element}    ${text}    ${wait_time}=10s

    Wait Until Element Is Visible     ${element}    ${wait_time}
    Input Text  ${element}    ${text}

Check Element Attribute
    [Arguments]    ${element_locator}    ${expected_value}    ${attribute}

    Wait Until Element Is Visible    ${element_locator}
    ${return_value}=    Get Element Attribute    ${element_locator}    ${attribute}

    Should Be Equal    ${return_value}    ${expected_value}

String Replace
    [Documentation]  Replaces the ocurrences of '$$' for the respective strings.
    [Arguments]  ${template_string}  @{replacement_strings}

    FOR    ${string}    IN    @{replacement_strings}
        ${template_string} =   Replace String    ${template_string}   $$   ${string}    count=1
    END

    [Return]    ${template_string}

Realizar Scroll
    [Arguments]  ${locator}
    
    ${x}=        Get Horizontal Position  ${locator}
    ${y}=        Get Vertical Position    ${locator}
    Execute Javascript  window.scrollTo(${x}, ${y})

Pressione a tecla
    [Documentation]    https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Press%20Keys
    [Arguments]    ${tecla}    ${locator}=${None}

    Press Keys    ${locator}    ${tecla}

Retornar um grupo random de letras
    [Documentation]    O argumento ${number} é a quantidades de caracteres que queremos na string
    [Arguments]    ${number}

    ${grupo}=   Set Variable    ${EMPTY}

    FOR  ${num}  IN RANGE  ${number}
        ${letra}=    FakerLibrary.Random Letter
        ${grupo}=    Catenate    SEPARATOR=     ${grupo}    ${letra}
    END

    [Return]    ${grupo}

Retornar uma substring
    [Documentation]    https://robotframework.org/robotframework/latest/libraries/String.html#Get%20Substring
    [Arguments]    ${string}    ${start}    ${end}=${NONE}

    ${result}=  Get Substring	${string}   ${start}    ${end}

    [Return]    ${result}

Realizar click via Javascript
    [Documentation]    Executar um click via javascript em um elemento identificado pelo xpath.
    ...                Uma alternativa em casos que temos um elemento sobreposto ao outro.
    [Arguments]    ${xpath}

    ${element}=    String Replace    ${XPATH_RESULT}    ${xpath}
    Execute Javascript    ${element}

Espera justificada
    [Documentation]    Usar sleep em testes não é uma boa opção, porém existem situações em que se faz necessário.
    ...                Em casos que não tenhamos outra forma de espera devemos utilizar o sleep porém justificando seu motivo.
    [Arguments]    ${wait}    ${message}

    Log    Motivo para utilização do sleep: ${message}
    Sleep    ${wait}  

Verificar o título H4 
    [Arguments]    ${title_esperado}

    ${element}=    String Replace    ${H4_HMTL_TAG}    ${title_esperado}
    Wait Until Element Is Visible    ${element}

Verificar o título H5
    [Arguments]    ${title_esperado}

    ${element}=    String Replace    ${H5_HMTL_TAG}    ${title_esperado}
    Wait Until Element Is Visible    ${element}

Retornar o celular formatado com () e - para celular com 11 caracteres
    [Arguments]    ${celular}

    ${fone_final}=    Get Substring    ${celular}    -4
    ${fone_start}=    Get Substring    ${celular}    0    2
    ${fone_meio}=     Get Substring    ${celular}    2    7
    ${mobile}=     Catenate    (${fone_start})     ${fone_meio}-${fone_final}
    
    [Return]    ${mobile}

Inicar gravação de evidências

    Set Selenium Speed    0.2 seconds
    Start Video Recording    name=${TEST_NAME}

Finalizar gravação de evidências

    Stop Video Recording
    Set Selenium Speed    0 seconds

Remover parenteses espaços pontos barras e hífem de uma string
    [Arguments]    ${text}

    ${return_text}=   Remove String   ${text}   (   )   -   .  /   \   ${SPACE}

    [Return]   ${return_text} 

Remover pontos de uma string
    [Arguments]    ${text}

    ${return_text}=   Remove String   ${text}   .

    [Return]   ${return_text} 

Realizar hide em um modal via javascript
    [Documentation]     Esta keywords força que um modal seja fechado via javascript.
    ...                 Neste caso estamos utilizando o id do elemento
    [Arguments]  ${modal_id}

    Execute Javascript     $('#${modal_id}').modal('hide')

Retornar o caminho de arquivo da pasta files
    [Arguments]     ${pasta}    ${file}

    ${file}=    String Replace    ${PATH_FILES}     ${pasta}     ${file}

    [Return]   ${file}

Retornar o conteúdo de um arquivo para teste
    [Arguments]    ${pasta}    ${nome_arquivo}

    ${file_path}=    Retornar o caminho de arquivo da pasta files   ${pasta}    ${nome_arquivo}
    ${file}=         Get File          ${file_path}

    [Return]    ${file}

Retornar o conteúdo de um arquivo para teste - utf-8
    [Arguments]    ${pasta}    ${nome_arquivo}

    ${file_path}=    Retornar o caminho de arquivo da pasta files   ${pasta}    ${nome_arquivo}
    ${file}=         Get File          ${file_path}    encoding='utf-8'    encoding_errors=strict

    [Return]    ${file}
 
Formatar uma data para o sistema pt-BR
    [Documentation]    Formatar uma data que esteja como 1945-07-30 00:00:00 para somente a data no sistema pt-BR 30-07-1945
    [Arguments]    ${data}

    ${month}=    Set Variable If    ${data.month} < 10        0${data.month}    ${data.month}
    ${day}=    Set Variable If    ${data.day} < 10        0${data.day}    ${data.day}

    [Return]    ${day}-${month}-${data.year}

Retornar a data atual

    ${data} =	Get Current Date	result_format=datetime

    ${month}=    Set Variable If    ${data.month} < 10        0${data.month}    ${data.month}
    ${day}=    Set Variable If    ${data.day} < 10        0${data.day}    ${data.day}

    [Return]    ${day}/${month}/${data.year}

Fazer o incremento de uma data

    [Documentation]    O método trabalha no formato de recebimento e retorno para "%d/%m/%Y", exemplo: 07/03/1998.
    [Arguments]    ${dataAtual}    ${quantidadeDias}
    
    ${novaData}=             Add Time To Date    ${dataAtual}    ${quantidadeDias} days    date_format=%d/%m/%Y    result_format=%d/%m/%Y
    [Return]    ${novaData}

Retornar a ${data} trocando ${caracter_existente} por ${caracter_novo}

    ${new_date}=    Replace String          ${data}     ${caracter_existente}    ${caracter_novo}   

    [Return]    ${new_date}

Comparar se dois valores são iguais
    [Arguments]    ${valor_um}    ${valor_dois}

    Should Be Equal    ${valor_um}    ${valor_dois}

Comparar se dois valores são diferentes
    [Arguments]    ${valor_um}    ${valor_dois}

    Should Not Be Equal    ${valor_um}    ${valor_dois}

Retornar uma propriedade de um javascript pseudo element
    [Documentation]    Exemplo retornar a proriedade width de um pseudo element ::after de um label com for=ritemd
    [Arguments]    ${query_element}    ${pseudo_element}    ${propriedade}

    ${element}=    String Replace    return (window.getComputedStyle(document.querySelector('$$'),'$$').getPropertyValue('$$'))    ${query_element}    ${pseudo_element}    ${propriedade}
    ${result}=    Execute Javascript    ${element}

    Log   ${result}

    [Return]    ${result}

Formatar um CEP
    [Arguments]    ${cep}
    
    ${bloco_1}=    Retornar uma substring    ${cep}    0    5
    ${bloco_2}=    Retornar uma substring    ${cep}    5    8

    [Return]    ${bloco_1}-${bloco_2}

Formatar um CNPJ
    [Arguments]    ${cnpj}

    ${bloco_1}=        Retornar uma substring    ${cnpj}    0    2
    ${bloco_2}=        Retornar uma substring    ${cnpj}    2    5
    ${bloco_3}=        Retornar uma substring    ${cnpj}    5    8
    ${bloco_4}=        Retornar uma substring    ${cnpj}    8    12
    ${bloco_5}=        Retornar uma substring    ${cnpj}    12   14

    [Return]    ${bloco_1}.${bloco_2}.${bloco_3}/${bloco_4}-${bloco_5}

Formatar um CPF
    [Arguments]    ${cpf}

    ${bloco_1}=        Retornar uma substring    ${cpf}    0    3
    ${bloco_2}=        Retornar uma substring    ${cpf}    3    6
    ${bloco_3}=        Retornar uma substring    ${cpf}    6    9
    ${bloco_4}=        Retornar uma substring    ${cpf}    9    11

    [Return]    ${bloco_1}.${bloco_2}.${bloco_3}-${bloco_4}

Formatar documento CPF/CNPJ
    [Arguments]    ${documento}

    ${doc}=    Set Variable    ${documento}

    ${length}=  Get Length	 ${doc}
    IF    ${length} == 11
        ${doc}=    Formatar um CPF    ${documento}
    ELSE
        ${doc}=   Formatar um CNPJ    ${documento}
    END

    [Return]    ${doc}

Formatar uma Danfe
    [Arguments]    ${danfe}

    # Analisar uma melhor forma de realizar a formatação de uma string
    ${bloco_1}=        Retornar uma substring    ${danfe}    0    4
    ${bloco_2}=        Retornar uma substring    ${danfe}    4    8
    ${bloco_3}=        Retornar uma substring    ${danfe}    8    12
    ${bloco_4}=        Retornar uma substring    ${danfe}    12    16
    ${bloco_5}=        Retornar uma substring    ${danfe}    16   20
    ${bloco_6}=        Retornar uma substring    ${danfe}    20    24
    ${bloco_7}=        Retornar uma substring    ${danfe}    24    28
    ${bloco_8}=        Retornar uma substring    ${danfe}    28    32
    ${bloco_9}=        Retornar uma substring    ${danfe}    32    36
    ${bloco_10}=       Retornar uma substring    ${danfe}    36   40
    ${bloco_11}=       Retornar uma substring    ${danfe}    40   44

    [Return]    ${bloco_1} ${bloco_2} ${bloco_3} ${bloco_4} ${bloco_5} ${bloco_6} ${bloco_7} ${bloco_8} ${bloco_9} ${bloco_10} ${bloco_11}

Retornar o mês pelo numero
    [Arguments]    ${num_mes}

    ${string_num}=    Convert To String    ${num_mes}   

    [Return]    ${MESES}[${string_num}]

Retornar a diferença em dias entre duas datas
    [Arguments]    ${data_inicio}    ${data_final}

    ${d1}=      Convert Date    ${data_inicio}    result_format=%Y/%m/%d
    ${d2}=      Convert Date    ${data_inicio}    result_format=%Y/%m/%d

    ${DIFFERNCE_IN_DAYS} =	Subtract Date From Date    ${data_final}   ${data_inicio}    verbose
    @{total_days}=    Split String    ${DIFFERNCE_IN_DAYS}
    ${final_days}=    Set Variable    ${total_days[0]}

    [Return]    ${final_days}

Realizar split em uma string e retornar a quantidade de itens
    [Arguments]     ${string_for_split}    ${separator}
    
    ${splited_values}=    Convert To String   ${string_for_split}
    ${response_list}   Split String    ${splited_values}    ${separator}
    ${quantidades_de_itens}   Get Length   ${response_list}
    ${quatidade_final}   Evaluate   ${quantidades_de_itens} - 1

    [Return]    ${quatidade_final}
