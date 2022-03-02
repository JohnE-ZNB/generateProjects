@ECHO OFF
TITLE ESTRUCTURANDO PROYECTO
ECHO ==========================
ECHO ESTRUCTURANDO PROYECTO
ECHO ============================
ECHO ****************************
ECHO ¿Como se llamara tu proyecto? (Escribe si espacios)
ECHO ProyectoEjemplo - DevNodeJS - APIStore .... etc
set /p nombreProyecto=Seleccione una:
mkdir "%nombreProyecto%"
cd "%nombreProyecto%"
goto inicio 

:inicio
ECHO ****************************
ECHO Opciones de Estructura
ECHO ****************************
ECHO 1.BACKEND EXPRESS API
ECHO 2.BACKEND LAMBDA AWS
ECHO 3.FRONTEND ANGULAR
ECHO ============================
set /p respuesta=Seleccione una:
IF "%respuesta%" == "" goto fin
IF "%respuesta%" == "1" goto uno
IF "%respuesta%" == "2" goto dos

:uno
ECHO .....Creando carpetas...
mkdir Backend & 
mkdir Backend\src & 
ECHO .....Creando carpeta src ...
mkdir Backend\src\config & 
mkdir Backend\src\lib & 
mkdir Backend\src\routes & 
mkdir Backend\src\services & 
mkdir Backend\src\utils &
mkdir Backend\src\utils\middlewares &
mkdir Backend\src\utils\mocks &
ECHO .....Creando carpeta test ...
mkdir Backend\src\test &
mkdir Backend\src\test\routes &
mkdir Backend\src\test\services &
mkdir Backend\src\test\utils &
ECHO Termino la creacion de carpertas!!!
ECHO =====================================
ECHO .....Creando archivos de inicio...
ECHO .....archivo de config.js
cd Backend\src
(
ECHO //CONFIG
ECHO NODE_ENV=DEV
ECHO PORT:3000
ECHO CORS:*
ECHO //BASE DE DATOS
ECHO DB_USER=
ECHO DB_PASS=
ECHO DB_HOST=
ECHO DB_NAME=
)>".env"
ECHO .....archivo de .ENV
cd config
(
ECHO const config = {
ECHO  stage: process.env.NODE_ENV,
ECHO  port: process.env.PORT,
ECHO  dbUser: process.env.DB_USER,
ECHO  dbPass: process.env.DB_PASS,
ECHO  dbHost: process.env.DB_HOST,
ECHO  dbName: process.env.DB_NAME,
ECHO };
ECHO module.exports = { config };
)>"config.js"
cd..
goto preguntaNPM

:dos
ECHO .....Creando carpetas para LAMBDA...
mkdir BackendLambda & 
mkdir BackendLambda\src & 
ECHO .....Creando carpeta src ...
mkdir BackendLambda\src\lib & 
mkdir BackendLambda\src\routes & 
mkdir BackendLambda\src\services & 
mkdir BackendLambda\src\utils &
mkdir BackendLambda\src\utils\middlewares &
mkdir BackendLambda\src\utils\mocks &
ECHO .....Creando carpeta test ...
mkdir BackendLambda\src\test &
mkdir BackendLambda\src\test\routes &
mkdir BackendLambda\src\test\services &
mkdir BackendLambda\src\test\utils &
ECHO Termino la creacion de carpertas!!!
ECHO =====================================
cd BackendLambda\src
ECHO exports.handler = function(event, context) { >"index.js"
ECHO   console.log("Received event: ", event); >>"index.js"
ECHO   var data = { >>"index.js"
ECHO       "example": "Hello world"
ECHO   }; >>"index.js"
ECHO   const response = { >>"index.js"
ECHO     statusCode: 200, >>"index.js"
ECHO     body: JSON.stringify(data) >>"index.js"
ECHO   }; >>"index.js"
ECHO }; >>"index.js"
cd utils
(
ECHO module.exports = {
ECHO    CONFIG: {
ECHO     STAGE: process.env.NODE_ENV,
ECHO     PORT: process.env.PORT,
ECHO     DBUSER: process.env.DB_USER,
ECHO     DBPASS: process.env.DB_PASS,
ECHO     DBHOST: process.env.DB_HOST,
ECHO     DBNAME: process.env.DB_NAME,
ECHO    },
ECHO    CODE_ERRORS: {
ECHO      CODE_BAD_RESQUEST: 400,
ECHO      CODE_SUCESS: 200,
ECHO      CODE_INTERNAL_SERVER: 500,
ECHO    },
ECHO };
)>"constants.js"
(
ECHO //error's
)>"errors.js"
cd..
cd..
goto preguntaNPM

:preguntaNPM
ECHO =====================================
set /p respNPM=¿Desea inicia proyecto NODE JS?(S/N):
IF "%respNPM%" == "" goto Fin
IF "%respNPM%" == "S" goto iniciarNPM
IF "%respNPM%" == "s" goto iniciarNPM
IF "%respNPM%" == "n" goto preguntaGIT
IF "%respNPM%" == "N" goto preguntaGIT


:iniciarNPM
ECHO .......Creando proyecto en default npm init
CALL npm init -y
goto preguntaGIT

:preguntaGIT
ECHO =====================================
set /p respGIT=¿Desea iniciar GIT para proyecto?(S/N):
IF "%respGIT%" == "" goto fin
IF "%respGIT%" == "S" goto iniciarGIT
IF "%respGIT%" == "s" goto iniciarGIT
IF "%respGIT%" == "n" goto fin
IF "%respGIT%" == "N" goto fin

:iniciarGIT
CALL git init
ECHO ....Descargando .gitignore
ECHO https://www.toptal.com/developers/gitignore/api/node
powershell -Command "iwr -uri https://www.toptal.com/developers/gitignore/api/node -OutFile .gitignore"
goto fin

:fin
ECHO =====================================
SET /p continuar=¿Desea crear otra estructura?(S/N)
IF "%continuar%" == "" goto Fin
IF "%continuar%" == "S" goto inicio
IF "%continuar%" == "s" goto inicio
IF "%continuar%" == "n" goto finalizar
IF "%continuar%" == "N" goto finalizar

:finalizar
PAUSE