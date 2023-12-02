
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

    var InitialPosition<private>: vector3 = vector3{X:=0.0, Y:= 0.0, Z:=0.0}
    var InitialRotation<private>: rotation = rotation{}
    var IsChasing<private>: logic = false

    @editable var Explosive: explosive_device = explosive_device{}
    @editable var Explosive2: explosive_device = explosive_device{}
    @editable Missiles: []missile_device = array{}

    @editable var MinX :float = -18031.0
    @editable var MinY :float = -19333.0
    @editable var MaxX :float = -9901.0
    @editable var MaxY :float = -8720.0
    @editable var AttackDuration :float = 2.5
    @editable var SleepAfterAttack: float = 1.5
    @editable var GoOverParam: float = 1.5 #攻撃時にどれくらい行き過ぎるか
    @editable var HP: float = 500.0
    @editable var Name: string = "HedgeHog"
    @editable var AdjustYaw: float = 90.0

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        set InitialPosition = Enemy.GetTransform().Translation
        set InitialRotation = Enemy.GetTransform().Rotation

    BackToInitialPosition()<suspends>:void =
        set IsChasing = false
        StopMissiles()
        Enemy.MoveTo(InitialPosition, InitialRotation, 1.0 )

    StartChasing(Agent: agent)<suspends>:void =
        Print("StartChasing")
        set IsChasing = true
        Sleep(3.0) #プレーヤースポーン直後は無敵期間があるようなのでwait
        spawn{StartMissiles(Agent)}
        loop:
            race:
                RotateTowardPlayer(Agent)
                Wait()
            Attack(Agent)
            Sleep(SleepAfterAttack)
            if (IsChasing = false):
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
            var NewX :float = PropLocation.X + GoOverParam*Xdiff
            var NewY :float = PropLocation.Y + GoOverParam*Ydiff
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
                    Yaw := RadiansToDegrees(ArcTan(LookDirection.Y, LookDirection.X)) + AdjustYaw
                    Pitch := 0.0 #RadiansToDegrees(ArcTan(LookDirection.Z, Sqrt((LookDirection.X * LookDirection.X) + (LookDirection.Y * LookDirection.Y))))
                    Roll := 0.0
                    NewRotation := MakeRotationFromYawPitchRollDegrees(Yaw, Pitch, Roll)
                    Enemy.MoveTo(PropLocation, NewRotation, 0.5)
            Sleep(0.0)

    OnDefeated(Agent: agent):void =
        spawn{Explode(Agent)}
        set IsChasing = false
        StopMissiles()
        spawn{MoveToGround()}

    Explode(Agent: agent)<suspends>:void =
        Explosive.Explode(Agent)
        Sleep(500.0)
        Explosive2.Explode(Agent)

    MoveToGround()<suspends>:void =
        PropLocation := Enemy.GetTransform().Translation
        NewLocation := vector3{X := PropLocation.X, Y := PropLocation.Y, Z := PropLocation.Z - 100.0}
        Enemy.MoveTo(NewLocation, Enemy.GetTransform().Rotation, 10.0)

    StartMissiles<private>(Agent: agent)<suspends>:void =
        for(Index : int = 0..Missiles.Length - 1 ):
            if(Missile := Missiles[Index]):
                spawn{Missile.Start(Agent)}

    StopMissiles<private>():void =
        for(Index : int = 0..Missiles.Length - 1 ):
            if(Missile := Missiles[Index]):
                Missile.Stop()
