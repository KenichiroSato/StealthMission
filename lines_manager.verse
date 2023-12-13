
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.


duration := enum{Short, Long}

line := struct:
    Character : texture
    Sentence : texture
    Duration : duration

# A Verse-authored creative device that can be placed in a level
lines_manager := class(creative_device):

    @editable Scene1Trigger : mutator_zone_device = mutator_zone_device{}
    @editable Scene2Trigger : mutator_zone_device = mutator_zone_device{}
    @editable Scene3Trigger : mutator_zone_device = mutator_zone_device{}
    @editable Scene4Trigger : mutator_zone_device = mutator_zone_device{}
    @editable CardKeyButtons: []conditional_button_device = array{}
    @editable FrontAttackTrigger: trigger_device = trigger_device{}

    var MaybeMyUIPerPlayer : [player]?canvas = map{}

    var IsStarted: logic = false
    var LinesProvider: lines_provider = english_lines_provider{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Scene1Trigger.AgentEntersEvent.Subscribe(OnScene1)
        Scene2Trigger.AgentEntersEvent.Subscribe(OnScene2)
        Scene3Trigger.AgentEntersEvent.Subscribe(OnScene3)
        Scene4Trigger.AgentEntersEvent.Subscribe(OnScene4)
        FrontAttackTrigger.TriggeredEvent.Subscribe(OnFrontAttack)
        for(Index : int = 0..CardKeyButtons.Length - 1 ):
            if(CardKeyButton := CardKeyButtons[Index]):
                CardKeyButton.NotEnoughItemsEvent.Subscribe(OnCardKey)

    SetLinesProvider(Language: language):void =
        if (Language = language.Japanese):
            set LinesProvider = japanese_lines_provider{}
        else:
            set LinesProvider = english_lines_provider{}

    OnFrontAttack(MaybeAgent: ?agent):void =
        if (Agent := MaybeAgent?):
            spawn{StartLines(Agent, LinesProvider.WeakspotLinesList())}

    OnCardKey(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.CardKeyLinesList())}

    OnPlayerDead(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.PlayerDeadLinesList())}

    OnScene1(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.Scene1LinesList())}

    OnScene2(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.Scene2LinesList())}

    OnScene3(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.Scene3LinesList())}

    OnScene4(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.Scene4LinesList())}

    OnScene5(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.Scene5LinesList())}

    OnScene6(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.Scene6LinesList())}

    OnScene7(Agent: agent):void =
        spawn{StartLines(Agent, LinesProvider.Scene7LinesList())}

    StartLines(Agent: agent, Lines: []line)<suspends>:void =
        if (IsStarted = true):
            return
        set IsStarted = true
        # player_uiを取得
        if (Player := player[Agent], PlayerUI := GetPlayerUI[Player]):
            for(Index : int = 0..Lines.Length - 1 ):
                if (Line := Lines[Index]):
                    NewUI := CreateMyUI(Line)
                    PlayerUI.AddWidget(NewUI, player_ui_slot{InputMode := ui_input_mode.None})
                    Sleep(GetDuration(Line.Duration))
                    PlayerUI.RemoveWidget(NewUI)
        set IsStarted = false

    GetDuration<private>(Duration: duration):float =
        if (Duration = duration.Short):
            return 4.0
        else:
            return 8.0

    GetScene7Duration(): float =
        return GetTotalDuration(LinesProvider.Scene7LinesList())

    GetScene6Duration(): float =
        return GetTotalDuration(LinesProvider.Scene6LinesList())

    GetScene5Duration(): float =
        return GetTotalDuration(LinesProvider.Scene5LinesList())

    GetTotalDuration<private>(Lines: []line): float =
        var TotalDuration:float = 0.0
        for(Index : int = 0..Lines.Length - 1 ):
            if (Line := Lines[Index]):
                set TotalDuration += GetDuration(Line.Duration)
        return TotalDuration

    # UI作成
    CreateMyUI(Line: line): canvas=
         # キャンバスウィジェット
        MyCanvas : canvas = canvas:
            Slots := array:
                canvas_slot: #Character
                    Anchors := anchors{Minimum := vector2{X := 0.1, Y := 0.3}, Maximum := vector2{X := 0.1, Y := 0.3} }
                    Offsets := margin{Top := 50.0, Left := 10.0, Bottom := 0.0, Right := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    ZOrder := 0
                    SizeToContent := true
                    Widget := texture_block:
                        DefaultImage := Line.Character
                        DefaultDesiredSize := vector2{X := 200.0, Y := 200.0} 
                canvas_slot: #Sentence
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.35}, Maximum := vector2{X := 0.5, Y := 0.35} }
                    Offsets := margin{Top := 0.0, Left := 20.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := texture_block:
                        DefaultImage := Line.Sentence
                        DefaultDesiredSize := vector2{X := 1280.0, Y := 170.4} 
        return MyCanvas

    DeleteMyUI(Message : widget_message) : void=      
        if:
            PlayerUI := GetPlayerUI[Message.Player]
            MyUI := MaybeMyUIPerPlayer[Message.Player]?
        then:
            # プレイヤー画面から作成したUIを削除
            PlayerUI.RemoveWidget(MyUI)
 
            # データ上のプレイヤーに紐づくUIを削除(false)
            if (set MaybeMyUIPerPlayer[Message.Player] = false){}
 
