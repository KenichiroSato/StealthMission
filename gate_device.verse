
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
gate_device := class(creative_device):

    @editable Guards: []guard_spawner_device = array{}
    @editable Gate: barrier_device = barrier_device{}
    @editable AlertIcon: hud_message_device = hud_message_device{}

    var SuspiciousCount: int = 0

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void= 
        ListenGuardsEvents()

    ListenGuardsEvents():void =
        for(Index : int = 0..Guards.Length - 1 ):
            if(GuardSpawner := Guards[Index]):
                GuardSpawner.UnawareEvent.Subscribe(OnUnaware)
                GuardSpawner.SuspiciousEvent.Subscribe(OnSuspicious)

    OnSuspicious(Agent: agent):void =
        set SuspiciousCount += 1
        Print("SuspiciousCount={SuspiciousCount}")
        Gate.Enable()
        AlertIcon.Show()
        Print("Enable!")

    OnUnaware(Agent:agent):void =
        set SuspiciousCount -= 1
        Print("SuspiciousCount={SuspiciousCount}")
        if (SuspiciousCount < 1):
            Gate.Disable()
            AlertIcon.Hide()
            Print("Disable")
