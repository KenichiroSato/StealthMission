
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Playspaces }
# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
bgm_manager := class(creative_device):

    @editable LasBossBgmPlayer: audio_player_device = audio_player_device{}
    @editable BattleBgmPlayer: audio_player_device = audio_player_device{}
    @editable NormalBgmPlayer: audio_player_device = audio_player_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        PlayNormalBgm()

    PlayNormalBgm():void =
        Print("PlayNormalBgm")
        LasBossBgmPlayer.Stop()
        BattleBgmPlayer.Stop()
        NormalBgmPlayer.Play()

    PlayBattleBgm(IsLasBoss: logic):void =
        Print("PlayBattleBgm")
        NormalBgmPlayer.Stop()
        if (IsLasBoss = true):
            LasBossBgmPlayer.Play()
            BattleBgmPlayer.Stop()
        else:
            LasBossBgmPlayer.Stop()
            BattleBgmPlayer.Play()

    PlayLassBossBgm():void =
        NormalBgmPlayer.Stop()
        BattleBgmPlayer.Stop()
        LasBossBgmPlayer.Play()