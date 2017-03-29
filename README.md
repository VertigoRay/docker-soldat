A [soldat server](http://soldat.pl) docker implementation. This will automatically ensure you're running the latest soldat server version; if desired.

# Installation

## Using Docker Hub Server

- `docker pull vertigoray/soldat`

# Default Settings

- UDP: game port (default 23073)
- TCP: admin port = game port (default 23073)
- TCP: files port = game port + 10 (default 23083) 
- Gamer Password = 123456
- Admin Password = admin

# Config

Configuration options are done via environment variables on the container. 

Here's the download configs:

| Environment Variable | Default Value | Notes |
| -------------------- | ------------- | ----- |
| SOLDAT_DOWNLOAD_INDEX_URL | `https://static.soldat.pl/downloads` | *No trailing slash.* |
| SOLDAT_VERSION | Latest Version | This is the number in the `soldatserver` zip file name at the download index url (ie: `soldatserver2.8.0_1.7.0rc2.zip` is version `2.8.0_1.7.0rc2`) |

Additionally, anything in the `soldat.ini` is configurable via environment variables using the following variable naming convention:

```
SOLDAT_INI_%SECTION%_%Setting_Name%
```

- `%SECTION%` should be replaced with the section name.
    - At the time of this writting, the sections are: `BOTS`, `GAME`, and `NETWORK`
- `%Setting_Name%` should be replaced with [the setting name](https://wiki.soldat.pl/index.php/Soldat.ini); here are some examples of common settings:
    - `Game_Password`
    - `Admin_Password`
    - `Server_Name`

## Default Config

| Environment Variable | Default Value | Notes |
| -------------------- | ------------- | ----- |
| SOLDAT_INI_NETWORK_Admin_Password | `admin` | |
| SOLDAT_INI_NETWORK_Game_Password | `123456` | |
| SOLDAT_INI_NETWORK_Greeting_Message | `Welcome to Vertigion. You are born to kill.` | |
| SOLDAT_INI_NETWORK_Port | `23073` | *Probably should never change this.* |
| SOLDAT_INI_NETWORK_Server_Name | `Vertigion Server` | |
| SOLDAT_INI_NETWORK_Server_Info | `Server running in Docker (vertigoray/soldat). Courtesy of Vertigion (http://vertigion.com).` | |

If I've missed something that should have a default, please [submit an issue](https://github.com/VertigoRay/docker-soldat/issues).

## Config Example: Generic

To set `Bar` to `Hello World!` in the `FOO` section:

```bash
docker run \
  -e "SOLDAT_INI_FOO_Bar=Hello World!" \
  vertigoray/soldat
```

***Note:*** *Obviously, this setting does nothing, but it would appear in the `soldat.ini` file.*

## Config Example: Real

To ensure soldat server version `2.8.1_1.7.1` is downloaded from `https://static.soldat.pl/downloads` with a different *admin password*; use the following:

```bash
docker run \
  -e "SOLDAT_DOWNLOAD_INDEX_URL=https://static.soldat.pl/downloads" \
  -e "SOLDAT_VERSION=2.8.1_1.7.1" \
  -e "SOLDAT_INI_NETWORK_Admin_Password=algebraic" \
  vertigoray/soldat
```

***Note:*** *This will download the following server zip file: https://static.soldat.pl/downloads/soldatserver2.8.1_1.7.1.zip*

# Sample INI File

For a more authoritive source, check out [the Soldat Wiki article](https://wiki.soldat.pl/index.php/Soldat.ini).

```ini
[BOTS]
Chat=0
Difficulty=50

[GAME]
Advance_Amount=1
AntiSpy_Chat=0
Blue_Points_Time=5
Bonus_Berserker=0
Bonus_Cluster=0
Bonus_FlameGod=0
Bonus_Frequency=0
Bonus_Predator=0
Bonus_Vest=0
Bullet_Time=0
Capture_Limit=10
Deathmatch_Limit=30
Debug_Mode=0
Friendly_Fire=0
GameStyle=3
Guns_Collide=0
HTF_Points_Time=5
Hold_Limit=80
Infiltration_Limit=90
Kits_Collide=0
Logging=1
Loop_Maps=1
MaxWaveRespawn_Time=240
Max_Grenades=3
MinWaveRespawn_Time=120
NoSniperLine=1
Pointmatch_Limit=30
Radio=1
Rambomatch_Limit=30
Random_Bots=0
Random_Bots_1=0
Random_Bots_2=0
Random_Bots_3=0
Random_Bots_4=0
Realistic_Mode=0
Red_Points_Capture=30
Respawn_Time=180
Stationary_Guns=0
Survival_Clear_Weapons=0
Survival_Mode=0
Teammatch_Limit=60
Time_Limit=10
Weapon_1=1
Weapon_10=1
Weapon_11=1
Weapon_12=1
Weapon_13=1
Weapon_14=1
Weapon_2=1
Weapon_3=1
Weapon_4=1
Weapon_5=1
Weapon_6=1
Weapon_7=1
Weapon_8=1
Weapon_9=1
Weapons_Mode=0

[NETWORK]
ASE_Register=1
Admin_Password=admin
Advanced_Spectate=1
Allow_Download=1
Balance_Teams=0
Clanmatch=0
Compression=1
Connection=Internet
Default_Remote_Host=
Disable_AntiCheat_Kick=0
Disable_Minimap=1
Dont_Forward=0
External_Anti_Cheat=0
Flooding_Packets_Internet=42
Flooding_Packets_LAN=80
Game_Password=123456
Greeting_Message=Welcome to Vertigion. You are born to kill.
Greeting_Message2=
Greeting_Message3=
Internet_Connection=3
Lobby_IP=
Lobby_Register=1
LogFilesUpdate=300
MaxConnections=50
Max_Flood_Warnings=4
Max_KnifeCheat_Warnings=14
Max_Ping=400
Max_Ping_Warnings=10
Max_Players=32
Max_Spectators=10
Min_Ping=0
Port=23073
Server_Info=Server running in Docker (vertigoray/soldat). Courtesy of Vertigion (http://vertigion.com).
Server_Name=Vertigion Server
Spectator_Chat=1
T1_DeadSnapshot=50
T1_Delta=4
T1_Heartbeat=135
T1_MajorSnapshot=19
T1_Ping=21
T1_Snapshot=35
T1_ThingSnapshot=31
Vote_Cheat_Warnings=8
Vote_Percent=60
```