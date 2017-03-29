A [soldat server](http://soldat.pl) docker implementation. This will automatically ensure you're running the latest soldat server version; if desired.

# Installation

## Using Docker Hub Server

- `docker pull vertigoray/docker-soldat`

## Default Settings

- Admin Password = admin
- Gamer Password = 123456
- UDP: game port (default 23073)
- TCP: admin port = game port (default 23073)
- TCP: files port = game port + 10 (default 23083)
- Only the weapon *Desert Eagles* is available. 

# Config

Configuration options are done via environment variables on the container. 

Here's the download configs:

| Environment Variable | Default Value | Notes |
| -------------------- | ------------- | ----- |
| SOLDAT_DOWNLOAD_INDEX_URL | `https://static.soldat.pl/downloads` | *No trailing slash.* |
| SOLDAT_VERSION | Latest Version | This is the number in the `soldatserver` zip file name at the download index url (ie: `soldatserver2.8.0_1.7.0rc2.zip` is version `2.8.0_1.7.0rc2`) |

Additionally, anything in the `soldat.ini` and `server.ini` is configurable via environment variables using the following, respective variable naming convention:

```
SOLDAT_INI_%SECTION%_%Keys%=%Value%
SERVER_INI_%SECTION%_%Keys%=%Value%
```

- `SOLDAT_INI` will add settings to the [`soldat.ini`](https://wiki.soldat.pl/index.php/Soldat.ini)
- `SERVER_INI` will add settings to the [`server.ini`](https://wiki.soldat.pl/index.php/Server.ini)
- `%SECTION%` should be replaced with the [section name](https://en.wikipedia.org/wiki/INI_file#Sections).
    - The section is the
    - At the time of this writting, the sections are: `BOTS`, `GAME`, and `NETWORK`
- `%Keys%` should be replaced with the setting's [key name](https://en.wikipedia.org/wiki/INI_file#Keys_.28properties.29); here are some examples of common settings:
    - `Game_Password`
    - `Admin_Password`
    - `Server_Name`
- `%Value%` should be replaced with the setting's [value](https://en.wikipedia.org/wiki/INI_file#Keys_.28properties.29); here are some examples of common settings:

***Note:*** *The case you use will preserved. Stick to [case-sensitivity](https://en.wikipedia.org/wiki/INI_file#Case_insensitivity) as depecited in the [soldat](https://wiki.soldat.pl/index.php/Soldat.ini) and [server](https://wiki.soldat.pl/index.php/Server.ini) ini wiki articles, and you will likely have success. I've not tested all case-variations.*

Here's a quick sample:

```
SOLDAT_INI_GAME_Debug_Mode=1
SOLDAT_INI_NETWORK_Max_Players=10
SOLDAT_INI_BOTS_Raycasting_Quality=5
SERVER_INI_GAME_TKWarnings_Before_TempBan=5
SERVER_INI_NETWORK_OnScriptCrash=recompile
```

## Default Config

| Environment Variable | Default Value | Notes |
| -------------------- | ------------- | ----- |
| SOLDAT_INI_GAME_Weapon_1 | `1` | *Desert Eagles* |
| SOLDAT_INI_NETWORK_Admin_Password | `admin` | |
| SOLDAT_INI_NETWORK_Game_Password | `123456` | |
| SOLDAT_INI_NETWORK_Greeting_Message | `Welcome to Vertigion. You are born to kill.` | |
| SOLDAT_INI_NETWORK_Port | `23073` | *Probably should never change this.* |
| SOLDAT_INI_NETWORK_Server_Name | `Vertigion Server` | |
| SOLDAT_INI_NETWORK_Server_Info | `Server running in Docker (vertigoray/docker-soldat). Courtesy of Vertigion (http://vertigion.com).` | |

If I've missed something that should have a default, please [submit an issue](https://github.com/VertigoRay/docker-soldat/issues).

## Config Example: Generic

To set `Bar` to `Hello World!` in the `FOO` section:

```bash
docker run \
  -e "SOLDAT_INI_FOO_Bar=Hello World!" \
  vertigoray/docker-soldat
```

***Note:*** *Obviously, this setting does nothing, but it would appear in the `soldat.ini` file.*

## Config Example: Real

To ensure soldat server version `2.8.1_1.7.1` is downloaded from `https://static.soldat.pl/downloads` with a different *admin password*; use the following:

```bash
docker run \
  -e "SOLDAT_DOWNLOAD_INDEX_URL=https://static.soldat.pl/downloads" \
  -e "SOLDAT_VERSION=2.8.1_1.7.1" \
  -e "SOLDAT_INI_NETWORK_Admin_Password=algebraic" \
  vertigoray/docker-soldat
```

***Note:*** *This will download the following server zip file:* https://static.soldat.pl/downloads/soldatserver2.8.1_1.7.1.zip

# Default INI Settings

This is the output of the Soldat Server launching. You can see the defaults that it sets based on launching with my default settings. **Notice the weapons all default to `0` (aka: disabled) unless you explicitely define the weapons to use.**

For an authoritive source on ini settings, check out [the Soldat Wiki article](https://wiki.soldat.pl/index.php/Soldat.ini).

```
             -= Soldat Dedicated Server 1.7.1 - 2.8.1 =-

----------------------------------------------------------------
         Soldat Dedicated Server initializing...
----------------------------------------------------------------

   Need help running your server?
   IRC: #soldat.devs @ irc.quakenet.org

   ---> https://soldatforums.com/

   Additional parameters:
   ./soldatserver -p PORT -l MAXPLAYERS -k PASSWORD
   Example: ./soldatserver -p 23073 -l 16 -k "my pass"


 Compiled with FreePascal (Indy 10)

SOLDAT.INI: "Debug_Mode" not found. Using default: Debug_Mode=0
SOLDAT.INI: "Respawn_Time" not found. Using default: Respawn_Time=180
SOLDAT.INI: "MinWaveRespawn_Time" not found. Using default: MinWaveRespawn_Time=120
SOLDAT.INI: "MaxWaveRespawn_Time" not found. Using default: MaxWaveRespawn_Time=240
SOLDAT.INI: "Deathmatch_Limit" not found. Using default: Deathmatch_Limit=30
SOLDAT.INI: "Pointmatch_Limit" not found. Using default: Pointmatch_Limit=30
SOLDAT.INI: "Teammatch_Limit" not found. Using default: Teammatch_Limit=50
SOLDAT.INI: "Capture_Limit" not found. Using default: Capture_Limit=8
SOLDAT.INI: "Rambomatch_Limit" not found. Using default: Rambomatch_Limit=30
SOLDAT.INI: "Infiltration_Limit" not found. Using default: Infiltration_Limit=30
SOLDAT.INI: "Hold_Limit" not found. Using default: Hold_Limit=30
SOLDAT.INI: "GameStyle" not found. Using default: GameStyle=0
SOLDAT.INI: "Friendly_Fire" not found. Using default: Friendly_Fire=1
SOLDAT.INI: "Guns_Collide" not found. Using default: Guns_Collide=0
SOLDAT.INI: "Kits_Collide" not found. Using default: Kits_Collide=0
SOLDAT.INI: "Bonus_Frequency" not found. Using default: Bonus_Frequency=2
SOLDAT.INI: "Bonus_FlameGod" not found. Using default: Bonus_FlameGod=0
SOLDAT.INI: "Bonus_Predator" not found. Using default: Bonus_Predator=0
SOLDAT.INI: "Bonus_Berserker" not found. Using default: Bonus_Berserker=0
SOLDAT.INI: "Bonus_Vest" not found. Using default: Bonus_Vest=0
SOLDAT.INI: "Bonus_Cluster" not found. Using default: Bonus_Cluster=0
SOLDAT.INI: "Time_Limit" not found. Using default: Time_Limit=0
SOLDAT.INI: "Survival_Mode" not found. Using default: Survival_Mode=0
SOLDAT.INI: "Survival_Clear_Weapons" not found. Using default: Survival_Clear_Weapons=0
SOLDAT.INI: "Realistic_Mode" not found. Using default: Realistic_Mode=0
SOLDAT.INI: "Weapons_Mode" not found. Using default: Weapons_Mode=0
SOLDAT.INI: "Weapon_2" not found. Using default: Weapon_2=0
SOLDAT.INI: "Weapon_3" not found. Using default: Weapon_3=0
SOLDAT.INI: "Weapon_4" not found. Using default: Weapon_4=0
SOLDAT.INI: "Weapon_5" not found. Using default: Weapon_5=0
SOLDAT.INI: "Weapon_6" not found. Using default: Weapon_6=0
SOLDAT.INI: "Weapon_7" not found. Using default: Weapon_7=0
SOLDAT.INI: "Weapon_8" not found. Using default: Weapon_8=0
SOLDAT.INI: "Weapon_9" not found. Using default: Weapon_9=0
SOLDAT.INI: "Weapon_10" not found. Using default: Weapon_10=0
SOLDAT.INI: "Weapon_11" not found. Using default: Weapon_11=0
SOLDAT.INI: "Weapon_12" not found. Using default: Weapon_12=0
SOLDAT.INI: "Weapon_13" not found. Using default: Weapon_13=0
SOLDAT.INI: "Weapon_14" not found. Using default: Weapon_14=0
SOLDAT.INI: "Max_Grenades" not found. Using default: Max_Grenades=0
SOLDAT.INI: "Random_Bots" not found. Using default: Random_Bots=0
SOLDAT.INI: "Random_Bots_1" not found. Using default: Random_Bots_1=0
SOLDAT.INI: "Random_Bots_2" not found. Using default: Random_Bots_2=0
SOLDAT.INI: "Random_Bots_3" not found. Using default: Random_Bots_3=0
SOLDAT.INI: "Random_Bots_4" not found. Using default: Random_Bots_4=0
SOLDAT.INI: "Logging" not found. Using default: Logging=1
SOLDAT.INI: "Stationary_Guns" not found. Using default: Stationary_Guns=1
SOLDAT.INI: "Bullet_Time" not found. Using default: Bullet_Time=0
SOLDAT.INI: "NoSniperLine" not found. Using default: NoSniperLine=0
SOLDAT.INI: "Advance_Amount" not found. Using default: Advance_Amount=3
SOLDAT.INI: "Blue_Points_Time" not found. Using default: Blue_Points_Time=300
SOLDAT.INI: "Red_Points_Capture" not found. Using default: Red_Points_Capture=30
SOLDAT.INI: "HTF_Points_Time" not found. Using default: HTF_Points_Time=300
SOLDAT.INI: "Radio" not found. Using default: Radio=1
SOLDAT.INI: "AntiSpy_Chat" not found. Using default: AntiSpy_Chat=0
SOLDAT.INI: "Lobby_Register" not found. Using default: Lobby_Register=1
SOLDAT.INI: "Max_Players" not found. Using default: Max_Players=24
SOLDAT.INI: "Clanmatch" not found. Using default: Clanmatch=0
SOLDAT.INI: "Internet_Connection" not found. Using default: Internet_Connection=0
SOLDAT.INI: "Min_Ping" not found. Using default: Min_Ping=0
SOLDAT.INI: "Max_Ping" not found. Using default: Max_Ping=1000
SOLDAT.INI: "Balance_Teams" not found. Using default: Balance_Teams=1
SOLDAT.INI: "Dont_Forward" not found. Using default: Dont_Forward=0
SOLDAT.INI: "Vote_Percent" not found. Using default: Vote_Percent=0.3300000131
SOLDAT.INI: "Compression" not found. Using default: Compression=1
SOLDAT.INI: "Max_Spectators" not found. Using default: Max_Spectators=3
SOLDAT.INI: "Spectator_Chat" not found. Using default: Spectator_Chat=1
SOLDAT.INI: "Allow_Download" not found. Using default: Allow_Download=1
SOLDAT.INI: "MaxConnections" not found. Using default: MaxConnections=0
SOLDAT.INI: "Flooding_Packets_LAN" not found. Using default: Flooding_Packets_LAN=80
SOLDAT.INI: "Flooding_Packets_Internet" not found. Using default: Flooding_Packets_Internet=42
SOLDAT.INI: "Vote_Cheat_Warnings" not found. Using default: Vote_Cheat_Warnings=8
SOLDAT.INI: "Max_KnifeCheat_Warnings" not found. Using default: Max_KnifeCheat_Warnings=14
SOLDAT.INI: "Disable_AntiCheat_Kick" not found. Using default: Disable_AntiCheat_Kick=0
SOLDAT.INI: "LogFilesUpdate" not found. Using default: LogFilesUpdate=3600
SOLDAT.INI: "Max_Flood_Warnings" not found. Using default: Max_Flood_Warnings=4
SOLDAT.INI: "Max_Ping_Warnings" not found. Using default: Max_Ping_Warnings=10
SOLDAT.INI: "T1_Snapshot" not found. Using default: T1_Snapshot=40
SOLDAT.INI: "T1_MajorSnapshot" not found. Using default: T1_MajorSnapshot=20
SOLDAT.INI: "T1_DeadSnapshot" not found. Using default: T1_DeadSnapshot=50
SOLDAT.INI: "T1_Heartbeat" not found. Using default: T1_Heartbeat=139
SOLDAT.INI: "T1_Delta" not found. Using default: T1_Delta=8
SOLDAT.INI: "T1_Ping" not found. Using default: T1_Ping=21
SOLDAT.INI: "T1_ThingSnapshot" not found. Using default: T1_ThingSnapshot=29
SOLDAT.INI: "Disable_Minimap" not found. Using default: Disable_Minimap=0
SOLDAT.INI: "Advanced_Spectate" not found. Using default: Advanced_Spectate=1
SOLDAT.INI: "Difficulty" not found. Using default: Difficulty=100
SOLDAT.INI: "Chat" not found. Using default: Chat=1
```

# Quick Swarm Server

**Warning:** This uses my default passwords so you might want to add settings to change those before doing `docker stack deploy`.

```bash
curl -O https://raw.githubusercontent.com/VertigoRay/docker-soldat/master/soldat.yml
sudo docker stack deploy -c soldat.yml soldat
```
