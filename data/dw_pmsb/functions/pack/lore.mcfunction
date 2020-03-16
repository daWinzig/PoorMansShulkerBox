# add identifier
tag @s add dw_pmsb_lore

# get item count
execute store result score dw_pmsb_Count dw_pmsb_misc run data get entity @s Item.tag.Temp[0].Count 1

# 
setblock ~ ~ ~ minecraft:acacia_sign{Text1:'[{"nbt":"Item.tag.Temp[0].id","entity":"@e[type=item,limit=1,sort=nearest,tag=dw_pmsb_lore]","color":"gray","italic":false},{"text":" x","color":"gray","italic":false},{"score":{"name":"dw_pmsb_Count","objective":"dw_pmsb_misc","color":"gray","italic":false}}]'} replace

# append text
data modify entity @s Item.tag.display.Lore append from block ~ ~ ~ Text1

# clean up
setblock ~ ~ ~ minecraft:air replace
tag @s remove dw_pmsb_lore
scoreboard players reset dw_pmsb_Count dw_pmsb_misc
data remove entity @s Item.tag.Temp[0]

# loop
scoreboard players remove @s dw_pmsb_misc 1
execute if score @s dw_pmsb_misc matches 1.. run function dw_pmsb:pack/lore