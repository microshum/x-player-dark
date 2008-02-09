@echo off
echo Deleting old build...
del *.dcu
del *.~*
del *.bak
del *.ddp
echo Compiling...
del mp3.exe
del ed.exe
del darkcfg.exe
del speech2.exe
del ntexmod.dll
dcc32 ntexmod.dpr -CG -Q -B+ -$B- -$D- -$A8+ -$Q- -$R- -$L- -$M- -$O+ -$W- -$Y- -$Z1- -$J- -$C- -$U- -$I-
dcc32 mp3.dpr -CG -Q -B+ -$B- -$D- -$A8+ -$Q- -$R- -$L- -$M- -$O+ -$W- -$Y- -$Z1- -$J- -$C- -$U- -$I- -U.\Units 
dcc32 ed.dpr -CG -Q -B+ -$B- -$D- -$A8+ -$Q- -$R- -$L- -$M- -$O+ -$W- -$Y- -$Z1- -$J- -$C- -$U- -$I- -U.\ovc\source
dcc32 darkcfg.dpr -CG -Q -B+ -$B- -$D- -$A8+ -$Q- -$R- -$L- -$M- -$O+ -$W- -$Y- -$Z1- -$J- -$C- -$U- -$I-
dcc32 speech2.dpr -Q -CG -B+ -$B- -$D- -$A8+ -$Q- -$R- -$L- -$M- -$O+ -$W- -$Y- -$Z1- -$J- -$C- -$U- -$I-
echo Deleting new dcu....
del *.dcu
del *.ddp
echo Packing...
call c:\utils\upx.cmd ntexmod.dll
call c:\utils\upx.cmd mp3.exe
call c:\utils\upx.cmd darkcfg.exe
call c:\utils\upx.cmd ed.exe
call c:\utils\upx.cmd speech2.exe
echo Creating archive...
copy /b mini.sfx tmp.sfx
call c:\utils\upx.cmd tmp.sfx
del xampinst.exe
d:\progra~1\winrar\rar.exe a -m5 -s -sfxtmp.sfx -iiconcd.ico -zcmt.txt xampinst.exe *.dll mp3.exe darkcfg.exe ed.exe speech2.exe voice.cfg hotcd.url options.darkcfg