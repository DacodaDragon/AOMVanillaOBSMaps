/* ******************************************************************************************************
** RMS LIBRARY
** 15th February 2017
** RebelsRising
** 26th July 2017
** DaCoda
** *****************************************************************************************************/

/* ******
** GLOBAL
** *****/

extern int cTeams = 0;
extern int cNonGaiaPlayers = 0;
extern int cPlayers = 0;
extern int failCount = 0;

extern bool obs = false;

extern string map = "";
extern string msg = "";

/* *****
** LOCAL
** ****/

int cPlayersObs = 0;

string patch = "Voobly Balance Patch 2.0";



/* ******
** ARRAYS
** *****/

int player1 = 1; int player2  = 2;  int player3  = 3;  int player4  = 4;
int player5 = 5; int player6  = 6;  int player7  = 7;  int player8  = 8;
int player9 = 9; int player10 = 10; int player11 = 11; int player12 = 12;

int getPlayer(int p = 0) {
	if(p == 1) return(player1); if(p == 2)  return(player2);  if(p == 3)  return(player3);  if(p == 4)  return(player4);
	if(p == 5) return(player5); if(p == 6)  return(player6);  if(p == 7)  return(player7);  if(p == 8)  return(player8);
	if(p == 9) return(player9); if(p == 10) return(player10); if(p == 11) return(player11); if(p == 12) return(player12);
	return(0);
}

void setPlayer(int p = 0, int n = 0) {
	if(p == 1) player1 = n; if(p == 2)  player2  = n; if(p == 3)  player3  = n; if(p == 4)  player4  = n;
	if(p == 5) player5 = n; if(p == 6)  player6  = n; if(p == 7)  player7  = n; if(p == 8)  player8  = n;
	if(p == 9) player9 = n; if(p == 10) player10 = n; if(p == 11) player11 = n; if(p == 12) player12 = n;
}

string godID1 = ""; string godID2  = ""; string godID3  = ""; string godID4  = "";
string godID5 = ""; string godID6  = ""; string godID7  = ""; string godID8  = "";
string godID9 = ""; string godID10 = ""; string godID11 = ""; string godID12 = "";

string getGod(int p = 0) {
	if(p == 1) return(godID1); if(p == 2)  return(godID2);  if(p == 3)  return(godID3);  if(p == 4)  return(godID4);
	if(p == 5) return(godID5); if(p == 6)  return(godID6);  if(p == 7)  return(godID7);  if(p == 8)  return(godID8);
	if(p == 9) return(godID9); if(p == 10) return(godID10); if(p == 11) return(godID11); if(p == 12) return(godID12);
	return("");
}

void setGod(int p = 0, string s = "") {
	if(p == 1) godID1 = s; if(p == 2)  godID2  = s; if(p == 3)  godID3  = s; if(p == 4)  godID4  = s;
	if(p == 5) godID5 = s; if(p == 6)  godID6  = s; if(p == 7)  godID7  = s; if(p == 8)  godID8  = s;
	if(p == 9) godID9 = s; if(p == 10) godID10 = s; if(p == 11) godID11 = s; if(p == 12) godID12 = s;
}

void initGods() {
	for(i = 1; < cPlayers) {
		if(rmGetPlayerCiv(getPlayer(i)) == cCivZeus) {
			setGod(getPlayer(i), "Zeus");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivPoseidon) {
			setGod(getPlayer(i), "Poseidon");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivHades) {
			setGod(getPlayer(i), "Hades");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivRa) {
			setGod(getPlayer(i), "Ra");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivIsis) {
			setGod(getPlayer(i), "Isis");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivSet) {
			setGod(getPlayer(i), "Set");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivOdin) {
			setGod(getPlayer(i), "Odin");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivThor) {
			setGod(getPlayer(i), "Thor");
		} else if(rmGetPlayerCiv(getPlayer(i)) == cCivLoki) {
			setGod(getPlayer(i), "Loki");
		}
	}
}

/* Sorts the players in team order.
** Required by most functions in this library.
**
** @param obs: whether to prepare for observer mode or not
** @returns:
*/
void initPlayers(bool observer = false) {	
	obs = observer;
	
	if(cNumberTeams == 2) {
		obs = false;
	}
	
	if(obs == false) {
		cTeams = cNumberTeams;
		cNonGaiaPlayers = cNumberNonGaiaPlayers;
		cPlayers = cNumberPlayers;
	} else {
		cTeams = cNumberTeams - 1;
		cNonGaiaPlayers = 0;
		for(i = 0; < cTeams) {
			cNonGaiaPlayers = cNonGaiaPlayers + rmGetNumberPlayersOnTeam(i);
		}
		cPlayers = cNonGaiaPlayers + 1;
		cPlayersObs = cNumberPlayers;
	}
	
	int count = 0;
	for(t = 0; < cNumberTeams) {
		for(p = 1; <= cNumberNonGaiaPlayers) {
			if(rmGetPlayerTeam(p) == t) {
				count = count + 1;
				setPlayer(count, p);
			}
		}
	}
	
	if(rmGetPlayerName(cNumberPlayers) == ("Player " + (cNumberPlayers))) {
		cPlayersObs = cNumberPlayers + 1;
		
		while(rmGetPlayerName(cPlayersObs) == ("Player " + (cPlayersObs))) {
			cPlayersObs++;
		}
	} else if(cPlayersObs == 0) { // for testing only, remove later (check initNote too)
		cPlayersObs = cNumberPlayers + 1;
	}
	
	initGods();
}

int createTrigger(string trigger = "", bool act = false, bool loop = false, bool run = false, int prior = 3) {
	int triggerID = rmCreateTrigger(trigger);
	rmSwitchToTrigger(triggerID);
	rmSetTriggerActive(act);
	rmSetTriggerLoop(loop);
	rmSetTriggerRunImmediately(run);
	rmSetTriggerPriority(prior);
	
	return(triggerID);
}

/* Initializes observer mode. Should be called after all objects have been placed.
**
** @returns:
*/
void initObs() {
	int obsID = rmCreateObjectDef("obs");
	rmAddObjectDefItem(obsID, "Obs", 1, 0.0);
	
	// Observer Initialization
	for(i = cPlayers; < cNumberPlayers) {
		// Create Observer Object to prevent obs from dying..
		rmPlaceObjectDefAtLoc(obsID, i, 0.5, 0.5);
		
		// Create Trigger to place effects in..
		createTrigger("Observer Player" + i);
		rmSetTriggerPriority(100);
		rmSetTriggerActive(true);
		
		// Omniscience
		rmAddTriggerEffect("Set Tech Status");
		rmSetTriggerEffectParam("PlayerID",""+i,false);
		rmSetTriggerEffectParam("TechID", "305", false);
		rmSetTriggerEffectParam("Status", "4", true);
	
		// Kill GP
		rmAddTriggerEffect("Player Kill All God Powers");
		rmSetTriggerEffectParam("Player",""+i,false);
		
		// Remove Resources
		rmAddTriggerEffect("Grant Resources");
		rmSetTriggerEffectParam("PlayerID",""+i,false);
		rmSetTriggerEffectParam("ResName","food",false);
		rmSetTriggerEffectParam("Amount",""+(-1000),false);
		
		rmAddTriggerEffect("Grant Resources");
		rmSetTriggerEffectParam("PlayerID",""+i,false);
		rmSetTriggerEffectParam("ResName","wood",false);
		rmSetTriggerEffectParam("Amount",""+(-1000),false);
		
		rmAddTriggerEffect("Grant Resources");
		rmSetTriggerEffectParam("PlayerID",""+i,false);
		rmSetTriggerEffectParam("ResName","gold",false);
		rmSetTriggerEffectParam("Amount",""+(-1000),false);
		
		rmAddTriggerEffect("Grant Resources");
		rmSetTriggerEffectParam("PlayerID",""+i,false);
		rmSetTriggerEffectParam("ResName","favor",false);
		rmSetTriggerEffectParam("Amount",""+(-1000),false);
	}
	
	// Victory Conditions
	for (team=0; < cTeams) 
	{
		createTrigger("Victory_Team" + team);
		rmSetTriggerPriority(100);
		rmSetTriggerActive(true);
		
		// Check if all players in other teams are defeated..
		for (player=1; < cPlayers)
		{
			if (team != rmGetPlayerTeam(player))
			{
				// This has been replaced by a defeat check function in Typetest.xml
				rmAddTriggerCondition("Gadget Visible");
				rmSetTriggerConditionParam("PlayerID",""+player);
			}
		}
		
		// Kill Observers to end map.
		for(observer = cPlayers; < cNumberPlayers)
		{
			rmAddTriggerEffect("Set Player Defeated");
			rmSetTriggerEffectParam("Player",""+observer,false);
		}
	}	
}

//****** MAP RELATED

void PlaceDefNearPlayers(int objectDef = 0, bool ownedByPlayers = false, int placecount = 1)
{
	for (i = 1; < cPlayers)
	{
		if (ownedByPlayers)
		{
			for (j = 0; < placecount)
			{
				rmPlaceObjectDefAtLoc(objectDef, i, rmPlayerLocXFraction(getPlayer(i)), rmPlayerLocZFraction(getPlayer(i)));
			}
		}
		else
		{
			for (j = 0; < placecount)
			{
				rmPlaceObjectDefAtLoc(objectDef, 0, rmPlayerLocXFraction(getPlayer(i)), rmPlayerLocZFraction(getPlayer(i)));
			}
		}
	}
}