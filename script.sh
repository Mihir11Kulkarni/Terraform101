#!/bin/bash
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install python -y
choco install git -y
python -m pip install --upgrade pip
pip install django
mkdir -p /c/Users/Public/pythonscript
cd /c/Users/Administrator/pythonscript
curl -o git-installer.exe -L https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.2/Git-2.32.0.2-64-bit.exe
./git-installer.exe /SILENT /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /DIR="C:\Git"
git clone https://dev.azure.com/mihirkulkarni11/Project-11/_git/pythondeployment
cd pythondeployment
New-NetFirewallRule -DisplayName '8000-Inbound' -Profile 'Domain,Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8000
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
python manage.py makemigrations
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
