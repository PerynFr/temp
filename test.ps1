Эта команда покажет список установленных версий .NET Framework в реестре.
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP" /s

Если у вас есть PowerShell 5.1 или более новый вариант, вы можете использовать следующую команду:
Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' | Select-Object @{n='Version';e={($_.DisplayName -split ' ')[1]}}

Если все вышеуказанные варианты не работают, возможно, у вас установлены только более новые версии .NET Framework, такие как .NET Framework 4.7.2, .NET Framework 4.8 или .NET Core. В этом случае для проверки установленных версий .NET Framework можно использовать следующую команду в PowerShell:
Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' | Get-ItemProperty .\Full | Select-Object @{n='Version';e={($_.DisplayName -split ' ')[1]}}
