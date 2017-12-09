# https://adventofcode.com/2017/day/9
function get_score(data::String)
    garbage_count = 0
    groups = 0
    score = 0
    garbage = false
    skipme = false
    for c in data
        if skipme
            skipme = false
            continue
        end

        if c == '!'
            skipme = true
            continue
        end

        if garbage
            if c == '>'
                garbage = false
            else
                garbage_count += 1
            end
            continue
        end

        if c == '{'
            groups += 1
            score += groups
        elseif c == '}'
            groups -= 1
        elseif c == '<'
            garbage = true
        end
    end
    score, garbage_count
end

# https://adventofcode.com/2017/day/9/input
data = "{{{{{{{<!>!>!<u,!>!!!!!!!>!!!>,<<!!\">},<!!!>,<!>,<}>},{{<>},<>}},{{{{}},{{{},{{<!>,<!>,<,'e!!'i'!!<,u>}}},{<ia!!!!!>\"!>},<!!u!!!!!>,<a!<!!!>>,{<!!{!!',,u!!!>oo'>}},{{<o\"!!!o{a>}}}},{}},{{{<!!\"!>,<!a!o!!!>!!!{!\"!!!>},<o>,{<!i<{}!!!><>}},{}},{},{{{},{<,!>},<!>,<!>},<,!>,<!}!!!>>}},{<{!>,<{oi!a{a!!e!>},<o!!!>>},{<e!','a!!<!i{a},!!!>!>},<>,<{}}!!!>ao!!i}\"o!!!>,<i!!>}}},{{{<!!!!<{!,e!!!>>},{<ue!>!!!>o'>}},{{{<o'\"ae!!!>e!>,<\"!!o!!!>!>},<>,{<}\"u!}o!!u}!>},<!!!>oa<!!,>}},{{{{<'<'!!{!!\"oeu!!!!ui>},{<,!<!!!>,<!!!>},<!}}!!{!!\"ou\"!>,<>,{<<,,!!!>i!!<<!>!!!>,<>}}},{<<a<au!'!!!!!>!>!e!!u\"e{!!!>},<>}},{{{<!!!!i!!!>!>},<!!!>e,!>!!!!!>!!'\"{}>,<\"!>},<!!}'!>,<o!!!><>},{{<,!>},<}!!,i!>},<'\"<!!!>,<,!!ei'!!a!>},<i>},{{{<{e!!!>,<u!>,<!>},<'!!!>a!!!>}a!!>},{<!!,>}},<!!!>},<,u!!!>,<o>}}},{<!>},<\"<!>},<o!>},<!!!>!>>,{{{}},{<!>},<\"!>!!}e\"!>,<!>},<{\"{!!},!!!!!{\"<'<>}}}},{{{{<!>,<!!!>o!!}!!!>\"!>,<i}}!o!>,<\"e!>>}},{{<'i!>e!!!>},<!>!>,<a!!{u!>>,<o!!!>>},{<!>,<>}}},{<o'!>!o!!!>!!!!u!}',!!{!!!>}!!!!!>>}}},{}}}}},{},{{{{{<!!!>{<'!io<,>},{{{}},{{<!!'u<ae>},{{<!>},<!>},<}!>,<}!!{!!!!u,!<!>,<i!<\"}<>,{<e!>\"i!!'!!a!>},<!!!>o<i!>},<o!!i!>>}},{{}}}},{{{<!>a,\"!e>,{<!!!>o!!iu!>},<{!>},<!>io!!{!>,<i<>}}},<u!>,<!!!!<a,}!>'!!'ai>}},{{{<u<!a!>},<!!\"a,!!!>,<!>},<eu{}>}},<!!e}!!'!!!>!i!!{!>},<!!!!!>,<<>}},{{{<a!>!>ua!!!>!>},<!!u!>!\"!!>,<!>},<{!!!!>},{<!!!>,<!!!!{!>,<!>},<!!\"<}!>{,i{'!>,<!>,<>,<{<'<!!!>,<eo}>},{<!!<!!>}},{{},{{<\"!>!>},<a,,!>},<}!>!e}<<!a,>}}}},{{{<o'i>,<!aai\"!!!>,<!>,<!!!!'!u>},{{{<\"<!!!!!!\"!!!>u!>,<!!!>>}},<ia!!a>}},{{},{{<!,u!>},<}!!u!!{!>,<>},{{<!>},<}{o}!>},<!>},<ui!>,<!!<!>!>},<>,{<'!!'o}}i!!!!!>!!{<,e>}}}},{{{{<o!!!>!!!>},<>}}},{<oo!>i!>},<!!!>!>},<}i'<!i,!>},<!!'>},{<a,o!!!>a!!!>>,{<aae!u<!>},<e!>}o!!!>}!>a'ia>,<\"!,i,e!'!!e!>,<!\"!!!>i!>},<>}}}}},{{<!>uu<\">,{<'}!!!>!!!><{!!{\",!>''o>}},{<u!>},<{!!!>{!!!>,<o'o{\">,<o!{\"{!{!>},<!>,<ei>},{<!!!>,<!{}a!!e<>,{<!a!!i<ua!!o!!!>,<!!\"!>}!>},<i'}a!>!>>,{<!>,<<!>a\"{\"\"!>e!>,<<<>}}}}},{{{{{<a,!!!!!>!>e}!!,i}a,!!u}e,a{>}}}},{<!>,<>,{<,\"u\"!!!>a!!e!!!>>}},{{<ie!!e\"!><!>,<'>}}},{{},{{{{{},<!!e>}},{{<{!!\"{}e!>}u!!!>u!\"!>},<ue>}},{}},{{<aau!>,<!>!>,<}\"!!!!a!o!!!!!!}<!!{!>,<'!><\">,{<!!{!{!>,<e!!',!!!!eue!>>,{<a!>,!!i}!!'}!!}!!ueu!!{}!!!!!>{u>}}},{{{{<!!,oo!>,!!}a!!\"!!!>!>>,{<!>}<\"!>},<!!!><!!!>,<ue<!>'>}},{<{,!>!'a<<!>,<a!>!!!>!<}<<>}},{<{!!!!!>},<,!>'<!>e}!>,<i!!!>'!!>}},{<!o!!!!!>o!>},<u<!>,<!>{}!!a!!a>}}},{{{<eo!>,<!!\"}ee!>},<ua!>},<!!!>iu>}},{{<}'a\"!!!a!'{!!!>!!!>!>!>o!a!!}!!!!!!!>,>},{}}},{{{{{<!!!!!>!,<}!!!!!>,<a!<<a!!!>>,<!!u!>e!o!!!!!>!>},<!>e!!!!!>io!ie'!!>},{<!>,<\"!>},<<ou!>},<ei!>,<i!!!>,<<{o!!!!!>{>},{<!>,<ao>}},{{{{{<<o!>,<\"a!>o!,o!!!>!\"ai'!!'>}}},{{<!!\"ea'}aei!!a!!!!<ia\",>},{<>}},{{{<!>i!}e,io<u!!!!!>,<!>},<i!!}i>},{<!a\"!!a}!!}>}},{{<>}},{{{<!u!>!},e\"!!!>ue,!>!>{!>},<{'}i!>>},{<'a,\"!>a>,<!!!>!>,<!!ia\"!i!!!!!>,<{>},{<ie}}'\"a!>,!>,<>,{<>}}}}}},{{<}!{i!!}!!!>i,!>,<}\"a!!i!o>,{{<e}>},{<ie!'!!<!>},<i!!!>,<!!u!!{>}}}},{{{},{<o!>,<!>,<!>,<!!!>!!!!!!}!>{!!i!>oe'>}}},{{{<!!e!!o{!>,<ei!>,<,u<o!!!!!><>,<!!e!!!!!>>}},{{{{}}},{{<a!!!>},<o<!uo!>'!{!>},<,},!>,<e<>}},{{<!ai\">},{<a!>a'{<>}}}}}},{{{}},{<!!>,{<!>},<!!!>},<{!}e>}}},{{<,!>},<!!ai'i!\"!>,<!>},<\"{\"u!>>,<<!>,<!>},<!!'!a!>},<!!!>!>},<'!!!a}'>},{{},{},{<,!!e!>},<!>},<!!!>!>},<!a!>},<\"!!o!>u,<,,!!>}},{{<<a!>a}!a!!!>},!!e'{!!!!'!!!>!!!!o>},{{{<,>},<}!!!>\">},<io!!\"<i<{}!'!>,<,{!>>}}},{{{<!>!>!>!!\">,<!>!!!>!!<'}'>},{{<o!!{a!!!>'\"!!>,{<!!!>o!!!>,<o!!!!i{<'}!!!<e,>}},{}},{{{<a!>o<o!>u!}i!>},<!>,<,\"!!a,''!>},<>}}}},{{{{{{{<<!>},<>},{<o!!!!!>},<!>''o}o!!<\"u!>},<u!!!>e!!!!!>>}},{<!>,<a,ae}',{}ua<u!>},<,eu>}}}}},{{{<!!!>,<}'<<{{!!e!!!>{i}!>},<!>,>,<}!!<i!!!>},<{!>},!!!!i!<!'!!,!!{u<!>>},{{<\"!>,<'\"<!!!!!>\"{!>>,<ea}\"!o<<'ui!!<o>},{{{{<}o>}}}},{{}}},{{},{}}},{{<a!\"!>},<}!!!!!!!>u!>,<<a!!i\"o,o!,!!!>>},<!!!>!!!!ai!!!><!!}!>\"!>\"'\"e>},{{{<e,!!'!!!,!>,<}au!>,<!><\"i',<\">,<!>,<{\"'}i!>},<}!>,<,>},<>},{{<'e>},{}},{{{}},{<e!!i>}}}},{{<,>,{<ou!!!>!,}'i\"!!e>}},{<o!u!!!!u!!!!<!!}!>},<<!>,<!>,<!!{!!ue!>eie>,{}},{{{<!o!>'o!!u!>\"}'!>!!!!!>!>},<}\">,<}\",e!!!!!>\"!>},<!>>}},{<a!>,<i!!!>,<!>u!}!!u!!>},{<},!!,ioi!!!!!>!>'!!!>u>}}}},{{<!!!oa>},{{{<{a!>},<!!!>!!i{{u\">,{{}}},{<i<{,,!!}!!u!>}u>,<!!iu}!!<ua!!!!!>>}},{{},<!!>},{<!>},<!!!>!>},<i}<!!!>!>},<{,>}}}}},{{},{<!>!>!{o!!!>!>},<!>},<<!>,<{!!'!!!><!!u>,<\"'>}},{{{<{!>!>!>!>!>!>},<!>e!!!!u!!!!!>u'>},{},{{{<>}},{<!!!>{<!>,<{e!!{!!!>\"u!>aa!!!>,<>,{<!>\">}},{{},<oa!>>}}},{},{{{},{<{e'!>,<ioo!!!!!>,!!!>>}},{{{<,{\"!!!>},<e\"'e,iu>},<u!!!>!!!,!!iuuue\"au\"{>},<}>}}},{{{{<'!>},<e!>!\"!!!>!!!!a!!{a!{!ieii!!!>!o>},{{<!>,<!>o{!!!>},<!!!><!>},<i!!!!>}}},{{<a!!'o!!>},{{<!!!!a!!ia!!<}eou\"!'!>},<'>}}}},{{{<!!!!,}!!!>},<!!!!!>,<>}},{{<{!!!!!>\"!>},<!>,<i!>},<!>,<!>a!>},<!>,<{,!!!>!!!!uo>},<,!!u!}>},{<o!!!!uo'e!}a<o!!!,<!!o\"{>,{}}}}}}}}},{{{{},{{<<<>},<!!!>{!!!!i{!!!>oo>}},{{},{{{<ea'ue!>},<!>{!}>,<,>}}}}},{{<>,{}},{{{<!!!>'}{o!>,<!!!>!i!!!>,<!>,<!!'\"!!!>!!!>}>},{{}}},<!!!>\"!!!!<!!'!u<!>,<>}},{{{},{<!!,!!{!!!>},<!!!>>}},{<!!!!!!!>o!!>,{{<u}i!>,i!!,i}e>},{<!>},<!!\"!}!>,<!\"!>},<!!!>!!<a!!a!>},<!!!>>}}}},{}},{{{{{<e{!!!><}ei},e\"!!!>!>},<'>,{<<!!!!!>,e!e}!!!>},<i'u\"!>,<>}},{{}},{<\"!i!>!!{!!{o!>},<!i{!>,<>,{<ei,>}}},{{{<!!!><!{a'oo>}},{<a!>a!'e!>,<!>,<>}},{{{},<!>},<!!!i!!!>},<!>,<,o!>},<}!!!>{!!e!!!!u!!<<!!}!>},<!>,<}>},{<ae!!!>{>}}},{{},{<!>!>,<!'!,\"e!>o,!!!>!>,<e,}!!<o,>}},{<\"{!>,<<i!!!!o{<o>,{<!!}>}}},{{{{<!!!>}!>,<i\"!!i\"eoieaaii!!!>u>},{<!!}e!!e>,<!!!!<aie!!o!>},<!>,<!>,<!!!!!>!!<!eu,!>u>}},{},{{<!'!>,<<!auo>},{<!>,<>}}},{{<!>},<'\"!a!!!!{!>!>,<o!>},<u!>!{}!>>},<o'e{'a\"!!!>>}},{{<},\"!o!>},<,,!!!>,<!>!!!>!!!>a!>>,{}},{{<<e\"u>},{{{<!!,>,<>},{{<!!!><!}a!i!!}!>},<o!!\"''e>},{}},{{}}},{<\"!>},<!>,<!'!\"{!!!!!>},<!>},<>,{<!!!>e!!!!!>au!>},<{ue>}},{{{{<o,!>!!!>!!ua!>!!!>o!}}>},{}},<i!>},<<e!u{eua!e'},>}}}}},{{<ee!!!>'i!>auu!!{{!>\">,{}},{{<u'!<!>},<!>},<!!!>'!!>},<a!!!>\"e!}!>}>}}}},{{{{<!!!>!\"<,!!,ua{!}'a'!a!>,<!>,<>},{{<a'!{,\"\"{u!!{<!>u!>{i!>,<!!!>,a>},{{},<!>!!!>!!!>},<!'!!,i,ii!!!!!!!><'!!!!oi,!!>}},{{{}}}},{{<,!!!>,<,u!!!'ia,>,<!!i!>},<!!{<>},{{{{<!!!>i{e!>,<i,!>},<u!>,<!a,o!>},<>}},{<!>,<e'>,<ee!!!>a!!!>},<<!>>}}},{<o{<e!!!!!>!!e'!>,<\"u>,{<!!!>{\"!!!!!>!!!>\"u{\">}}},{{{<!!\"eo!!a}<{'>,{<u>}},{{<e,,>,{{{<o!!!>o!\"!>{{{!i'!><!>,<!>,<>},<a'!!!!!,u!!e<!a,>},<\"!!ue>}},{},{}}},{},{{{<!>a!!!>!!!>!!oo'o!!<}{i\"!>,<'u!>},<e>},<i\"!!!>ou'!>,<!!!>},<\"<<{i>},{{{{<!!!>o<<\"{!!}a'\",,!!!>\"!!!><>}},{{{<!>,<eau>}},<eee},!!eo!<}>}},<u!!}oe>}}},{{}}},{{{{{<ai!>,<'{>}},{<e!!!>},<!>,<!><!!!>a>}}},{{<!!<!!!>},<!>},<a<<!>!\"!>,<e{>,{<<\"!>,<>}},{{<,o!>\"!<u!>,<!>,<u}!!!!>},{{<o'>},{<,!!!>!o>}}},{{},{{<,!>!>},<>,{<!!!!!!\"o!!\"!!a!>,<!>},<>}},{{{<!!}!!!!!>o!!!>{!!>}},{{<!!!!!>,<e'u!>},<'u!>},<u!>!!e,e\">,<o!a>},<euoo!!!>>},{{{{<!!!>'o{>},{{},<e!><>},{{},{<<e,!!!>!>},<}!>,<!>},<'{ee!>,<e,>}}},{<{{<\"{u<!!!!i!!}!>,<''{\"!!!>>},{{<!!i!>,<\"!!{'<e!e{!!!>,<<{!>},<!>!{!!!>!>},<>},{<,iu!!'},ao!!au>}}},{<!!!>i,>},{<ee!>i<!!u{!!!>oa'}>,{<,e'>}}}},{{<!>},<<,,>,{<}>}},{<u}!>,o{!<<,!>,<e,!!a>}}},{{<!\"!>,<e!>,<o!>!>},<a}!!eu!>},<!!<>,{}}}}},{{{<>}},{},{<\"!ui!>},<!{<!<!ui\"'!>u,\"a!!!>'>,{<!!i!>,<\"eae}a>}}},{{{{}},{{{<!>},<\"ei!o!!!>,<{!>,<!!!>e,a>},<!!<>},{<!>\"\"ii'e{e,!!!>,!>,<{>,<!>!!!>,<o!!}{e!!!>i!>,<!>!!!>!<a<{!>},<!>},<>},{{<!>},<!>'e\"!!!!!>,\"}',\"!!!>!!e!!uu>}}},{}},{{{{}},{}},{{}},{<!>},<}!>},<!>},<!>,<o!<!>\"u{{ea!>,<!}!>>,{{<<<!>},<o,!!!>{>}}}}}},{{{<<!>},<!>,<>},{{{{<!>},<\"!!u!>}!>,<,!>,<!>,<,,>},{<!!!>{!>},<\"!>,<!!!!!i,!>},<!!!>},<},i!><>}},{}},{{<!>!!!>\"}!!\"{!>},<!!u\"!!{e}au!!>},<i<{!!!>e'!!!>eu{a\"\"\"{a!!!>!!!>>},{{{}},{}}}},{{{<!!'!>o!>},<i!\"i',{a>},<>},{},{{<'i!!{i}<ii'{oi'a}u!!ei!!!u>},{<>}}},{{<'!!!>!!a<u!>,<}!i},\">,{{{<!>!>,<!!!>a!>!>},<!e!!!>!><\">},<!>,<e!!'u<<<!e!'>}}}}},{{{{{{<{',\"!>},<>,<}!uaa!>,<<eia<ie>}}},{{{<<\",i'>},{<u'!>e<!!aa!!!>,<!,!'>,{<!!!>,<uu,!}!!,uia'e!!ie!!i!a!!!!{!>},<>}},{{<!u!!!>},<!>,<!>},<!>},<\">}}},{{{}}},{{<,<{e!!!o!>},<!!!>'i!>,<!!!>a}>},{<a!!!>},<i'!,!!{!>},<!!}e>,{}}}}},{{{<{!>!!!>,>}},{{<!>eo<'u!a,'iu<!i!}!>},<>},{<}<!>},<!>},<>}}},{{{<!!!!!>!!!!<'\"a!<!>,<\"!>},<o!!o>,<}e<ou!>oa!}!!!>!!}iu}!>>},{}},{{<>}}},{{<e'i>},{{<<!>!!,>}},{{<a>}}}},{{{{{{{<>},<\"!!{!!!!!!!>u!!!>a!!,a'!}}!!'!!!>>},{<!>,<!>},<u\">}},{{},<!>!>},<!!a!'ee!>,<}eoiao!!!!!!!eu>}},{{<\"!!,!!!>},<!!}!!!>i!!!>,<>}}},{<i{<!!a!!!>!>},<,!!!!'>,<!><!!,!uo!!}<{uoo,'!!!!!>{>}},{{<e>,{}},{{<\"<!>},<!>u!>!>,<i!!a!!oeo}}o\"!!\">}},{<!!!,!!a!>},<i!>!!!>},<!u<!!!>>,<{\"!!au'\"u<ua!>,<,,>}},{{{{}},{<<ei{!>,<>}},{{{<,!\"!!\"!><}ai!!!!!>!>!!!>!,ui>},{}},{},{}}},{{}}},{{{{<!!}o}!!\"}<!!}'!!aao}!!!!e>,<>},{{{<!!!>i!>,<!!!>!>u'!>,<,>,<!!\"!>,<a!!,!!e!!!>a\"e!!!>!>>},{{<!e},eouua!!oooeo\"oo!!!>>,{<eu,!>!>,<!!!>!>}{<!>,<!!!>!>!!\"!!!,\"i'a>}},{<o'!>},<!!!>e!!!!}''oo!>,<\"<>,<}o!>'!!\"!>},<!>},<\"!}e!!!>!!},>}},{<}i,<!!<u>,<{!!!!<\"}>}},{<\",,i,e{!!!>,<'i<!!!>},<>,<<!!!>}u!!\"o!>!\">}}},{{{},{{<a!>},<<}'o!>,<u\",!!!><!>,<!'<ae!>>},<a!>,<uoo!'!!i!\"!!!!!>!><'\"u!!!!!>,<a}>},{<!!!>,!>},<,!!o<i!>,<iu!!,i!!!,{>}},{{},{{<a!>},<'!>},<!ea!>!!,\">},{<!>},<>}}},{{{<a!!!>!!<!>},<a!!ou!>},<e,!!i!uo!!!>!!{'>},<!>},<o{}\"}!>,<>},{{{{},{{{},{<!>},<!>},<}!>!!o<>}},{{{<!\"'<\"!!!!!>a!>,<e>}},<!!!>}!!\"!!u!!!>},<}!!!>},<,\"}<!!i!!!>>}}},<!!!>!>euo!!,u!!!><!>!!<eo!>,<a!>,<>},{{},{{{<!e!!<!>},<!!!>,!ou{!,>}}}}},{<!!!>!e!>ee!!\"!!!!!>aia'{!>,<>,<<e!!!>{!>!>},<<}>}}}},{{{{{{<!!'!<>}},{<{!\"<a!>}a{<e!!\"!!},}'>}}},{{{{<!>!!'!>,<,u!!!!i!!a!>!!e>}},{<,{!>,<!!!>!a!>,<{!!!>!!>}},{{{<,ao!!<{!>{'!>},<u!!!>!!!>o!!!,!>,<\"<>}}}},{{{{{}},<!!!!\"!>},<!>},<!>,<o!!<!>},<!!o{!>,<<oau!!!!}>}},{<!!!>!>!>,<<!>e,>,{}},{<,!!!>!>,<}!!eao<{,!!a\"!>,<!!!>!>},<o\"\"!!\">}}}}}},{{{{<o!!!>!>},<'!!>},{<}{'!>'!!\"{!>u!'\"o{\"a!!>}},{{}},{{<!!!}!>},<{{!>!!u!i>},{{{}},{}}}},{}}}},{{{{{{<>},{<>}},{{{<!!!>,!!!>!!u>},{<!ua!!!>!!>,{}}}},{{<e!>},<!>},<!!{ia!!!!!>>}}},{{}},{<}!a'}!>,<<!o!!eu!>},<!!uu'!!!>\"!>},<!!e>}},{},{{},{{<!o<!\"'\"!!u<!!iu!>!>},<<ai>},<>}},{{{<!{ii!!}i!>,<a>,<!>!>,<!!,>}},{<!>'o,!!i!!<oo!>,<u'!>i!!!>'>},{{{},<>},<i!!!!,}!!!!aue>}}},{{{{{<!!a!!!>\"a!!!><\"euoe!\">},{<au,o}!>,<>}},{{{<!>!>,<a,a!!!!!>'!e!u\"!>,<!!>}},{<!!!a}!>,<o!<{!{!>,<!!!>}a,\"!!u!>},<i!!}o>}}},{<\">},{{{<a{e<>}}}},{{{{{{<o!>},<!>!!a!>},<{ao!,i<!!!'{>}}}}}},{{{<!!!!!>!>!{e}{!>},<!!!!!>,<,}oao!><>}}},{{{},{<u!!!!'u!>!!e!!ou'u'u}>},{{{<,a\"{o!!!eu\">},{<a!>'!!!>,<{!!!e!!!!\"e}!>},<<o{{!!!>},<u{u!>>}},{<>,<}'i,!!!>,<!>},<>},{{},{{<\"!>},<}!>,<o<!>,,!>,<ueu'!>,<>}}}}},{<!>,<!'ui\"<,u>,<!>,<<{\"!>},<!\"!>,<>}}}},{{{{{}},{{<e{{!ee!>,<a!>,<{!>!!,!!i'u!!!>,<!!!>!!!>>},{{<!!a>},<i<ee!'e{'!!'uoi'!>}>}},{{{{<a!!!!!>>}}},{{{<!>},<!!!>!>,<!!!>!!<!!!>!a!>,<<a!>,<!>!!!>!!!>{\",>},{}}}}}},{{{{<!!!!e!>,<<!!!>!>},<!}o>},<!!,'\",!!!>,!>,<!>},<!!o,!!!>},<!i<!>,<!>},<{>},{{<e!>},<!!\"{!>},<>},<a!!>},{{<!>,<e',ae!!!>\"!!<{,o!ai!!a}{!>>,{{<\"!!!>,!>},<<!{!>},<u!>,<!>,<>},<!iu'!>},<!!i!!i!!!>!!!>!>!>,<i!!u,!><a>}},{{<o!,ee<>}}}},{{{{<}!>,<<a!>oaa''!>!!!!!>!!o>},{<'<,!<\"o,!>},<!>},<ai!>!!<'o,!>>}}},{{<uea!>,<{'!>},<o!\",e!!u}{o!>},<{}!o>},{{<!>}<i!!o!>,<!uoo>},{<,!>!!!>'\"!!!>!><,ouo>}},{{<ea,\"uoao!>,<\"<>}}},{{{<!!ai,o''!!<e<{\"<eo!!!>>,{<\"!!!e}!!!>!!!u!!!>!!<!!!!!>},<{u}a>}},{<',!>,<o!>,<!>,<iu,!>,<>}}}},{{{{{<!>,<<!!!>!!{!!!!,>},<!!!ea!!!>\">}}},{{{{{<!>},<!>ue'u'!!\",!!!>}>}},{<!!ua!>,<!><!!,o!>,<}}{>}}},{{},{<ui!>},<!!}u!!!>,'!!uu{!!{<e<!!e!>,<!>>}},{{<i!!!>ua!!!>!!!>!!!>u!!'u!!!>},<!e>},{<!,!}!!e<!!'!>!!a!!!!!>!>},<,>}},{{{{<!!!>!!{}u!!!!ii!!!>\"a'>,{<ie,!}!>i'!ee'!>,<a!e!!!>{>}},{{<\"!!!>o!!!{o!>,<\"e!>,<\"!'{iao\"i>,<!!,e>},{},{}},{{<u<'<}>},{{},<!>o'!!oao!>!!!>},<!{!>},<>}}},{{<!>},<!>i,!!o>},{{}}}},{{},{{<!!o!!iu'>},<!!!>{a<eao>}},{}}}}},{{{{<}{>},<a!!!>!>,<u'!>,<!>,<{iio,'!!ui\">}},{{{{<!>,<i!!o>},{<{{\",'!!,!>,<!!}u!!a}\"!!!>\"<!>},<>}},{{{{<\"!!!!\"!e'!>,<!>'<!a!e<>}}},{<!,!>},<{\"i'i>}},{{{<<!>,<a!a{ao>},{<,>}},{},{{{<iui!!!>,<<},!}io!!,o{>},{{<,\"!!!!,e!>,<!>},<,!!!>e!>i!>,<u!!{i!!,!!!>},<>},<!}<}!!e!>,<!'{i!!!>},<!i!!!>!'{,!!i>}},{<u!!}!a!!!>!>,<!!!>}!!au!>},<a>,{}}}}}},{{{<>},{{<!iu<i!>{u,!o!>},<\"!>},<>}}},{<<!>!>,<!!!!!>!a>,<\"!!!>e!>,!>},<\"!u!!!>>}},{}}},{{{{{{<u!!,a\"<u!!'i,{>,<!!{>},{}},{}},{{{<uio!>,<'!{io{!>>}},{<!>},<!!o!>,<!',,}'!}i<e!o<oa!>,<!!!>e>,{{<<\"!>i!!!>e'!!!>,<>}}},{{<'!i>},{{},<{o!,>},{{{<!>,<ei!>!!,<!>,<!>!>,<{a>},<!<>},{{<!>},<a\"!!}o,!!!>u!!!>,o>,<uu!>!>},<>},<!eai!!!>!!!>,<i!>,<!}o\"!}!!!>o',!>},<!>},<>}}}},{}},{{{{{{<}!!!'a!!!!o\"'}!!ee!!,!>,<!\"\">}},{{<'<!uu\"!!!u'!!uua,!\"i!!,!>,<!!!>,<{>}},{<!u!!!>!o!!u>}},{{{<u,!!!!!>}!>},<!!!>!!\"}!!!>o,'!>,<!>!}o!i>},<!>!>},<eeei'!>!!u!>,<!!\",,!o!>'o!!,'>},{}}},{{<!>,<{e}!!!>e>},{{<!!<e!!!>!!\">,<a'\"!!<!>},<a!!i!>e\"}!!<<!!i!>},<!!!>},<>},{<!!!>'!>},<auu!!!!!!!>!>},<'>}}}},{{{<!>,<e\"\"!>,<i\">}},{<!!!>a!{!,<!>},<'<!>o'!>\"}!eea!>,<!!!!\">,{<!!!>!!<o{!>}!>},<}}!>,<,!e{!<e!>,<!>!aa>}}},{{{{{<o,!>},<i!>>},<!>,<,'>},{{<!><!o!a!!!>},<!!!!!>,\"!,\",}!{a!>,<!>,<!>>}},{{{},{{{<\"'\"'!!i<!ea!!!>,<i,!!!>e{u!}>},<!!!><u{!>!!!!!>i{\"!!\"\"u>},{}},{{<e!>},<a!!!>!>!!!>>}}},{{},<!a,!>,<,u\"!ao!eo\"!o<>}}}},{{{{<!>},<>},{{{{{{<e!>},<\"o},!>},<!{a>}},<i!!'!o!a!!!>},<a!>,<!!!!>},<!!i},<i!!!!<'!>,<'>}},{}}},{<!i,!i!>'}!!!!!>\"{}'\"!!!!>,{<ouia!!!!!>,<'!!!>',{!>!!}!!u!!<'!>,<!>},<>}},{{{{}},{<!>,<a}!!!>}>}}}},{{},{{<e}a!!}aa\"\"!!aa!!{!u!!!!!>>},{{},{{{{<!><!>!!!>u,!!i{!>},<'!>ao}{>,<!!!!a,o!!o'>},{{<'!!!>,!!eiu>},<}i!!!>,!!o}!!!!!!!>,<ao}u>}},{{{{{{<!>o<'!!e!!!{}!>},<!a>,<u!'!!u!>},<!>\"}!e!!!>a}{!>,<>},<!!!>!!!>>}},{}},{{<!!!>e!>},<>}},{{{<!,!>!!o}<'}}>}},{{<!!!!!!!!'!!!!,'!!!>!>,<},a!!>},{<>}},{{<{u\">}}}},{{},<!a!!!>\"}!!!>},<!>},<>},{{{<<>}}}},{{{<'a!!!>eouu!>,<!!!>,<uo!!a!!i>}},{}}},{<o!!!>a!>oe<!>},<<!!>,<!!!a,aui!>\"\"e!>'i}!>},<!a>}},{<i!>},<o!!!>,<a!>},<>,<}au!>},<!!!>u!>,<u!!!>},<e!!}a!!''!{>}}}}},{},{{{{<<!!!!!>{{!!!>!!oe!>,<\"!<o!>,<a>},{{<!\"e!>,<>}}}},{{<!>!>,<{!!!>u!>'!>},<>,{{<o!>},<,e>}}},{<<eaoee'!!!>,<a!!!>!!e!!!>,<!!!!!>\"!>o!>},<e>,{}},{<!>,<'!!!<!>'>,{{<!!a!>},<!!!>!>u\">}}}},{{<a\"!>,<'>,<!!!>,<uo!>,<ou,!!!>!>},<!!!>,<'u!!!>!>,<!!!>,<u>},{{{<ua!>,<}u!>,<!!!>!!!>!!!>!!!!'>},{<u'e}!!!>!!!,!!o!u!>},<\"<!!\"!>,<>}},{{<!>},<<o{u'>},{}}},{<!!\"!>u<ai!!!>!>,<!>}!!'o!>,<>,{}}}}}},{},{{{{{<iia!!ei\"!!!>\"\">},{<o,!>e!>!!{!!!>\"}i!>,>,{<<{!!\"'!>>}}}},{{<<!!},!!>},{{{},{{{},{<!,a!!!>},<e!<!!!!!>u!>u>}},{}}}}},{{},{<e!!!>{,<a!>},<!{,e!o!!!>!!>}}}}},{{{{<'<!!!>},<!!!>!!!!{!!!>u>}},{<a>,{}}},{},{{{<o!>},<}!>,<!!!>{!!!>,<!!a>},{<u!!'i!<!>!!!!!>,<!>!!!>!>,<!!>}},{{<e!>,<u!>e>},{<!!{!!!a\"u<!!o!!>,{<o'!!!>!!!>!!!>},<ui!>,<>}}}},{{{<!!!}!!!>{o'!>!>\"o\",o'<o!>a>}}}},{{{{<!\"!!!>{i,oe'!!,au!><!!!>},<u,>},{{{<ei!!!>!'i'a<>},<!!,!}!!!><a!!}'au!>\"!>,<!!!\"e''>}}},{{{<{o}!>,<\"\"!>,<<,'{u,<}<!}>},<{u!!!>!!!>!!e<>},{<>}},{{},{{},{<u{!!!!>,{<!}u!>},<'e!!!>!>,<!>!!!!,!!!!!>!!!>!>},<!>,<!!}!,>}}},{{},<e!!<\"eui!!eo>}},{{{<!'{!!!>'i{a!\"'!!!!!!!>>},<{u!>,<}<i\"!!!>i>},{{<!!}!>,<{!!a!>i!!,!>,<<!!aa!!>,<>},{<!!{e!!<}>}},{{<!!!>'!,>}}}},{{<o!!!>!>,<!!!>a!!!>!>,<'!>!>},<}!e'o!>,<a>,<!!!>,<!,\"!,!>i}!{!>,<!>},<<<a<>},{{<!>,<<!>'<!!!><!!\"o>,{<<,a}{\"!!!>'!>},<<<!!!>o!!a!>,<i>}}},{{{},<\"iae\"}!>u{!!!>!!\"{uoaa!>},<!!!>!>,<>},{{<{e!<}!<!!!>!!!>,!!'!!o{,!!!>,<{!a!!\">},{<!>,<}!>},<!u!>},<o!!<{u>}},{<o,!>,<i!}!!!!!>,<!!aa!>},<u<!!!>},<>,<{o!a!!!!e!>!,!>!i!>!i>}}},{{{},<!!aou},!!!!!!i!>u!>,<}u>},{<!!,!<!\"!!ea!!!!!>o}!i}i{!!!>},<!>,<'!<'>,{<!u{u!>!>,<,!>},<!>{<\">,{{}}}},{{},{{<i!!!>>}}}}}},{{{{{<!>},<u,!!!ui!!!><!uu!>},<!!!>e!!!{o!!a>}},{{}},{<o'<!!<>}},{{},{{{{<!\"!ii\",!!!>!!ea!!u',!!!>>},{}},<!!!>},<ua!!u!!!uio!!!>a>}}}},{{{{{{<!!!!'!!!!io,e,!!i!!!>'u>},<!!e!>},i!>},<e!>!!!>,<',}ee!>>},{<a!\"}!!oaoe!!!>iu\"{>,{}},{{{{{}}},{{<<!!{<!>euao>}}},{{{<\"}>,{<!>e\"!!!>{e>}},{<\"}\"!>},<'!>,<'!!!>i!o!>i}!!!>!a>}},{{<!>}!>},<!!!>{!>>}},{{}}},{{<!>,<\"!,!>},<!>ua<!!!>},<au!'\"!!,u{!>},<!!!>>},{<!>e>}}}}},{{{{}},{<!!!>!\"!>},<!,!>,<!>!!!>!!!>u!!!>,\"!,u!!!>!e}!!!>e>}},{{{{<!{!!}!>},<,'i<!>,<!{ee!!\">}},<!a\"!!{!!!>,<}i'{!>},<',>},{{<}!>{!>},<a!,<!>},<u>}}},{<o}u!!<'<!>,<i}!!i!<!i>}}},{{{{<>}},{}}},{{{<e!>!!<ee!!!>}\"a!!i!}!!\"!!uai>}},{{},{{{}},{<'o\"<e!!!!{}'!!!>,<\"o<\"!>>}},{}},{{<!!!>>,{{}}},{{<,!!!>uuu!>},<}{,u<}'{>}},{}},{{<i!!!!}u<!!!>'!>'!!!>,!!!>!!!>,<}o!>,<,i>,{<}!!!>'!>,<!!!>!!{!!u}'u}\"uo>,{<!>u}\"!>,<euo,!>,<ea,>,{{},<!!uia!!!!,<a!>,<u<!!!!!>e!!>}}}},{{<,ie>}},{<e!!!>\"!>,<!>ue!!!>,!!!!!>},<i!}!>!!!!!>i!>>,{{{<<a\"u,'!>ua!!!!{i!!{\">,{}}}}}}},{{{{<!>!!!!>},{{<!!a<{<!>},<>},<,i>},{<!!!>'!u'\"!!{!!e}>,{{}}}},{{<!>,<!!e!!!}!>,<u}i'o,!!u>,<!!i!>!>,<!!!!!!!!!>>},{},{{<!!!!,!>,<ue!!!,u!e!!{!!!>!>,<}'e>}}},{{{<<>}},{{<o{oi!>},<\"!!!!\"!e!!!>!>,<{,}u'!!!>>},{<ia!!!>!>},<}a'!>}>}},{{},{{<'!>},<!!i!!!>!!!>},<!!!>u},'!>,<o<i{ou!!>,{}},{{<!>,<!!a{{>,{<{!,o{<!>},<!!ea!>,<,!>},<!>!>,<'\"!>,<oi!}>}}}}}}},{},{{{<!>,<!>,<<!!!<!!!!!>,<u,ae>},{<}i!!au,'!>},<!>},<!!!!!!!>!>>,<\"!>},<!<\"!>,<!>,uio!>,<!>},<!!!>!!!><>},{}},{{{{{{<!>},<}\">},{<a!>,<!!!>>}},<{\"!!!>!!!>!!!>},<}!!!>},<!!!>\"'!!!!!>!>,<}>},{<!u!!!!!>!,<!!!>!>!!,<e{>}},{<!{!!}{o,u}a{!aa!>,!!!!}!!!>},<a>,<!>u!!!><a!>!!'},{oua!>},{!!!!!>>}},{{{<uua}<!!!>{,!!oe<>},<!>ue,!!!>!!!>},<!!u!!{e!!!>>},{{<\"\"a!!!!',,',!>},<u{a>},{<ei!!}!!!!!!!>{!!!>a!auo!>,<>}},{<!!e!>!!!>!>},<!>},<!>,<uoo!!!>,<iiui!!{!>,<!!!!!>,<!>},<>,{}}},{<\"!!!>!!!>!>,<!>},<!!!>!>}\">,<'!{!!!>!!!>\"!!!!!!!!o>}},{{{}}}},{{},{{{<io}\"{{e\"'!{<!!!>ui!>e>}}}}},{{{{{<{}<u!!!!!!!>o!!!>'!!}!!!uo!'!!!!!>>},<>},{<!!!>>,{}},{{{{{<>}},{<!\"!!!>\"!!oo!>}a,!!,uu!\"\"!!!>!>},<>}},{{<!!!>o>}},{{{{<>,<!>},<}!u!!!>,<{o}}\"!>},<e!!!!\"i!!!>,<}a>}},{{<i}!!!>{!!,iee!!!!!!{!>,<!>>}},{{},{<}!!!>!!!!!>{!>,<>,<!>},<e<!!,!!!!e!>,<!!!>>}}},{{},<!!!>},<<{ue}!oa\"\"!>oi<u!!i!>,<!i>},{{},{<!!u!'}i!!{!!!>,<!>,<!!!>},<!o'!!!>>,{<}!!!>!!!>,<a\"u!,>,{{},{<!o{!!!><{o>}}}},{{<>,{<!io!!'}e{!!!!!>!!!>!!!>!'}!!!>!aui>}}}}}}}},{{{{{},{<!\"i!><ua!>!>},<!!e>}}},{{{<!>,<!>{{!>,<{}\"i\"}!>},<!>},<<<{au>}},{<!<}!!a>},{{{{<!>,<!!!>,ai',!!!>i\"i!>}\">}}}}}},{{<!!!>}!!!<u'o','!>!!!>!>},<!!!!!>},<!>},<!!{>},{{{<'!i<}!!e>},{<!!!!!>oo!!<!u'!o\"ie!!!>!!!>ee{>}},{<>}}},{{{<o!!\"\"!!!!!!}{<e>},{<!!{!!!>>}},{<!!!>!>i!u!><!!!>e!!a!!!>i!!!>eu'>,{<i!!!>,<!!}!!!iu<a>}},{{},{<''u!>u!>},<,!!i\"!!!>{'}'!>},<!!!>i>}}},{{<!>,<!!{!!!>!>,<!<}!>,<>,<!>,<!!!>!!{a!!ao!i!<<u!}!!!!!>,<>},{},{<!!!!!!!!ui!i!!o\"aai}!'ue!!i!>,<\"i!!!!!!!<>}}}},{{<!>},<}'!i'a}>,<!!!!!>,<{!ueo{},!!!>,<!!!>'!>},<o!>,<o,}>},{<'!!<>,{<!>},<<!!!>!!!>ee!!<{!>,<o{{{>}},{{{<!>!!,>}},{<!!e}!>},<{u>},{{{{<!>},<,!>i{\"!o!>!>},<!>},<!><>},{{<!>},<eu!!\"!>},<<!>!!i\">}}}}}}},{{{<!o!'aa}{!!{<a\">}}}}},{{{{<',eua!>{>,<\"!!!!!!<\"!>,<!!'}u!>,<>}},{<!>,<''!!<{!>,<}}o!>},<ae>}},{{<oi!!!>!!!>!>},<!!!!!>o>,{}},{{{{}}},{{{<!!o>,<!o>},{}},{{{<}u!>,<>},{<!!}a<!!!>uo{,!>,<!a!!{{}!!!>,<!!!!!>!>,<!>>}},{<a{!a{\"!!!!,o!>},<iu{{!>a!{'o>,{{<!!!!'!!!>,<!a!!{,o!!!!!><'u>},{<!i}!!o\"!!}<!!ee!!!>!!o!>},<!!\"!>,<,>}}},{{<e!!}i}!i>},<o!>},<a'u!!!>\"!!e\"!!!>!>,<!>,<!iu{!'!>>}},{{<i!>,<!>,<e\">},<e<uo>}},{{{<!!!>e'!>},<''<e\"ue>},{{<}!!!o>}}},{{}}}}},{{<}!!!>},<u!!'e!!,!!!>,<!!!>!u!>,<!!\"!>},<}a!>,<!>>},{{<!!!>!!o!>},<!!o!>,<}!!!>i>},{{<!>,<!>,<>}}}},{{{{<o{\"}>},{<u!>,<,!!u>,<!>u!!!o<!io>}},{{}},{{{<\"{\"}'!>,<!}!!<!!!>,!!\"a!!!>}i>}},{{<!>{!!!>!!!>},<!>,<!>!!!>',e>},<a\"}a{e!>}{<ae<!>},<\"e>}}},{{<!>!>},<!<a!!o>},{<!!e{!!\"a<{i'!o<<!>},<!>,<!!!>o!!i!!!e>}},{{},{{{},{<\"!>,<!!!>a>}},{}}}}},{{{{{<'!!!>ie!!!,a!>}'!>,<!!<e!a!>!>>,{<,,}!>},<ua!!'!!!>i>}},{{},{<!>,<<!!!>},<,!!e>}},{}},{{<,ou!o!!\"e!!!>i{!>,<<>,{}},{<!!!!!>\"o!>},<{!!!>\"i\"!!!>>,{<{!>},<\"!>},<!>a!!!>>}}}},{{{<!!}'ao<{u!i<!>,,!!<\"!!!!ei>},{<!!!>a}i!>,<o!>},<!!!!!>!>},<>,<\"!>!!!\"u\"!>!>!>},<!!!!!>i!!<!>,<u!!{>},{}},{{<!>!>,<!!e>}},{{{{{<!>},<!>,<!<a!!!!!>o}!!{,!>,<!>,<u!>,<u>}},<,!>},<!!}e!}}!!!!!!!>!>!a'!!\"e!!}>}},{{}}}},{{{<\"i!>},<ie!i>},<,o!>},<!!eie!!!>!>,<<o<\",!>!>\">},{<{!>,<!!!>!!!>\"',!>},<>,<!>!!!>o!!!oe!!,!>\"!>},<,>}}}}}}"

score, garbage = get_score(data)
println(score)
println(garbage)
