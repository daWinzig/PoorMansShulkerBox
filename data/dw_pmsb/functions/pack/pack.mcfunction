# add kill tag
tag @s add dw_pmsb_kill

# change anvil edited 'Shulkerbox' to final name
execute if entity @s[nbt={Item:{tag:{display:{Name:'{"text":"Shulkerbox"}'}}}}] run data modify entity @s Item.tag.display.Name set value '{"italic":false,"color":"white","text":"Poor Man\'s Shulker Box"}'

# check barrel name
execute unless entity @s[nbt={Item:{tag:{display:{Name:'{"italic":false,"color":"white","text":"Poor Man\'s Shulker Box"}'}}}}] run tag @s add dw_pmsb_invalid

execute align xyz positioned ~.5 ~.5 ~.5 run particle minecraft:block minecraft:barrel ~ ~ ~ 0 0 0 1 10

execute store result score @s dw_pmsb_misc run data get entity @s UUIDMost 0.0000000001
scoreboard players operation @s dw_pmsb_misc %= dw_pmsb_Mod dw_pmsb_misc

# execute block break / manage drops
execute if score @s dw_pmsb_misc matches 0 unless entity @s[tag=dw_pmsb_invalid] run function dw_pmsb:pack/drop

# kill item
kill @s[tag=dw_pmsb_kill]

scoreboard players reset @a[distance=..3] dw_pmsb_sneak