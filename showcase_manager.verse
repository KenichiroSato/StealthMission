
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
showcase_manager := class(creative_device):

    @editable ShowCaseProp : creative_prop = creative_prop{}
    @editable BeaconShowcase: beacon_device = beacon_device{}
    @editable Light: customizable_light_device = customizable_light_device{}
    @editable Light2: customizable_light_device = customizable_light_device{}
    @editable Light3: customizable_light_device = customizable_light_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void= {}

    DisplayShowcase()<suspends>:void =
        PropLocation := ShowCaseProp.GetTransform().Translation
        NewLocation := vector3{X := PropLocation.X, Y := PropLocation.Y, Z := PropLocation.Z + 3000.0}
        ShowCaseProp.MoveTo(NewLocation, ShowCaseProp.GetTransform().Rotation, 1.5)
        BeaconShowcase.Enable()
        Light.TurnOn()
        Light2.TurnOn()
        Light3.TurnOn()


