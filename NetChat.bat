@echo off
set IP=non
set PORT=non
set lver=0.1
:M
title NetChat
cls
echo.
type logo.txt
echo.
echo [ 1 ] : Mettre une IP
echo.
echo [ 2 ] : Mettre un port
echo.
echo [ 3 ] : Options
echo.
if %IP% neq non if %PORT% neq non (
	echo [ 4 ] : Se conecter au serveur : %IP% sur le port %PORT%
)
echo.
set /p c= : 
if %c% == 1 goto setip
if %c% == 2 goto setport
if %c% == 3 goto options
if %c% == 4 goto conect
if %c% neq 1 if %c% neq 2 if %c% neq 3 if %c% neq 4 goto M
:setip
title NetChat - IP
cls
echo.
type logo.txt
echo.
echo Mettez l'IP : 
echo.
set /p IP=: 
goto M
:setport
title NetChat - PORT
cls
echo.
type logo.txt
echo.
echo Mettez le PORT : 
echo.
set /p PORT=: 
goto M
:options
title NetChat - Options
cls
echo.
type logo.txt
echo.
echo Menu des options : 
echo.
echo [ 1 ] : Se mettre en mode listen
echo.
echo [ 2 ] : Verifier les mise a joure 
echo.
set /p c2=: 
if %c2% == 1 goto listen
if %c2% == 2 goto update
if %c2% neq 1 if %c2% neq 2 goto options
:conect
title NetChat - Conection...
echo.
bin\nc.exe %IP% %PORT% & title NetChat - Conecter a %IP% sur le port %PORT%
goto M
:update
title NetChat - Verification des mise a joure
cls
echo.
type logo.txt
echo.
echo Verification des mise a joure : 
echo.
bin\wget https://github.com/HDgaming5758/netchat/archive/master.zip > nul
echo.
bin\unzip master.zip
echo.
set /p over=< netchat-master\ver
echo.
if %over% gtr %lver% (
	echo @echo off> update.bat
	echo title Mise a jour>> update.bat
	echo del -s logo.txt NetChat.bat>> update.bat
	echo rmdir bin>> update.bat
	echo move netchat-master\*.*>> update.bat
	echo move netchat-master\bin>> update.bat
	echo call NetChat.bat>> update.bat
	pause
)
:listen
cls
echo.
type logo.txt
echo.
echo Voullez vous autoriser les conection anonyme ? :
echo.
set /p cl=(Y/n) : 
if %cl% == Y set anoc=on
if %cl% == y set anoc=on
if %cl% == N set anoc=off
if %cl% == n set anoc=off
if %cl% neq Y if %cl% neq y if %cl% neq N if %cl% neq n goto listen
:sport
cls
echo.
type logo.txt
echo.
echo Voullez vous mettre un port personaliser au alléatoir :
echo.
set /p cl2=(random/personaliser) : 
if %cl2% == random (
	set PORT=%random%
	if %PORT% leq 65535 if %PORT% geq 1 set %PORT%=%random%
)
:pp
if %cl2% == personaliser cls & echo. & type logo.txt & echo. & echo Port compris entre 1 et 65535 : & echo. & set /p PORT= : 
if %cl2% == personaliser (
	if %PORT% geq 65535 goto pp
	if %PORT% leq 1 goto pp
)
if %cl2% neq random if %cl2% neq personaliser goto sport
:mdp
cls
echo.
type logo.txt
echo.
echo Voullez vous mettre mot de passe :
echo.
set /p cl3=(Y/n) : 
set mdpac=off
if %cl2% == Y cls & echo. & type logo.txt & echo. & echo Mettez un mot de passe : & echo. & set /p mdp= : & set mdpac=on
if %cl3% == y cls & echo. & type logo.txt & echo. & echo Mettez un mot de passe : & echo. & set /p mdp= : & set mdpac=on
if %cl3% neq Y if %cl3% neq y if %cl3% neq N if %cl3% neq n goto smdp
cls
echo.
type logo.txt
echo.
echo Voullez vous vraiment lancer le mode listen avec les parametre suivent ? : 
echo.
echo Conection anonyme : [ %anoc% ]
echo.
echo Port : [ %PORT% ]
echo.
echo MDP : [ %mdpac% ]
