
HOST_NAME="H3" 

find $HOME  -maxdepth 1 -name ".$HOST_NAME*"  -type d ! -path  "/home/ubbe/.h3" | xargs -r rm -rf 
find   $HOME/.local/share/applications/ -name "*$HOST_NAME*" | xargs -r rm -rf 
find   $HOME/.local/bin/ -name  "*$HOST_NAME*" | xargs -r rm -rf 



# find   $HOME/.local/share/applications/ -name "Tele*" | xargs rm -rf 
# find   $HOME/.local/bin/ -name "Tele*" | xargs rm -rf 





docker ps -a | grep 'Telegram' | grep "$HOST_NAME" | xargs -r docker rm  



