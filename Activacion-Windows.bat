@echo off
setlocal
 title Administrador de activacion de Windows
:menu
cls
echo ============================================================
echo             ADMINISTRADOR DE ACTIVACION DE WINDOWS
echo ============================================================
echo Utiliza una licencia valida o el KMS autorizado de tu empresa.
echo Las claves genericas no conceden una licencia.
echo.
echo 1. Consultar detalles de activacion
echo 2. Consultar vencimiento
echo 3. Instalar una clave de producto
echo 4. Configurar servidor KMS
echo 5. Intentar activar Windows
echo 6. Quitar servidor KMS configurado manualmente
echo 0. Salir
echo.
choice /c 1234560 /n /m "Selecciona una opcion: "
if errorlevel 7 goto fin
if errorlevel 6 goto quitar
if errorlevel 5 goto activar
if errorlevel 4 goto kms
if errorlevel 3 goto clave
if errorlevel 2 goto vencimiento
if errorlevel 1 goto estado
goto fin
:estado
cscript.exe //nologo "%SystemRoot%\System32\slmgr.vbs" /dlv
goto volver
:vencimiento
cscript.exe //nologo "%SystemRoot%\System32\slmgr.vbs" /xpr
goto volver
:clave
call :admin
if errorlevel 1 goto volver
powershell.exe -NoLogo -NoProfile -Command "$k = (Read-Host 'Clave de producto (Enter para cancelar)').Trim(); if (!$k) { exit }; if ($k -notmatch '^[A-Za-z0-9]{5}(-[A-Za-z0-9]{5}){4}$') { Write-Host 'Formato de clave incorrecto.'; exit 1 }; Write-Host 'Se reemplazara la clave instalada. Conserva tu clave original antes de continuar.'; if ((Read-Host 'Confirmar instalacion [S/N]') -ine 'S') { exit }; & ($env:SystemRoot + '\System32\cscript.exe') //nologo ($env:SystemRoot + '\System32\slmgr.vbs') /ipk $k; exit $LASTEXITCODE"
goto volver
:kms
call :admin
if errorlevel 1 goto volver
powershell.exe -NoLogo -NoProfile -Command "$edition = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').EditionID; if ($edition -like 'Core*') { Write-Host 'Windows Home no admite activacion KMS.'; exit 1 }; Write-Host 'Introduce el servidor autorizado de tu organizacion. No se incluye un servidor publico.'; $server = (Read-Host 'Nombre DNS o IPv4, opcionalmente :puerto (Enter cancela)').Trim(); if (!$server) { exit }; $parts = $server.Split(':'); if ($parts.Count -gt 2 -or $parts[0].Length -gt 253 -or $parts[0] -notmatch '^(?=.{1,253}$)[A-Za-z0-9](?:[A-Za-z0-9.-]*[A-Za-z0-9])?$' -or $parts[0].Contains('..')) { Write-Host 'Servidor incorrecto. Usa un nombre DNS o IPv4 sin espacios.'; exit 1 }; if ($parts.Count -eq 2) { $port = 0; if (![int]::TryParse($parts[1], [ref]$port) -or $port -lt 1 -or $port -gt 65535) { Write-Host 'Puerto incorrecto.'; exit 1 } }; Write-Host ('Servidor seleccionado: ' + $server); if ((Read-Host 'Guardar y desactivar deteccion automatica de KMS [S/N]') -ine 'S') { exit }; & ($env:SystemRoot + '\System32\cscript.exe') //nologo ($env:SystemRoot + '\System32\slmgr.vbs') /skms $server; exit $LASTEXITCODE"
goto volver
:activar
call :admin
if errorlevel 1 goto volver
powershell.exe -NoLogo -NoProfile -Command "Write-Host 'Windows intentara activarse usando la clave y configuracion actuales.'; if ((Read-Host 'Continuar [S/N]') -ine 'S') { exit }; & ($env:SystemRoot + '\System32\cscript.exe') //nologo ($env:SystemRoot + '\System32\slmgr.vbs') /ato; exit $LASTEXITCODE"
goto volver
:quitar
call :admin
if errorlevel 1 goto volver
powershell.exe -NoLogo -NoProfile -Command "Write-Host 'Esto restaura la deteccion automatica de KMS; no recupera la clave anterior ni una licencia original.'; if ((Read-Host 'Quitar servidor manual [S/N]') -ine 'S') { exit }; & ($env:SystemRoot + '\System32\cscript.exe') //nologo ($env:SystemRoot + '\System32\slmgr.vbs') /ckms; exit $LASTEXITCODE"
goto volver
:admin
powershell.exe -NoLogo -NoProfile -Command "$p = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent()); if (!$p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { Write-Host 'Cierra y abre este BAT con clic derecho: Ejecutar como administrador.'; exit 1 }"
exit /b %errorlevel%
:volver
echo.
echo Revisa el mensaje de Windows anterior: indica el resultado o codigo de error.
pause
goto menu
:fin
endlocal
exit /b
