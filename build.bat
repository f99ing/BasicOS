
nasm -f bin -o myfirst.bin basicOS.asm
copy /b myfirst.bin myfirst.flp  
copy myfirst.flp .\cdiso
mkisofs -no-emul-boot -boot-load-size 4 -o myfirst.iso -b myfirst.flp cdiso/
 
 pause