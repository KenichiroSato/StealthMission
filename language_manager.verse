
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

language := enum{English, Japanese, None}

# A Verse-authored creative device that can be placed in a level
language_manager := class(creative_device):

    #We use number of Golds to save language
    @editable GoldCountProvider: conditional_button_device = conditional_button_device{}
    @editable Dialog: popup_dialog_device = popup_dialog_device{}
    @editable SpawnDevice:player_spawner_device = player_spawner_device{}
    @editable GoldGranter: item_granter_device = item_granter_device{}
    @editable LinesManager: lines_manager = lines_manager{}

    var CurrentLang: language = language.None

    OnBegin<override>()<suspends>:void=
        SpawnDevice.SpawnedEvent.Subscribe(InitializeLanguage)
        Dialog.RespondingButtonEvent.Subscribe(OnLangSelected)

    InitializeLanguage(Agent: agent):void=
        GoldCount := GoldCountProvider.GetItemCount(Agent, 0)
        Print("Gold={GoldCount}")
        if (GoldCount = 0 or GoldCount > 5):
            Dialog.Show()
        else:
            SetCurrentLang(Agent, GoldCount)

    OnLangSelected(Agent:agent, Index: int):void =
        Print("OnLangSelected Selected={Index}")
        for (count: int = 0..Index):
            GoldGranter.GrantItem(Agent)
        LangIndex := Index + 1
        SetCurrentLang(Agent, LangIndex)
                
    SetCurrentLang(Agent: agent, Index: int):void =
        if (Index = 1):
            set CurrentLang = language.English
            Print("English")
        else if (Index = 2):
            set CurrentLang = language.Japanese
            Print("Japanese")
        else:
            set CurrentLang = language.None
            Print("None")
        LinesManager.SetLinesProvider(CurrentLang)
