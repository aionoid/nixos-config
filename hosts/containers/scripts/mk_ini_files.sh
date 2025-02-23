#!/usr/bin/env bash

# Define the content to be written to each file setup.ini and config.ini

server_address="$1"
db_password="$2"
db_members="$3"
db_account="$4"
db_gateway="$5"
db_username="$6"

#TODO:CHANGE ME LATER db_account in place of db_gateway
gateway_server_setup="[Common]
AccountDBIP=${server_address}
AccountDBName=${db_gateway}
AccountDBUser=${db_username}
AccountDBPW=${db_password}
BillingGatewayPort=5560
HttpServerPort=7878
"

mkdir -p "/root/server/GatewayServer"
echo "$gateway_server_setup" > "/root/server/GatewayServer/setup.ini"             # Write the content to the file
login_server_setup="[LoginServer]
LoginServerPort=6543"

mkdir -p "/root/server/LoginServer"
echo "$login_server_setup" > "/root/server/LoginServer/setup.ini"             # Write the content to the file

mkdir -p "/root/server/TicketServer"
ticket_server_setup="TicketServerIP=${server_address}
TicketServerPort=7777"
echo "$ticket_server_setup" > "/root/server/TicketServer/setup.ini"             # Write the content to the file

# Define the content to be written to each file
content="# Cross World ID
CrossWorldID=__CrossWorldID__
# Territory World ID
TerritoryWorldID=__TerritoryWorldID__
# Colosseum World ID
ColosseumWorldID=__ColosseumWorldID__
"
# Loop to create files config00.ini to config09.ini
for i in {0..9}; do
    filename=$(printf "config%02d.ini" "$i")  # Format the filename with leading zero
    echo "$content" > "/root/server/$filename"             # Write the content to the file
    echo "Created $filename"
done
echo "created config0N.ini files successfully!"

config_ini="
[FUNCTIONSWITCH]
MAXLevel=120
ItemMall=1
Strengthen=1
Combine=1
FamilyMAXLV=10
Raid=1
LimitPlayerNode=2,3,4,5,6,7,8,14,16,17,21,22,23,602
LimitPlayerCount=50,50,50,50,50,50,50,50,50,50,50,50,30,50
SurvivalMode=1
SecondPassword=0
FightSwitch=1
RankSwitch=1
RandomTeam=0
Level50NewCharacter=1
ItemModified=1
FortuneBagAutoBind=1
FishingSwitch=1
SkyTowerSwitch=1
PartnerChangeSkin=1
MaxRemoveCharDaily=4
Level60NewCharacter=1
NoApex=0
FriendLevel=1
WeaponCase=1
LotteryAlchemy=1
ExtraDropItem=1
PVPBuffExp=1
PartnerChangeStarSkin=1
Archeology=1
FamilyDiagram=1
FamilyDiagramReset=1
DailyItemmallGift=1
AmuletSwitch=1
EquipEvolution=1
FamilySkyTower=1
ChangeSecondWeapon=1
SkyTowerTopLevel=2
BindAfterCombine=1
RecommendActivity=1
CookingSwitch=1
CardSystem=1
ItemMallDress=1
ProduceStorage=1
NewStorageRule=1
SpecialStorage=1
NewWeaponLevelLimit=1
PlusDropItem=1
WeaponExpert=1
EudemonMission=1
ItemMallWeekUpdate=3
FightSortCapabilities=1
SkyFairyLand=1
PartnerChangeBuff=1
NewTypeStrengthen=1
SkyTowerIDDailyReset=1
CoupleSystem=1
Flower2Godess=1
Flower2Male=1
FreeFaceChange=1
GoldenDKP=1
EudemonBattle=1
CollectionBook=1
AccountRoom=1
Itemlocked=1
BlockCreateWeapon=0
SkyTowerMemberManage=1
StrengthenVer3=1
FishingAtlas=1
AccountRanch=1
CustomBattlefield=1
Marriage=1
FamilyOptimization=1
SwitchNormalEquip=0
MountsEquipment=1
ItemMallRideMix=4
ItemmallCharacter=1
CreateLevelUp=1
EudemonCollect=1
InventoryExtend=1
EudemonPledge=1
GemEvolution=1
CheckDaily=1
AccountAccumulatedDKP=1
CardUpgrade=1
FamilyBattle=1
FamilyOptimizationII=1
HeroIntegral=1
EudemonDormitory=1
CreateCharKusoEquip=1
EudemonDivination=25
EudemonMissionItem=1
ItemmallNumLimitDeadLine=20200714
SurviveBattle=1
ElfSpellStrengthen=1
SacredSoul=1
SurviveBattleBagSlotLimit=12
CustomCharacterIcon=1
ElfAttrAttachOptimization=1
FamilyGame=1
SocialShareExtend=1
ItemMallAccountLimit=1
LoginCaptcha=0
EventCaptcha=0
CharForcePW=0
MACAddress=1
CastingWeapon=1
SearchTeam=1
#LimitNode=1
#LimitWorld=1
#TerritorySwitch=1
#RuneRefine=
TwoPassword=0
TalkGroup=1
develope=1
PayReward=1
FamilyAuction=1
RecommendedEvent=1
HuntingRace=1
RankInfo=1
VoiceSound=1
TwoPasswordErrorCount=6
FamilyHuntingRace=1
WarCampWeakPrestige=1
RootOutMission=1
ManorRanchInvader=1
ItemMallDailyLimit=4
MaxCharacterNumber=12
ManorBanquet=1
ProduceMining=1
ElfFormation=1
ManageEngineering=1

[FunctionSwitch]
Capcha=0
Carving=1
LV100AA=1
NodeLimit=1
Elftablet=1
RecruitLink=1
AutoLottery=1
MonsterInfo=1
ServerExtraLog=1
RejectLookEquip=1
AutoClickPunish=1
AutoBanNoMotion=0
SerialNumberNewWndV2=1
CheckClientMotionTime=1
ShowLotteryProbability=1
"
setup_ini="
[Common]
GameDBIP=${server_address}
GameDB=${db_members}
GameDBUser=${db_username}
GameDBPassword=${db_password}
Language=X
Locate=US
LogFile=Test.log
AccountDBIP=${server_address}
AccountDBName=${db_account}
AccountDBUser=${db_username}
AccountDBPW=${db_password}
TicketServerIP=${server_address}
TicketServerPort=7777
BillingGatewayIP=${server_address}
BillingGatewayPort=5560
PingAlive=0
FBMsgUpdate=1
Battlefield=1
FamilyBattle=1
CrossWorldID=1090
TerritoryWorldID=1090
ColosseumWorldID=1090
GreedyIslandWorldID=1090
BattleRoyaleWorldID=1090
MaintenanceDate=-1
RankAward=1
NAT=1
AchievementGroupCheck=0
MemoryCheck=0
MemoryCheckTime=120
MemoryCheckSavingTime=300
MaxCharacterNumber=9
LuckyStarOpen=1
IsleWorldID=1090
BotServer=1
XTrap=0
BillingGatewayPaymentIP=${server_address}
BillingGatewayPaymentPort=5560
BillingGatewayWorldIP=${server_address}
BillingGatewayWorldPort=5560
FightZoneWroldID=1090

[MissionServer]
ReserveDeletedCharDays=30
DBAgentSavePeriod=20
MissionServerLogLevel=3
MissionServerAssert=0
GoldRange=10000.50000.100000.200000.500000.1000000.2000000.3000000.10000000.100000000
RecordGoldvalue=1000000
PlayerRoomWorldID=1090
CheckPetToEgg=1
ItemMallWeekUpdate=3

[WorldServer]
LoadServerStatus=1
WorldServerLogLevel=3
WorldServerAssert=0
FarmWorldID=1090
PlayerRoomWorldID=1090

[ZoneServer]
HeartBeat=1
PlayerRoomWorldID=1090
"
echo "$config_ini" > "/root/server/config.ini"
echo "$setup_ini" > "/root/server/setup.ini"
echo "created /root/server/[setup.ini config.ini] successfully!"
