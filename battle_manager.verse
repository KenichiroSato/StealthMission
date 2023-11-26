
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

    var CurrentPlayer: ?player = false
    HealthBar : health_bar = health_bar{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void= 
        EntranceZone.AgentEntersEvent.Subscribe(OnPlayerEntered)
        DamageTrigger.TriggeredEvent.Subscribe(OnDamage)
        PlayerDeadZone.AgentEntersEvent.Subscribe(DamagePlayer)

    OnPlayerEntered(Agent: agent):void =
        if (not CurrentPlayer = false):
            return
        if (Player := player[Agent]):
            set CurrentPlayer = option{Player}
            InitHealthBar(Enemy1.Name, "ff0000")
            spawn{Enemy1.StartChasing(Agent)}

    DamagePlayer(Agent : agent) :void =
        if (FortniteCharacter : fort_character = Agent.GetFortCharacter[]):
            Print("DamagePlayer")
            MyCharacterHealth : float = FortniteCharacter.GetHealth()
            FortniteCharacter.Damage(MyCharacterHealth)
            spawn{Enemy1.BackToInitialPosition()}
            OnPlayerDead()

    InitHealthBar<private>(Name: string, Color: string):void =
        if (Player := CurrentPlayer?):
            HealthBar.Init(Name, Enemy1.HP, Color)
            HealthBar.ShowUIForPlayer(Player)

    RemoveHealthBar():void =
        if (Player := CurrentPlayer?):
            HealthBar.RemoveHealthBar(Player)

    OnDamage(MaybeAgent: ?agent):void =
        HealthBar.TakeDamage(100.0)
        CurrentHp := HealthBar.GetCurrentHp()
        if (CurrentHp = 0.0):
            OnDefeated()

    OnPlayerDead():void =
        RemoveHealthBar()
        set CurrentPlayer = false

    OnDefeated():void =
        Barrier.Disable()
        Enemy1.OnDefeated()
        RemoveHealthBar()


