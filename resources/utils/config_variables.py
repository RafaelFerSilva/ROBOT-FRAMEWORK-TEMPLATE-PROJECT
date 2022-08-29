SELENIUM_HOST = ""
BROWSER="gc"
BROWSER_OPTIONS="add_experimental_option('excludeSwitches', ['enable-logging']);add_argument('--disable-dev-shm-usage')"
JSON_FILES_PATH = "resources/files/json/"

ENVIRONMENT = "UAT"
DB_API_MODULE_NAME = "pymssql"

UAT_ENVIRONMENT = {
    'TESTED_HOST':"https://uat.satelital.com.br",
    'DB_NAME':"dbPRW",
    'DB_USER':"iusr_orbia_prw",
    'DB_PASSWORD':"orbia@2020",
    'DB_HOST':"sqluat01.satelital.com.br",
    'DB_PORT':"1433",
    'USER_PASSWORD':"Unica@123",
    'ENCRIPTED_DEFAULT_PASSWORD': "00610485987E98E82C2D831F6C2FF155",
    'SQL_FOLDER': "UAT"
}

RC_ENVIRONMENT = {
    'TESTED_HOST':"https://rc.satelital.com.br",
    'DB_NAME':"dbPRW",
    'DB_USER':"usr_orbia",
    'DB_PASSWORD':"orbia@123",
    'DB_HOST':"sqlrc01.satelital.com.br",
    'DB_PORT':"1433",
    'USER_PASSWORD':"Test123!",
    'ENCRIPTED_DEFAULT_PASSWORD': "2168AD5E463D9ACCB215EDAAFA31C8D9",
    "SQL_FOLDER": "RC"
}

CARTAO_CREDITO_TEST = "4481530710186111"
