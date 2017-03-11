set projectName=tst
set moduleName=module
ml /c /Cx /Zd /coff %projectName%.asm
ml /c /Cx /Zd /coff %moduleName%.asm
link /SUBSYSTEM:CONSOLE %projectName%.obj %moduleName%.obj /OUT:%projectName%.exe
%projectName%.exe