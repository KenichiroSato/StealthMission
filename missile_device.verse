
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters}
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
missile_device := class(creative_device):

    @editable var BulletAnker : creative_prop = creative_prop{}
    @editable var BulletFly : creative_prop = creative_prop{}
    @editable EntranceZone : mutator_zone_device = mutator_zone_device{}
    @editable var Explosive: explosive_device = explosive_device{}

    @editable var SleepAfterAttack: float = 1.0
    @editable var AttackDuration:float = 2.0

    var IsChasing:logic = false

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        EntranceZone.AgentEntersEvent.Subscribe(OnPlayerEntered)
        EntranceZone.AgentExitsEvent.Subscribe(OnPlayerExit)

    OnPlayerEntered(Agent: agent):void =
        set IsChasing = true
        spawn{Start(Agent)}

    OnPlayerExit(Agent: agent):void =
        set IsChasing = false


    Start(Agent: agent)<suspends>:void =
        loop:
            Attack(Agent)
            Explosive.Explode(Agent)
            Sleep(SleepAfterAttack)
            Explosive.Reset()
            if (IsChasing = false):
                break

    Attack(Agent: agent)<suspends>:void =
        ResetBulletLocation()
        Print("Attack")
        if (PlayerCharacter := Agent.GetFortCharacter[]):
            PlayerLocation := PlayerCharacter.GetTransform().Translation
            BulletFly.MoveTo(PlayerLocation, BulletFly.GetTransform().Rotation, AttackDuration)

    ResetBulletLocation()<suspends>:void =
        InitialPosition := BulletAnker.GetTransform().Translation
        InitialRotation := BulletAnker.GetTransform().Rotation
        if (BulletFly.TeleportTo[InitialPosition, InitialRotation]):
            Print("TeleportTo")
