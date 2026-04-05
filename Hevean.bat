@echo off
:: CS2 Blocker — Run as Administrator
echo Blocking CS2...

:: ---- Firewall Rules ----
netsh advfirewall firewall add rule name="Block-CS2-IN" dir=in action=block program="%ProgramFiles(x86)%\Steam\steamapps\common\Counter-Strike Global Offensive\game\bin\win64\cs2.exe" enable=yes
netsh advfirewall firewall add rule name="Block-CS2-OUT" dir=out action=block program="%ProgramFiles(x86)%\Steam\steamapps\common\Counter-Strike Global Offensive\game\bin\win64\cs2.exe" enable=yes

:: ---- Port Blocking ----
netsh advfirewall firewall add rule name="Block-CS2-Ports-TCP" dir=out action=block protocol=tcp remoteport=27015-27050,4380
netsh advfirewall firewall add rule name="Block-CS2-Ports-UDP" dir=out action=block protocol=udp remoteport=27015-27050,4380

:: ---- Rename Executable ----
set CS2="%ProgramFiles(x86)%\Steam\steamapps\common\Counter-Strike Global Offensive\game\bin\win64\cs2.exe"
set CS2_BAK="%ProgramFiles(x86)%\Steam\steamapps\common\Counter-Strike Global Offensive\game\bin\win64\cs2.exe.blocked"
if exist %CS2% rename %CS2% cs2.exe.blocked
if exist %CS2% (echo WARNING: Could not rename cs2.exe. Try closing Steam first.) else (echo cs2.exe renamed successfully.)

echo Done. CS2 is blocked. Steam still works normally.
pause