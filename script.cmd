@echo off
chcp 1251
set "target_directory=C:\Users\ext_ascheglov\Downloads"
set "file_script=C:\Users\ext_ascheglov\Downloads\ALL_SQL_SCRIPTS_OUT.sql"

:: перекодировка в UTF8
set EncodingTo=UTF8
for /f "delims=" %%f in (
    'dir /b /s "%target_directory%\*.sql" ^| findstr /v /i /e /c:"%file_script%"'
) do (
    for /f "delims=" %%i in ('powershell -Command "(Get-Content '%%f' -Raw) -match '^[^\x00-\x7F]*$'"') do (
        if "%%i" neq "" (
            (copy "%%f" "%%f-utf8-already") && (
                echo File is already in UTF-8 format: "%%f"
            ) || (
                powershell "sc '%%f-utf8' -Encoding %EncodingTo% (gc '%%f')"
            )
        ) else (
            powershell "sc '%%f-utf8' -Encoding %EncodingTo% (gc '%%f')"
        )
    )
)

::pause
:: удаляем оригиналы
del "%target_directory%\*.sql"

:: переименовываем сконвертированные файлы в файлы с исходными именами
ren "%target_directory%\*.sql-utf8" "*.sql"
ren "%target_directory%\*.sql-utf8-already" "*.sql"

::pause
:: формируем исполнительный файл
echo :on error exit > %file_script%
echo print 'Timestamp start ........................... '+ convert^(varchar^(27^),sysdatetime^(^)^)+' ---^> ['+@@servername+'].'+db_name^(^) >> %file_script%
echo go >> %file_script%
for /f "delims=" %%f in (
    'dir /b /s "%target_directory%\*.sql" ^| findstr /v /i /e /c:"%file_script%"'
) do (
    echo :r "%%f" && echo go && echo print 'Timestamp ................................. '+ convert^(varchar^(27^),sysdatetime^(^)^)+' script completed successfully -^> '+'%%f' && echo go
) >>%file_script%
