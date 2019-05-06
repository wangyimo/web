*** Settings ***
Resource  ../resource.robot
Library  base_libarary.common.CommonLibrary


*** Variables ***
${username}  admin_123
${password}  88888888


*** Test Cases ***
#Login Success
#    Open Browser    ${LOGIN URL}    ${BROWSER}
#    Maximize Browser Window
#    Set Selenium Speed    ${DELAY}
#    wait until keyword succeeds  0min   3sec   Title Should Be    中杆相机部署系统
#    Input Text    id=username    ${username}
#    Input Text    id=password    ${password}
##    ${eye_open_button}  set variable  id=eye-icon
#    click element    id=eye-icon
#    textfield value should be    id=password   88888888
##    ${eye_close_button}  set variable
#    Click element    id=eye-icon
#    element attribute value should be    id=password   type   password
##    ${img_src}  get element attribute  css=.pin-img>img  src
#    ${button}  set variable  css=.submit
##    ${vk}  set variable  ${img_src[62:]}
##    ${res}  get verify code  ${vk}
##    Input Text    pin    ${res}
#    Click Button    ${button}
##    Click Button    ${button}
#    sleep  3
#    location should be  https://camera-monitor-deployment-d.parkone.cn/main/home
#    [Teardown]    Close Browser
##    ${button1}  set variable  css=.btn-active
##    Click Button    ${button1}
##    location should be  https://car-wash-admin-d.parkone.cn/main/home
##    ${button2}  set variable  xpath=//button[@ng-reflect-router-link=',system']
##    Click Button    ${button2}
##    sleep  2
##    location should be  https://car-wash-admin-d.parkone.cn/system/employee-management
###    ${list1}     set variable       css=.ng-tns-c5-0 ant-menu-submenu-title
##    get text      css=.ant-menu>li
##    Get Text        xpath=//div[@class='ng-tns-c5-52 ant-menu-submenu-title']
##    [Teardown]    Close Browser
##    ${button3}  set variable   xpath=//button[@ng-reflect-router-link=',wash']
##    Click Button    ${button3}
##    sleep  2
##    location should be  https://car-wash-admin-d.parkone.cn/wash/collage-order/collage-order
##    ${button4}  set variable   xpath=//button[@ng-reflect-router-link=',record']
##    Click Button    ${button4}
##    sleep  2
##    location should be  https://car-wash-admin-d.parkone.cn/record/order-data
#
#Login Fail With Wrong Username Or Password
#    Open Browser    ${LOGIN URL}    ${BROWSER}
#    Maximize Browser Window
#    Set Selenium Speed    ${DELAY}
#    wait until keyword succeeds  0min   2sec   Title Should Be    中杆相机部署系统
#    Input Text    id=username  admin_455
#    Input Text    name=password  12345667
#    ${button}  set variable  css=.submit
#    Click Button    ${button}
#    sleep  3
#    element should contain   css=.danger   账号或者密码错误    ignore_case=False
#    close browser
#
#Username And Password Not In The 6-20 Word Range
#    Open Browser    ${LOGIN URL}    ${BROWSER}
#    Maximize Browser Window
#    Set Selenium Speed    ${DELAY}
#    wait until keyword succeeds  0min   2sec   Title Should Be    中杆相机部署系统
#    Input Text    id=username  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
#    Input Text    name=password  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
#    ${button}  set variable  css=.submit
#    Click Button    ${button}
#    sleep  3
#    element should contain     css=.danger   账号或者密码错误    ignore_case=False
##    close browser
#    reload page
#    wait until keyword succeeds  0min   5sec   Title Should Be    中杆相机部署系统
#    Input Text    id=username  aa
#    Input Text    name=password  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
#    ${button}  set variable  css=.submit
#    Click Button    ${button}
#    element should contain   css=.danger   账号或者密码错误！    ignore_case=False
#    close browser
#
#
#Username Not Valid
#    Open Browser    ${LOGIN URL}    ${BROWSER}
#    Maximize Browser Window
#    Set Selenium Speed    ${DELAY}
#    wait until keyword succeeds  0min   2sec   Title Should Be    中杆相机部署系统
#    Input Text    id=username  .phg@kkk$%%%
#    Input Text    name=password  888888888
#    ${button}  set variable  css=.submit
#    Click Button    ${button}
#    sleep  3
#    element should contain     css=.danger   账号或者密码错误！    ignore_case=False
#    close browser
#
#Password Not Valid
#    Open Browser    ${LOGIN URL}    ${BROWSER}
#    Maximize Browser Window
#    Set Selenium Speed    ${DELAY}
#    wait until keyword succeeds  0min   2sec   Title Should Be    中杆相机部署系统
#    Input Text    id=username  admi n_123
#    Input Text    name=password  .phg@kkk$%%%
#    ${button}  set variable  css=.submit
#    Click Button    ${button}
#    sleep  3
#    element should contain     css=.danger   账号或者密码错误！    ignore_case=False
#    close browser
#
#Login Success
#    Open Browser    ${LOGIN URL}    ${BROWSER}
#    Maximize Browser Window
#    Set Selenium Speed    ${DELAY}
#    wait until keyword succeeds  0min   3sec   Title Should Be    中杆相机部署系统
#    Input Text    id=username    ${username}
#    Input Text    id=password    ${password}
##    ${eye_open_button}  set variable  id=eye-icon
#    click element    id=eye-icon
#    textfield value should be    id=password   88888888
##    ${eye_close_button}  set variable
#    Click element    id=eye-icon
#    element attribute value should be    id=password   type   password
##    ${img_src}  get element attribute  css=.pin-img>img  src
#    ${button}  set variable  css=.submit
##    ${vk}  set variable  ${img_src[62:]}
##    ${res}  get verify code  ${vk}
##    Input Text    pin    ${res}
#    Click Button    ${button}
##    Click Button    ${button}
#    sleep  3
#    location should be  https://camera-monitor-deployment-d.parkone.cn/main/home
#    [Teardown]    Close Browser

Navigation page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    wait until keyword succeeds  0min   3sec   Title Should Be    中杆相机部署系统
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    ${button}  set variable  css=.submit
    Click Button    ${button}
    sleep  3
    location should be  https://camera-monitor-deployment-d.parkone.cn/main/home
    element text should be  css=.menu-container>li:first-child>div>span>span  系统管理  ignore_case=False
    click element   css=.menu-container>li:first-child>div>span>span
#    element text should be  css=.menu-container>li:first-child>ul   用户管理  ignore_case=False
    sleep  3
    click element   css=.menu-container>li:first-child>ul
    sleep  3
    location should be  https://camera-monitor-deployment-d.parkone.cn/main/system-management/user-management
    go back
    element text should be  css=.menu-container>li:nth-child(2)>div>span>span  项目信息管理  ignore_case=False
#    element text should be  css=.menu-container>li:nth-child(2)>ul>ul>li>span  项目信息列表  ignore_case=False
    sleep  3
    click element   css=.menu-container>li:nth-child(2)>div>span>span
    click element   css=.menu-container>li:nth-child(2)>ul
    sleep  3
    location should be  https://camera-monitor-deployment-d.parkone.cn/main/project-management/project-list
    go back
    element text should be  css=.main-header-layout>div:nth-child(2)>div:nth-child(2)  admin_123  ignore_case=False
    click element   css=.main-header-layout>div:nth-child(2)>div:nth-child(4)
    choose ok on next confirmation
#    alert should be present  text=确认退出?  action=ACCEPT   timeout=10
#    handle alert   action=ACCEPT
#    Close Browser

*** Keywords ***
Login

