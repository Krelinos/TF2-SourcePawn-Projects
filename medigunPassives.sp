#include <tf2>
#include <tf2_stocks>
#include "vsh2_modules/stocks.inc"

public Plugin myInfo = {
	
	name = "Medigun Passives",
	author = "Krelinos",
	description = "Mediguns provide different conditions based on what uber they give.",
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
		
		switch (TFClass) {
			case TFClass_Medic:{
				int medigun = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
				//char mediclassname[32];

				if (weapon == GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary))
				{
					int healtarget = GetHealingTarget(i);
					if (IsValidClient(healtarget)){
						switch( TF2_GetPlayerClass(healtarget) ){
						
							case TFClass_Heavy:{ //Heavies receive strong passive conditions
								if( itemIndex == 29 ) //Normal medigun
									TF2_AddCondition(healtarget, TFCond_UberchargedOnTakeDamage, 0.2);
								else if( itemIndex == 35 ) //Kritzkrieg
									TF2_AddCondition(healtarget, TFCond_CritOnDamage, 0.2);
							}
							default:{ //Other classes just get a smaller bonus
								if( itemIndex == 29 ) //Normal medigun
									TF2_AddCondition(healtarget, TFCond_DefenseBuffed, 0.2);
								else if( itemIndex == 35 ) //Kritzkrieg
									TF2_AddCondition(healtarget, TFCond_Buffed, 0.2);
							}
							
						}
					}
						
					//if (GetEntProp(medigun, Prop_Send, "m_bChargeRelease") && GetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel") > 0.0)
					//	TF2_AddCondition(i, TFCond_Ubercharged, 1.0); //Fixes Ubercharges ending prematurely on Medics.
				}
				if (medigun == -1)
					return;
				//float oober = GetEntPropFloat(medigun, Prop_Send, "m_flChargeLevel");
				//if ( GetHealingTarget(i) == -1 && TF2_IsPlayerInCondition(i, TFCond_Ubercharged) && oober <= 0)
				//	TF2_RemoveCondition(i, TFCond_Ubercharged);
			}
		}
	}

}