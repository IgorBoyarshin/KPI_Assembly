set projectName=lab02
ml /c /Zd /coff %projectName%.asm
link /SUBSYSTEM:CONSOLE %projectName%.obj
%projectName%.exe