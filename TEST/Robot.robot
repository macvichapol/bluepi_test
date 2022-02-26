*** Settings ***
Library         Selenium2Library
Library         BuiltIn
Library         Collections
Resource        Keyword_BluePi.robot
Resource        Variable_BluePi.robot
Test Setup      Run Keywords
...             Open browser to do List    AND
...             Verify Component On Website    ${TITLE_DATA}    ${ADD_ITEM_DATA}    ${TO-DO_TASKS_DATA}    ${COMPLETED_DATA}

*** Test Cases ***
Test complete To Do List flow Success - one list
    Input Text on Add ITEM page - one list    ${INPUT_TEXT1}
    Verify to do tasks page - add to do list success one list    ${TITLE_DATA}
    Verify complete page - add to do list complete one list    ${TITLE_DATA}

Test complete To Do List flow Success - more than one list
    Input Text on Add ITEM page - more than one list    ${INPUT_TEXT1}    ${INPUT_TEXT2}    ${INPUT_TEXT3}   ${INPUT_TEXT4}
    Verify to do tasks page - add to do list success more than one list    ${INPUT_TEXT1}    ${INPUT_TEXT2}    ${INPUT_TEXT3}    ${INPUT_TEXT4}
    Verify complete page - add to do list more than one list    ${TITLE_DATA}    ${INPUT_TEXT1}    ${INPUT_TEXT2}    ${INPUT_TEXT3}    ${INPUT_TEXT4}

Test delete list on TO-DO TASKS page
    Input Text on Add ITEM page - one list    ${INPUT_TEXT1}
    Verify to do tasks page - add to do list success one list    ${TITLE_DATA}
    Delete list on TO-DO TASKS page - one list
    Verify complete page - empty list    ${TITLE_DATA}

Test input empty text on add item page
    Input Text on Add ITEM page - one list    ${NULL_TEXT}
    Verify to do tasks page - add empty text     ${TITLE_DATA}
    Verify complete page - empty list    ${TITLE_DATA}