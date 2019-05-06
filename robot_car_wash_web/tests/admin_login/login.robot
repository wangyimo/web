*** Settings ***
Resource  ../resource.robot
Library  base_libarary.common.CommonLibrary
*** Test Cases ***
Valid Login
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    wait until keyword succeeds  0min   2sec   Title Should Be    虾洗运营后台
    Input Text    name=userName    admin
    Input Text    name=password    admin123
    ${img_src}  get element attribute  css=.pin-img>img  src
    ${button}  set variable  css=form>button
    ${vk}  set variable  ${img_src[62:]}
    ${res}  get verify code  ${vk}
    Input Text    pin    ${res}
    Click Button    ${button}
    Click Button    ${button}
    sleep  2
    location should be  https://car-wash-admin-d.parkone.cn/main/home
    [Teardown]    Close Browser

*** Keywords ***

