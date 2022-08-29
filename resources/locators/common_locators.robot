*** Settings ***
Documentation    Locators de elementos comuns a todo framework

*** Variables ***

${BODY}                                         //body
${XPATH_RESULT}=                                (document.evaluate('$$', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null)).singleNodeValue.click()
${PATH_FILES}=                                  ${EXECDIR}\\resources\\files\\$$\\$$