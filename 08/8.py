#!/usr/bin/env python
from operator import mul


n = ('731671765313306249192251196744265747423553491949349698352031277450632623'
     '957831801698480186947885184385861560789112949495459501737958331952853208'
     '805511125406987471585238630507156932909632952274430435576689664895044524'
     '452316173185640309871112172238311362229893423380308135336276614282806444'
     '486645238749303589072962904915604407723907138105158593079608667017242712'
     '188399879790879227492190169972088809377665727333001053367881220235421809'
     '751254540594752243525849077116705560136048395864467063244157221553975369'
     '781797784617406495514929086256932197846862248283972241375657056057490261'
     '407972968652414535100474821663704844031998900088952434506585412275886668'
     '811642717147992444292823086346567481391912316282458617866458359124566529'
     '476545682848912883142607690042242190226710556263211111093705442175069416'
     '589604080719840385096245544436298123098787992724428490918884580156166097'
     '919133875499200524063689912560717606058861164671094050775410022569831552'
     '000559357297257163626956188267042825248360082325753042075296345')

i, j = 0, 13
maximal_value, maximal_i = 0, 0
while j < 1000:
    current = reduce(mul, map(int, n[i:j]))
    if current > maximal_value:
        maximal_value = current
        maximal_i = i

    i += 1
    j += 1

print reduce(mul, map(int, n[maximal_i:maximal_i + 13]))
