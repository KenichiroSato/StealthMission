
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.


lines_provider := interface():
    Scene1LinesList() : []line
    Scene2LinesList() : []line
    Scene3LinesList() : []line
    Scene4LinesList() : []line
    Scene5LinesList() : []line
    Scene6LinesList() : []line
    Scene7LinesList() : []line
    CardKeyLinesList() : []line 
    WeakspotLinesList() : []line
    PlayerDeadLinesList() : []line

english_lines_provider := class(lines_provider):

    Scene1LinesList<override>() : []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s1_1, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_2, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_3, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_4, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_5, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_6, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s1_7, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_8, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_9, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_10, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_11, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_12, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_13, Duration := duration.Short}
    }

    Scene2LinesList<override>() : []line = array{
        line {Character := assets.selenian, Sentence := assets.s2_1, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_2, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_3, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_4, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_5, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_6, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_7, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_8, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_9, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_10, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_11, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s2_12, Duration := duration.Long}
    }

    Scene3LinesList<override>() : []line = array{
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

    Scene4LinesList<override>() : []line = array{
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

    Scene5LinesList<override>() : []line = array{
        line {Character := assets.selenian, Sentence := assets.s5_1, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s5_2, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s5_3, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s5_4, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s5_5, Duration := duration.Short},
        line {Character := assets.aresCommander,     Sentence := assets.s5_6, Duration := duration.Long}
    }

    Scene6LinesList<override>() : []line = array{
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

    Scene7LinesList<override>() : []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s7_1, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s7_2, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_3, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s7_4, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s7_5, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_6, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s7_7, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_8, Duration := duration.Long},
        line {Character := assets.empty,         Sentence := assets.s7_9, Duration := duration.Long}
    }

    CardKeyLinesList<override>(): []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s_cardkey, Duration := duration.Long}
    }

    WeakspotLinesList<override>(): []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s_weakspot, Duration := duration.Long}
    }

    PlayerDeadLinesList<override>(): []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s_noah, Duration := duration.Short}
    }

japanese_lines_provider := class(lines_provider):

    Scene1LinesList<override>() : []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s1_1_ja, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_2_ja, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_3_ja, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_4_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_5_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_6_ja, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s1_7_ja, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_8_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_9_ja, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s1_10_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_11_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s1_12_ja, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s1_13_ja, Duration := duration.Short}
    }

    Scene2LinesList<override>() : []line = array{
        line {Character := assets.selenian, Sentence := assets.s2_1_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_2_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_3_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_4_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_5_ja, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_6_ja, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_7_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_8_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s2_9_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s2_10_ja, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s2_11_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s2_12_ja, Duration := duration.Long}
    }

    Scene3LinesList<override>() : []line = array{
        line {Character := assets.selenian, Sentence := assets.s3_1_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s3_2_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s3_3_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s3_4_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s3_5_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s3_6_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s3_7_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s3_8_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s3_9_ja, Duration := duration.Long}
    }

    Scene4LinesList<override>() : []line = array{
        line {Character := assets.selenian, Sentence := assets.s4_1_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s4_2_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s4_3_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s4_4_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s4_5_ja, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s4_6_ja, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s4_7_ja, Duration := duration.Long},
        line {Character := assets.noah, Sentence := assets.s4_8_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s4_9_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s4_10_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s4_11_ja, Duration := duration.Short}
    }

    Scene5LinesList<override>() : []line = array{
        line {Character := assets.selenian, Sentence := assets.s5_1_ja, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s5_2_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s5_3_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s5_4_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s5_5_ja, Duration := duration.Short},
        line {Character := assets.aresCommander,     Sentence := assets.s5_6_ja, Duration := duration.Long}
    }

    Scene6LinesList<override>() : []line = array{
        line {Character := assets.selenian, Sentence := assets.s6_1_ja, Duration := duration.Short},
        line {Character := assets.selenian, Sentence := assets.s6_2_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s6_3_ja, Duration := duration.Long},
        line {Character := assets.selenian, Sentence := assets.s6_4_ja, Duration := duration.Short},
        line {Character := assets.noah,     Sentence := assets.s6_5_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s6_6_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s6_7_ja, Duration := duration.Long},
        line {Character := assets.aresCommander, Sentence := assets.s6_8_ja, Duration := duration.Long},
        line {Character := assets.noah,     Sentence := assets.s6_9_ja, Duration := duration.Short}
    }

    Scene7LinesList<override>() : []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s7_1_ja, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s7_2_ja, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_3_ja, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s7_4_ja, Duration := duration.Long},
        line {Character := assets.noah,          Sentence := assets.s7_5_ja, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_6_ja, Duration := duration.Short},
        line {Character := assets.aresCommander, Sentence := assets.s7_7_ja, Duration := duration.Short},
        line {Character := assets.noah,          Sentence := assets.s7_8_ja, Duration := duration.Long},
        line {Character := assets.empty,         Sentence := assets.s7_9_ja, Duration := duration.Long}
    }

    CardKeyLinesList<override>(): []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s_cardkey_ja, Duration := duration.Long}
    }

    WeakspotLinesList<override>(): []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s_weakspot_ja, Duration := duration.Long}
    }

    PlayerDeadLinesList<override>(): []line = array{
        line {Character := assets.aresCommander, Sentence := assets.s_noah_ja, Duration := duration.Short}
    }
