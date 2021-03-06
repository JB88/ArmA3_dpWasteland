//	@file Name: inviteToGroup.sqf
//	@file Author: [404] Deadbeat

if(player != leader group player) exitWith {player globalChat format["you are not the leader and can't invite people"];};

#define groupManagementDialog 55510
#define groupManagementPlayerList 55511

disableSerialization;

private["_dialog","_playerListBox","_groupInvite","_target","_index","_playerData","_check","_unitCount","_hasInvite"];

_dialog = findDisplay groupManagementDialog;
_playerListBox = _dialog displayCtrl groupManagementPlayerList;

_index = lbCurSel _playerListBox;
_playerData = _playerListBox lbData _index;
_hasInvite = false;
_check = 0;

//Check selected data is valid
{if (str(_x) == _playerData) then {_target = _x;_check = 1;};}forEach playableUnits;

//Checks
if(_check == 0) exitWith{player globalChat "you must select someone to invite first";};
if(_target == player) exitWith {player globalChat "you can't invite yourself";};
if((count units group _target) > 1) exitWith {player globalChat "This player is already in a group"};

{if(_x select 1 == getPlayerUID _target) then{_hasInvite = true;};}forEach currentInvites;
if(_hasInvite) exitWith {player globalChat "This player already has a pending invite";};

currentInvites set [count currentInvites,[getPlayerUID player,getPlayerUID _target]];
publicVariableServer "currentInvites";

//[nil,_target,"loc", rTITLETEXT, format["You have been invited to join %1's group",name player], "PLAIN", 0] call RE;

player globalChat format["you have invited %1 to join the group",name _target];