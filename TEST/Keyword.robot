*** Keywords ***
Open browser to do List
    Open browser    https://abhigyank.github.io/To-Do-List/     chrome

Verify Component On Website
    [Arguments]     ${TITLE_DATA}
    ...             ${ADD_ITEM_DATA}
    ...             ${TO-DO_TASKS_DATA}
    ...             ${COMPLETED_DATA}
    ${titleName}    Get text    xpath=/html/body/div/h1
    ${addItemName}    Get text    xpath=/html/body/div/div/div[1]/a[1]
    ${toDoTasksName}    Get text    xpath=/html/body/div/div/div[1]/a[2]
    ${completedName}    Get text    xpath=/html/body/div/div/div[1]/a[3]
    Should Be Equal As Strings    ${titleName}    ${TITLE_DATA}
    Should Be Equal As Strings    ${addItemName}    ${ADD_ITEM_DATA}
    Should Be Equal As Strings    ${toDoTasksName}    ${TO-DO_TASKS_DATA}
    Should Be Equal As Strings    ${completedName}    ${COMPLETED_DATA}
    Element Should Be Visible    xpath=//*[@id="new-task"]
    Element Should Be Visible    xpath=//*[@id="add-item"]/button/i

Input Text on Add ITEM page - one list
    [Arguments]    ${TEST_1}
    Click Element    xpath=//*[@id="new-task"]
    Input Text    xpath=//*[@id="new-task"]    ${TEST_1}
    Click Button    xpath=//*[@id="add-item"]/button
    Set Test Variable    ${TEST_1}

Verify to do tasks page - add to do list success one list
    [Arguments]    ${TITLE_DATA}
    Click Element    xpath=/html/body/div/div/div[1]/a[2]
    ${titleName}    Get text    xpath=/html/body/div/h1
    ${addItemSuccess}    Get text    xpath=//*[@id="text-1"]
    Should Be Equal As Strings    ${titleName}    ${TITLE_DATA}
    Should Be Equal As Strings    ${addItemSuccess}    ${TEST_1}
    Element Should Be Visible    xpath=//*[@id="incomplete-tasks"]/li/label/span[3]
    Element Should Be Visible    xpath=//*[@id="1"]/span

Verify complete page - add to do list complete one list
    [Arguments]    ${TITLE_DATA}
    Click Element    xpath=//*[@id="incomplete-tasks"]/li/label/span[4]
    Element Should Not Be Visible    xpath=//*[@id="text-1"]
    Click Element    xpath=/html/body/div/div/div[1]/a[3]
    ${titleName}    Get text    xpath=/html/body/div/h1
    ${completeToDoTask}    Get text    xpath=//*[@id="completed-tasks"]/li[1]/span
    Should Be Equal As Strings    ${titleName}    ${TITLE_DATA}
    Should Contain    ${completeToDoTask}    ${TEST_1}
    Click Element    xpath=//*[@id="1"]/span
    Element Should Not Be Visible    ${completeToDoTask}

Input Text on Add ITEM page - more than one list
    [Arguments]    ${TEST_1}
    ...            ${TEST_2}
    ...            ${TEST_3}
    ...            ${TEST_4}
    @{ToDoList}=    Create list    ${TEST_1}    ${TEST_2}    ${TEST_3}    ${TEST_4}
        FOR  ${ToDo}  IN  @{ToDoList}
            Log  ${ToDo}
            Click Element    xpath=//*[@id="new-task"]
            Input Text    xpath=//*[@id="new-task"]    ${ToDo}
            Click Button    xpath=//*[@id="add-item"]/button
        END

Verify to do tasks page - add to do list success more than one list
    [Arguments]    ${TEST_1}
    ...            ${TEST_2}
    ...            ${TEST_3}
    ...            ${TEST_4}
    Click Element    xpath=/html/body/div/div/div[1]/a[2]
    ${titleName}    Get text    xpath=/html/body/div/h1
    ${addItemSuccess}    Get text    xpath=//*[@id="text-1"]
    Should Be Equal As Strings    ${titleName}    ${TITLE_DATA}
    ${isToDoListExist}    Get Element Count    xpath=//*[@id="incomplete-tasks"]/li
    log    ${isToDoListExist}
    FOR  ${index}  IN RANGE  1  ${isToDoListExist}+1
        ${toDoList}    Get text    xpath=//*[@id="text-${index}"]
        Should Be Equal As Strings    ${toDoList}    ${TEST_${index}}
    END
    FOR  ${index}  IN RANGE  1  ${isToDoListExist}+1
        Run Keyword If    ${isToDoListExist}>0
        ...    Click Element    xpath=//*[@id="text-1"]
    END

Verify complete page - add to do list more than one list
    [Arguments]    ${TITLE_DATA}
    ...            ${TEST_1}
    ...            ${TEST_2}
    ...            ${TEST_3}
    ...            ${TEST_4}
    Click Element    xpath=/html/body/div/div/div[1]/a[3]
    ${titleName}    Get text    xpath=/html/body/div/h1
    Should Be Equal As Strings    ${titleName}    ${TITLE_DATA}
    ${isToDoCompleteExist}    Get Element Count    xpath=//*[@id="completed-tasks"]/li
    log    ${isToDoCompleteExist}
    FOR  ${index}  IN RANGE  1  ${isToDoCompleteExist}+1
        ${toDoComplete}    Get text    xpath=//*[@id="completed-tasks"]/li[${index}]/span
        Should Contain    ${toDoComplete}    ${TEST_${index}}
        Element Should Be Visible    //*[@id="${index}"]/span
    END
    FOR  ${index}  IN RANGE  1  ${isToDoCompleteExist}+1
        Run Keyword If    ${isToDoCompleteExist}>0
        ...    Click Element    xpath=//*[@id="1"]
    END

Delete list on TO-DO TASKS page - one list
    Click Element    xpath=//*[@id="1"]/span
    Element Should Not Be Visible    xpath=//*[@id="text-1"]

Verify complete page - empty list
    [Arguments]    ${TITLE_DATA}
    Click Element    xpath=/html/body/div/div/div[1]/a[3]
    ${titleName}    Get text    xpath=/html/body/div/h1
    Should Be Equal As Strings    ${titleName}    ${TITLE_DATA}
    Element Should Not Be Visible    xpath=//*[@id="completed-tasks"]/li[1]/span

Verify to do tasks page - add empty text
    [Arguments]    ${TITLE_DATA}
    Click Element    xpath=/html/body/div/div/div[1]/a[2]
    ${titleName}    Get text    xpath=/html/body/div/h1
    Should Be Equal As Strings    ${titleName}    ${TITLE_DATA}
    Element Should Not Be Visible    xpath=//*[@id="text-1"]
    Element Should Not Be Visible    xpath=//*[@id="incomplete-tasks"]/li/label/span[3]
    Element Should Not Be Visible    xpath=//*[@id="1"]/span