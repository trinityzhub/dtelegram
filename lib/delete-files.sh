
HOST_NAME="H3" 

find $HOME  -name ".$HOST_NAME*" -maxdepth 1 -type d ! -path  "/home/ubbe/.h3" | xargs rm -r 
find   $HOME/.local/share/applications/ -name "*$HOST_NAME*" | xargs rm -rf 
find   $HOME/.local/bin/ -name  "*$HOST_NAME*" | xargs rm -rf 



# find   $HOME/.local/share/applications/ -name "Tele*" | xargs rm -rf 
# find   $HOME/.local/bin/ -name "Tele*" | xargs rm -rf 





docker ps -a | grep 'Telegram' | grep "$HOST_NAME" | xargs -r docker rm  



