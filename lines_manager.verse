
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
    @editable Scene5Trigger : mutator_zone_device = mutator_zone_device{}

    var MaybeMyUIPerPlayer : [player]?canvas = map{}

    var IsStarted: logic = false

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Scene1Trigger.AgentEntersEvent.Subscribe(OnScene1)
        Scene2Trigger.AgentEntersEvent.Subscribe(OnScene2)
        Scene3Trigger.AgentEntersEvent.Subscribe(OnScene3)
        Scene4Trigger.AgentEntersEvent.Subscribe(OnScene4)
        Scene5Trigger.AgentEntersEvent.Subscribe(OnScene5)

    OnScene1(Agent: agent):void =
        spawn{StartLines(Agent, Scene1LinesList)}

    OnScene2(Agent: agent):void =
        spawn{StartLines(Agent, Scene2LinesList)}

    OnScene3(Agent: agent):void =
        spawn{StartLines(Agent, Scene3LinesList)}

    OnScene4(Agent: agent):void =
        spawn{StartLines(Agent, Scene4LinesList)}

    OnScene5(Agent: agent):void =
        spawn{StartLines(Agent, Scene5LinesList)}

    OnScene6(Agent: agent):void =
        spawn{StartLines(Agent, Scene6LinesList)}

    OnScene7(Agent: agent):void =
        spawn{StartLines(Agent, Scene7LinesList)}

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
            return 3.0
        else:
            return 7.0

    GetScene6Duration(): float =
        return GetTotalDuration(Scene6LinesList)
    
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
 
    Scene1LinesList : []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s1_1, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_2, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_3, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_4, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_5, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_6, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s1_7, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_8, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_9, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_10, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_11, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_12, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_13, Duration := duration.Short}
    }

    Scene2LinesList : []line = array{
        line {Character := assets.selenian, Sentence := assets.s2_1, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_2, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_3, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_4, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_5, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_6, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_7, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_8, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_9, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_10, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_11, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s2_12, Duration := duration.Long}
    }

    Scene3LinesList : []line = array{
        line {Character := assets.selenian, Sentence := assets.s3_1, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s3_2, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s3_3, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s3_4, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s3_5, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s3_6, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s3_7, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s3_8, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s3_9, Duration := duration.Long}
    }

    Scene4LinesList : []line = array{
        line {Character := assets.selenian, Sentence := assets.s4_1, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s4_2, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s4_3, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s4_4, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s4_5, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s4_6, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s4_7, Duration := duration.Long},
        line {Character := assets.noah, Sentence := assets.s4_8, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s4_9, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s4_10, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s4_11, Duration := duration.Short}
    }

    Scene5LinesList : []line = array{
        line {Character := assets.selenian, Sentence := assets.s5_1, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s5_2, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s5_3, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s5_4, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s5_5, Duration := duration.Short},
        line {Character := assets.aresCommander,     Sentence := assets.s5_6, Duration := duration.Long}
    }

    Scene6LinesList : []line = array{
        line {Character := assets.selenian, Sentence := assets.s6_1, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s6_2, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s6_3, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s6_4, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s6_5, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s6_6, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s6_7, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s6_8, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s6_9, Duration := duration.Short}
    }

    Scene7LinesList : []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s7_1, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s7_2, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_3, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s7_4, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s7_5, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_6, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s7_7, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_8, Duration := duration.Long}
    }
