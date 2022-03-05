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
ECHO .....Creando carpetas dentro src ...
mkdir Backend\src\config &
mkdir Backend\src\routes &
mkdir Backend\src\services &
mkdir Backend\src\utils &
mkdir Backend\src\utils\lib &
mkdir Backend\src\utils\middlewares &
ECHO .....Creando carpeta test dentro de src ...
mkdir Backend\test &
mkdir Backend\test\routes &
mkdir Backend\test\services &
mkdir Backend\test\utils &
mkdir Backend\test\utils\mocks &
mkdir Backend\test\utils\mocks\request &
mkdir Backend\test\utils\mocks\response &
ECHO Termino la creacion de carpertas!!!
ECHO =====================================
ECHO .....Creando archivos de inicio...
cd Backend\src
ECHO let generateIndex = "Hello World">"index.js"
ECHO console.log(generateIndex);>>"index.js"
ECHO .....archivo ==== src/index.js
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
ECHO .....archivo ==== src/.ENV
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
ECHO .....archivo ==== src/config/config.js
cd..
cd utils
(
ECHO //responses's
)>"response.build.js"
ECHO .....archivo ==== src/utils/response.build.js
cd..
cd..
goto preguntaGIT

:dos
ECHO .....Creando carpetas para LAMBDA...
mkdir BackendLambda &
mkdir BackendLambda\src &
ECHO .....Creando carpeta src ...
mkdir BackendLambda\src\config &
mkdir BackendLambda\src\controllers &
mkdir BackendLambda\src\services &
mkdir BackendLambda\src\utils &
mkdir BackendLambda\src\utils\lib &
mkdir BackendLambda\src\utils\middlewares &
ECHO .....Creando carpeta test ...
mkdir BackendLambda\test &
mkdir BackendLambda\test\controllers &
mkdir BackendLambda\test\services &
mkdir BackendLambda\test\utils &
mkdir BackendLambda\test\utils\mocks &
mkdir BackendLambda\test\utils\mocks\request &
mkdir BackendLambda\test\utils\mocks\response &
ECHO Termino la creacion de carpertas!!!
ECHO =====================================
cd BackendLambda\src
ECHO exports.handler = function(event, context) {>"index.js"
ECHO   console.log("Received event: ", event);>>"index.js"
ECHO   var data = {>>"index.js"
ECHO       "example": "Hello world">>"index.js"
ECHO   }; >>"index.js"
ECHO   const response = {>>"index.js"
ECHO     statusCode: 200,>>"index.js"
ECHO     body: JSON.stringify(data)>>"index.js"
ECHO   };>>"index.js"
ECHO };>>"index.js"
ECHO .....archivo ==== src/index.js

cd config
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
ECHO .....archivo ==== src/config/constants.js
cd..
cd utils
(
ECHO //responses's
)>"response.build.js"
cd..
cd..
goto preguntaGIT

:preguntaGIT
ECHO =====================================
set /p respGIT=¿Desea iniciar GIT para proyecto?(S/N):
IF "%respGIT%" == "" goto preguntaNPM
IF "%respGIT%" == "S" goto iniciarGIT
IF "%respGIT%" == "s" goto iniciarGIT
IF "%respGIT%" == "n" goto preguntaNPM
IF "%respGIT%" == "N" goto preguntaNPM

:iniciarGIT
CALL git init
ECHO Creando ramas base main - stage - develop
CALL git checkout -b main
CALL git checkout -b stage
CALL git checkout -b develop
ECHO ....Descargando .gitignore desde:
ECHO https://www.toptal.com/developers/gitignore/api/node
powershell -Command "iwr -uri https://www.toptal.com/developers/gitignore/api/node -OutFile .gitignore"
goto preguntaNPM

:preguntaNPM
ECHO =====================================
set /p respNPM=¿Desea inicia proyecto NODE JS?(S/N):
IF "%respNPM%" == "" goto Fin
IF "%respNPM%" == "S" goto iniciarNPM
IF "%respNPM%" == "s" goto iniciarNPM
IF "%respNPM%" == "n" goto fin
IF "%respNPM%" == "N" goto fin


:iniciarNPM
ECHO .......Creando proyecto en default npm init
ECHO https://raw.githubusercontent.com/JohnE-ZNB/generateProjects
powershell -Command "iwr -uri https://raw.githubusercontent.com/JohnE-ZNB/generateProjects/develop/projectNPM/package.json -OutFile package.json"
goto preguntaInstall

:preguntaInstall
ECHO =====================================
set /p respGIT=¿Desea ejecutar el comando: npm install -D ?(S/N):
IF "%respGIT%" == "" goto descargarLinters
IF "%respGIT%" == "S" goto installNPM
IF "%respGIT%" == "s" goto installNPM
IF "%respGIT%" == "n" goto descargarLinters
IF "%respGIT%" == "N" goto descargarLinters

:installNPM
ECHO ..... Instando paquetes de NMP Linter y prettier
ECHO ....... .......
CALL npm i -D eslint eslint-config-google eslint-config-prettier eslint-plugin-import eslint-plugin-prettier
CALL npm i -D prettier prettier-eslint
CALL npm i -D mocha
CALL npm i -D nyc
goto descargarLinters

:descargarLinters
ECHO ....Descargando .eslintignore desde:
ECHO https://github.com/JohnE-ZNB/generateProjects
powershell -Command "iwr -uri https://raw.githubusercontent.com/JohnE-ZNB/generateProjects/develop/formatter/.eslintignore -OutFile .eslintignore"
ECHO ....Descargando .eslintrc desde:
ECHO https://github.com/JohnE-ZNB/generateProjects
powershell -Command "iwr -uri https://raw.githubusercontent.com/JohnE-ZNB/generateProjects/develop/formatter/.eslintrc -OutFile .eslintrc"
ECHO ....Descargando .prettierignore desde:
ECHO https://github.com/JohnE-ZNB/generateProjects
powershell -Command "iwr -uri https://raw.githubusercontent.com/JohnE-ZNB/generateProjects/develop/formatter/.prettierignore -OutFile .prettierignore"
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