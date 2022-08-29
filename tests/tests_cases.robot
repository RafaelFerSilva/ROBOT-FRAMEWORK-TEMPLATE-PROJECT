*** Settings ***
Documentation    Suite de testes

Resource    ../resources/keywords/common_keywords.robot

Suite Teardown     Fechar todos os browsers

*** Test Cases ***

Teste 1

    Abrir a página home
