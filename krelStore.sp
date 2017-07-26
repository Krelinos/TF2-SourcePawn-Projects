#include <tf2>
#include <tf2_stocks>
#include "vsh2_modules/stocks.inc"

public Plugin myInfo = {
	
	name = "Krel Server Store",
	author = "Krelinos",
	description = "Store system for my server.",
	version = "1.0",
	url = ""
	
};

public void OnPluginStart(){
	
	RegConsoleCmd("sm_krelstore", Menu_Test);
	
}

public Action Menu_Test( int client, int args ){


}