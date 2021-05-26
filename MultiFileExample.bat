@echo off

set title=CraftMine Backup

set baseFolder=G:\Games\CraftMine\

set amount=3
set folders[0]=saves\
set folders[1]=mods\
set folders[2]=important\
set folders[3]=mp\

set destinationFolder=D:\Backups\GameSaves\CraftMine\

call Backupper.bat
