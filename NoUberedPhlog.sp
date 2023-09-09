// This code is entirely untested in a TF2 game running sourcemod and may not work.

#include <tf2>
#include <tf2_stocks>
#include "vsh2_modules/stocks.inc"

public Plugin myInfo = {
	
	name = "No Ubered Phlogs",
	author = "Krelinos",
	description = "Disallows ubercharge on phlog wielding Pyros.",
	version = "1.0",
	url = ""
	
};

public void OnPluginStart(){
}

public void OnMapStart(){
	CreateTimer(0.1, Timer_PlayerThink, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_PlayerThink(Handle hTimer){
	
	for( int i = 1; i < MaxClients; i++ ){
	
		if( !IsValidClient(i, false) || !IsPlayerAlive(i) ) //In stocks.inc
			continue;
		
		TFClassType TFClass = TF2_GetPlayerClass(i);
		int weapon = GetActiveWep(i); //In stocks.inc
		int itemIndex = GetItemIndex(weapon); //Also in stocks.inc
		
		// Solution 1
		// Check all Pyro players if they are ubered, and remove the status effect if so.
		// This has the side effect of also removing the uber during the phlog crit taunt.
		/*
		if( TFClass == TFClass_Pyro		// This ticked player is playing Pyro
				&& itemIndex == 594		// 594 is phlog according to https://wiki.alliedmods.net/Team_fortress_2_item_definition_indexes#Primary_.5BSlot_0.5D_3
				&& TF2_IsPlayerInCondition(i, TFCond_Ubercharged)		// Player has the uber status effect
			)
		{
			TF2_RemoveCondition(i, TFCond_Ubercharged);
		}
		*/
		
		// Solution 2
		// Check all Medic players if they have a patient and popped stock uber.
		// If their patient is a phlog pyro, remove uber.
		// This will keep the phlog uber taunt, probably. If the Medic has a popped ubercharge
		// and heals the taunting Pyro, then the uber will go away.
		/*
		if( TFClass == TFClass_Medic
				&& itemIndex == 29		// Stock medigun
				&& GetEntProp( GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary), Prop_Send, "m_bChargeRelease" )
			)
		{
			int patient = GetHealingTarget(i);
			
			if( !IsValidClient(patient, false) || !IsPlayerAlive(patient) ) // Not sure if this is needed, but probably a good safety measure.
				continue;
			
			if( TF2_GetPlayerClass(patient) == TFClass_Pyro && TF2_IsPlayerInCondition(patient, TFCond_Ubercharged )
				TF2_RemoveCondition(patient, TFCond_Ubercharged);
		}
		*/
		
	}

}
