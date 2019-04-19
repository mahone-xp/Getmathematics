@ECHO OFF
chcp 65001
REM chcp 65001 强制转换为utf-8编码格式显示
mode con cols=49 lines=10
color 0A
cls
REM QuestQTY:题目数量 TaskRange:数值上限
echo.
echo.
echo.
set /p QuestQTY=请输入要生成的题目数量：
echo.
echo.
set /p TaskRange=请输入题目结果最大值：
cls
echo 请稍等，%QuestQTY%道%TaskRange%以内加减法正在生成中……
REM 启用延迟环境变量扩展
REM 一直不知道为什么要加上这个才行
setlocal enabledelayedexpansion
rem 归零计数器
set /a CreateNum=0
set /a PlusNum=0
set /a MinusNum=0
echo %TaskRange%以内加减法%QuestQTY%道 >math.txt
:CreateMath
set /a MSymbol=!random!%%2
if %CreateNum% LSS %QuestQTY% (
set /a CreateNum=CreateNum+1    
REM CreateNum+1 记录增加了一次计算
if %MSymbol% == 1 (
set /a PlusNum=PlusNum+1
rem 判断 MSymbol 的值，若为 “1” 则生成加法算式
goto :PlusCal ) else (
set /a MinusNum=MinusNum+1
goto :MinusCal)) else (
echo 加法%PlusNum%道，减法%MinusNum%道 >>math.txt
goto :end)
goto :CreateMath
:PlusCal
set /a Nums1=!random!%%TaskRange+1
set /a Nums2=!random!%%TaskRange+1
set /a NumSum=Nums1+Nums2
if !NumSum! LEQ %TaskRange% (
echo !Nums1! + !Nums2! =>> math.txt) else goto :PlusCal
goto :CreateMath
:MinusCal
set /a Nums1=!random!%%TaskRange+1
set /a Nums2=!random!%%TaskRange+1
if !Nums1! GEQ !Nums2! (
echo !Nums1! - !Nums2! =>> math.txt) else (
echo !Nums2! - !Nums1! =>> math.txt )
goto :CreateMath
:end
cls
echo.
echo.
echo.
echo          %QuestQTY%道%TaskRange%以内加减法生成成功!
echo.
echo       %QuestQTY%道计算题中，加法%PlusNum%道，减法%MinusNum%道
echo.
echo.
echo.
endlocal
pause
