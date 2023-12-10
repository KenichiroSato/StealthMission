
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters}
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
battle_manager := class(creative_device):

    @editable Enemy1: enemy_device = enemy_device{}
    @editable EntranceZone : mutator_zone_device = mutator_zone_device{}
    @editable DamageTrigger: trigger_device = trigger_device{}
    @editable var PlayerDeadZone : mutator_zone_device = mutator_zone_device{}
    @editable Barrier: barrier_device = barrier_device{}
    @editable Beacon: beacon_device = beacon_device{}
    @editable LineManager: lines_manager = lines_manager{}
    @editable BgmManager: bgm_manager = bgm_manager{}
    @editable Scene5Trigger : mutator_zone_device = mutator_zone_device{}
    @editable IsLasBoss: logic = false
    @editable ShowcaseManager: showcase_manager = showcase_manager{}

    var CurrentPlayer: ?player = false
    var IsScene5Playing : logic = false
    HealthBar : health_bar = health_bar{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void= 
        EntranceZone.AgentEntersEvent.Subscribe(OnPlayerEntered)
        DamageTrigger.TriggeredEvent.Subscribe(OnDamage)
        PlayerDeadZone.AgentEntersEvent.Subscribe(DamagePlayer)
        Scene5Trigger.AgentEntersEvent.Subscribe(OnScene5)

    OnPlayerEntered(Agent: agent):void =
        if (not CurrentPlayer = false):
            return
        if (Player := player[Agent]):
            set CurrentPlayer = option{Player}
            InitHealthBar(Enemy1.Name, "ff0000")
            if (IsLasBoss = true):
                if(IsScene5Playing = false):
                    spawn{Enemy1.StartChasing(Agent)}
            else:
                spawn{Enemy1.StartChasing(Agent)}
            Barrier.Enable()
            BgmManager.PlayBattleBgm(IsLasBoss)

    OnScene5(Agent: agent):void =
        spawn{StartScene5(Agent)}

    StartScene5(Agent: agent)<suspends>:void =
        if (IsScene5Playing = true):
            return
        set IsScene5Playing = true
        Scene5Duration := LineManager.GetScene5Duration()
        spawn{Enemy1.StartOnlyRotate(Agent, Scene5Duration)}
        LineManager.OnScene5(Agent)
        Sleep(Scene5Duration)
        set IsScene5Playing = false

    DamagePlayer(Agent : agent) :void =
        if (FortniteCharacter : fort_character = Agent.GetFortCharacter[]):
            Print("DamagePlayer")
            OnPlayerDead(Agent)
            MyCharacterHealth : float = FortniteCharacter.GetHealth()
            FortniteCharacter.Damage(MyCharacterHealth)
            spawn{Enemy1.BackToInitialPosition()}

    InitHealthBar<private>(Name: string, Color: string):void =
        if (Player := CurrentPlayer?):
            HealthBar.Init(Name, Enemy1.HP, Color)
            HealthBar.ShowUIForPlayer(Player)

    RemoveHealthBar():void =
        if (Player := CurrentPlayer?):
            HealthBar.RemoveHealthBar(Player)

    OnDamage(MaybeAgent: ?agent):void =
        if (Agent := MaybeAgent?):
            HealthBar.TakeDamage(100.0)
            CurrentHp := HealthBar.GetCurrentHp()
            if (CurrentHp = 0.0):
                OnDefeated(Agent)
            if (IsLasBoss = true):
                if (CurrentHp = 100.0):
                    spawn{StartScene6(Agent)}
                if (CurrentHp = 0.0):
                    spawn{StartEndScene(Agent)}

    StartScene6(Agent: agent)<suspends>:void =
        Scene6Duration := LineManager.GetScene6Duration()
        spawn{Enemy1.StartOnlyRotate(Agent, Scene6Duration)}
        LineManager.OnScene6(Agent)
        Sleep(Scene6Duration)

    StartEndScene(Agent: agent)<suspends>:void =
        Sleep(4.0)
        LineManager.OnScene7(Agent)
        Sleep(LineManager.GetScene7Duration())
        ShowcaseManager.DisplayShowcase()
        BgmManager.PlayEndrollBgm()


    OnPlayerDead(Agent : agent):void =
        LineManager.OnPlayerDead(Agent)
        RemoveHealthBar()
        BgmManager.PlayDead()
        set CurrentPlayer = false

    OnDefeated(Agent: agent):void =
        Barrier.Disable()
        Enemy1.OnDefeated(Agent)
        RemoveHealthBar()
        Beacon.Enable()
        BgmManager.PlayDefeat()
        BgmManager.PlayNormalBgm()

