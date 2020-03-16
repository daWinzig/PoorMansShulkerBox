# add content to nbt (like creative mode [<ctrl><m_click>])
data modify entity @s Item.tag.BlockEntityTag.Items set from block ~ ~ ~ Items
execute if entity @s[nbt={Item:{tag:{BlockEntityTag:{Items:[]}}}}] run data remove entity @s Item.tag.BlockEntityTag.Items
# add gametime to nbt -> make it unstackable (almost, would need pos or player uuid to make it perfect)
execute store result entity @s Item.tag.UID int 1 run time query gametime

# check if nested (everything with items inside; not empty)
execute unless entity @s[tag=dw_pmsb_invalid] if entity @s[nbt={Item:{tag:{BlockEntityTag:{Items:[{tag:{BlockEntityTag:{Items:[{}]}}}]}}}}] run tag @s add dw_pmsb_nested
# mark as invalid if nested
tag @s[tag=dw_pmsb_nested] add dw_pmsb_invalid
# break barrel (if nested)
execute if entity @s[tag=dw_pmsb_nested] run data modify block ~ ~ ~ CustomName set value '{"italic":false,"color":"red","text":"Broken Poor Man\'s Shulker Box"}'
execute if entity @s[tag=dw_pmsb_nested] run setblock ~ ~ ~ minecraft:air destroy
execute if entity @s[tag=dw_pmsb_nested] run playsound minecraft:block.wooden_trapdoor.close block @a[distance=..15] ~ ~ ~ 1 .5

# delete barrel-block (if valid)
execute unless entity @s[tag=dw_pmsb_invalid] run setblock ~ ~ ~ minecraft:air replace

# set lore
#- create copy of content
data modify entity @s Item.tag.Temp set from entity @s Item.tag.BlockEntityTag.Items
#- get content length (capped at 5)
execute store result score @s dw_pmsb_misc run data get entity @s Item.tag.BlockEntityTag.Items
scoreboard players set @s[scores={dw_pmsb_misc=5..}] dw_pmsb_misc 5
#- set 'empty' Lore (if empty)
execute if entity @s[scores={dw_pmsb_misc=0}] run data modify entity @s Item.tag.display.Lore set value ['{"color":"gray","text":"- empty -"}']
#- set Lore: content text (if not empty)
execute if entity @s[scores={dw_pmsb_misc=1..}] unless entity @s[tag=dw_pmsb_invalid] run function dw_pmsb:pack/lore
#- get additional content length
execute store result score @s dw_pmsb_misc run data get entity @s Item.tag.Temp
#- append Lore: additional content length
#-- format text 
tag @s add dw_pmsb_lore
setblock ~ ~ ~ minecraft:acacia_sign{Text1:'[{"text":"and ","color":"gray"},{"score":{"name":"@e[type=item,limit=1,sort=nearest,tag=dw_pmsb_lore]","objective":"dw_pmsb_misc","color":"gray"}},{"text":" more...","color":"gray"}]'} replace
tag @s remove dw_pmsb_lore
#-- set text
data modify entity @s[scores={dw_pmsb_misc=1..}] Item.tag.display.Lore append from block ~ ~ ~ Text1
# clean up
setblock ~ ~ ~ minecraft:air replace
scoreboard players reset dw_pmsb_cnt_t dw_pmsb_misc
data remove entity @s Item.tag.Temp

# add sound effect
execute if entity @s[tag=!dw_pmsb_invalid] run playsound minecraft:block.chest.close block @a[distance=..15] ~ ~ ~ 1 .5

# remove kill tag if valid
tag @s[tag=!dw_pmsb_invalid] remove dw_pmsb_kill