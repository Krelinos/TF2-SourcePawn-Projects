#include <tf2>
#include <tf2_stocks>

public Plugin myInfo = {
	
	name = "Heavy Minicrits",
	author = "Krelinos",
	description = "All heavies get permanent minicrits!",
	version = "1.0",
	url = ""
	
};

public void OnPluginStart(){

	//HookEvent("teamplay_round_active", event_round_active);
	if( !HookEventEx("player_spawn", event_player_SpawnRegenerateOrChangeClass, EventHookMode_Post) ||
			!HookEventEx("post_inventory_application", event_player_SpawnRegenerateOrChangeClass, EventHookMode_Post) ||
			!HookEventEx("player_changeclass", event_player_SpawnRegenerateOrChangeClass, EventHookMode_Post) ){
		SetFailState("Failed to hook events.");
	}

}

public Action:event_player_SpawnRegenerateOrChangeClass( Handle:event, const String:name[], bool:dontBroadcast ){

	new client = GetClientOfUserId( GetEventInt(event, "userid") );
	
	if( TF2_GetPlayerClass( client ) == TFClass_Heavy )
		CreateTimer(0.25, Timer_giveMinicrits, client);

}

public Action:Timer_giveMinicrits( Handle:timer, any:client ){
	if( IsClientInGame( client ) && TF2_GetPlayerClass( client ) == TFClass_Heavy ){
		TF2_AddCondition( client, TFCond_Buffed, 999.0 );
		//PrintToChatAll( "Someone gots the minicrits!" );
	}
}