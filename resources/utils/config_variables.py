SELENIUM_HOST = ""
BROWSER="gc"
BROWSER_OPTIONS="add_experimental_option('excludeSwitches', ['enable-logging']);add_argument('--disable-dev-shm-usage')"
JSON_FILES_PATH = "resources/files/json/"

ENVIRONMENT = "UAT"
DB_API_MODULE_NAME = "pymssql"

UAT_ENVIRONMENT = {
    'TESTED_HOST':"",
    'DB_NAME':"",
    'DB_USER':"",
    'DB_PASSWORD':"",
    'DB_HOST':"",
    'DB_PORT':"",
    'USER_PASSWORD':"",
    'ENCRIPTED_DEFAULT_PASSWORD': "",
    'SQL_FOLDER': "UAT"
}

RC_ENVIRONMENT = {
    'TESTED_HOST':"",
    'DB_NAME':"",
    'DB_USER':"",
    'DB_PASSWORD':"",
    'DB_HOST':"",
    'DB_PORT':"",
    'USER_PASSWORD':"",
    'ENCRIPTED_DEFAULT_PASSWORD': "",
    "SQL_FOLDER": ""
}
