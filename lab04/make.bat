set projectName=lab04
set moduleName1=module
set moduleName2=longop
ml /c /Cx /Zd /coff %projectName%.asm
ml /c /Cx /Zd /coff %moduleName1%.asm
ml /c /Cx /Zd /coff %moduleName2%.asm
link /SUBSYSTEM:CONSOLE %projectName%.obj %moduleName1%.obj %moduleName2%.obj /OUT:%projectName%.exe