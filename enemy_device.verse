
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters}
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
enemy_device := class(creative_device):

    @editable var Enemy : creative_prop = creative_prop{}
    @editable var EntranceZone : mutator_zone_device = mutator_zone_device{}
    @editable var DamageZone : mutator_zone_device = mutator_zone_device{}

    var InitialPosition<private>: vector3 = vector3{X:=0.0, Y:= 0.0, Z:=0.0}
    var InitialRotation<private>: rotation = rotation{}
    var IsDefeated<private>: logic = false

    MinX :float = -18031.0
    MinY :float = -19333.0
    MaxX :float = -9901.0
    MaxY :float = -8720.0
    AttackDuration :float = 2.5
    SleepAfterAttack: float = 1.5

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        set InitialPosition = Enemy.GetTransform().Translation
        set InitialRotation = Enemy.GetTransform().Rotation
        DamageZone.AgentEntersEvent.Subscribe(DamagePlayer)
        EntranceZone.AgentEntersEvent.Subscribe(OnPlayerEntered)

    OnPlayerEntered(Agent: agent):void =
        spawn{StartChasing(Agent)}

    DamagePlayer(Agent : agent) :void =
        if (FortniteCharacter : fort_character = Agent.GetFortCharacter[]):
            Print("DamagePlayer")
            MyCharacterHealth : float = FortniteCharacter.GetHealth()
            FortniteCharacter.Damage(MyCharacterHealth)
            spawn{BackToInitialPosition()}

    BackToInitialPosition()<suspends>:void =
        Enemy.MoveTo(InitialPosition, InitialRotation, 1.0 )

    StartChasing(Agent: agent)<suspends>:void =
        Print("StartChasing")
        Sleep(3.0) #プレーヤースポーン直後は無敵期間があるようなのでwait
        loop:
            race:
                RotateTowardPlayer(Agent)
                Wait()
            Attack(Agent)
            Sleep(SleepAfterAttack)
            if (IsDefeated = true):
                break

    Wait()<suspends>:void =
        WaitTime := GetRandomFloat(5.0, 15.0)
        #Print("Wait for {WaitTime} seconds")
        Sleep(WaitTime)

    Attack(Agent: agent)<suspends>:void =
        #Print("Attack")
        if (PlayerCharacter := Agent.GetFortCharacter[]):
            PlayerLocation := PlayerCharacter.GetTransform().Translation
            PropLocation := Enemy.GetTransform().Translation
            Xdiff := PlayerLocation.X - PropLocation.X
            Ydiff := PlayerLocation.Y - PropLocation.Y
            var NewX :float = PropLocation.X + 1.5*Xdiff
            var NewY :float = PropLocation.Y + 1.5*Ydiff
            if (NewX < MinX):
                set NewX = MinX
            if (NewX > MaxX):
                set NewX = MaxX
            if (NewY < MinY):
                set NewY = MinY
            if (NewY > MaxY):
                set NewY = MaxY
            NewLocation := vector3{X := NewX, Y := NewY, Z := PropLocation.Z}
            Enemy.MoveTo(NewLocation, Enemy.GetTransform().Rotation, AttackDuration)

    RotateTowardPlayer(Agent : agent)<suspends>:void=
        #Print("RotateTowardPlayer")
        loop:
            if (PlayerCharacter := Agent.GetFortCharacter[]):
                PropLocation := Enemy.GetTransform().Translation
                PlayerLocation := PlayerCharacter.GetTransform().Translation
                if (LookDirection := (PropLocation - PlayerLocation).MakeUnitVector[]):
                    Yaw := RadiansToDegrees(ArcTan(LookDirection.Y, LookDirection.X)) + 90.0
                    Pitch := 0.0 #RadiansToDegrees(ArcTan(LookDirection.Z, Sqrt((LookDirection.X * LookDirection.X) + (LookDirection.Y * LookDirection.Y))))
                    Roll := 0.0
                    NewRotation := MakeRotationFromYawPitchRollDegrees(Yaw, Pitch, Roll)
                    Enemy.MoveTo(PropLocation, NewRotation, 0.5)
            Sleep(0.0)

    OnDefeated():void =
        set IsDefeated = true