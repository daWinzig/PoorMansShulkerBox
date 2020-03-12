# check for sneaking and barrel
execute as @a[scores={dw_pmsb_sneak=1..}] at @s align xyz positioned ~.4 ~-.8 ~.4 if block ~ ~ ~ minecraft:barrel run tag @s add dw_pmsb_pack
# run pack 
execute as @a[tag=dw_pmsb_pack] at @s align xyz positioned ~.4 ~-.8 ~.4 run loot spawn ~ ~ ~ mine ~ ~ ~ minecraft:air
execute at @a[tag=dw_pmsb_pack] align xyz positioned ~.4 ~-.8 ~.4 as @e[type=item,distance=..1,sort=nearest,limit=1,nbt={Item:{id:"minecraft:barrel"},Age:0s}] run function dw_pmsb:pack/pack

# run mined if barrel is broken
execute as @a[scores={dw_pmsb_mined=1..}] at @s as @e[type=item,distance=..7,nbt={Item:{tag:{display:{Name:'{"italic":false,"color":"white","text":"Poor Man\'s Shulker Box"}'}}}}] unless data entity @s Item.tag.display.Lore at @s run function dw_pmsb:mine/mined

# clean up scores / tags
execute as @a[scores={dw_pmsb_sneak=1..}] run scoreboard players reset @s dw_pmsb_sneak
execute as @a[scores={dw_pmsb_mined=1..}] run scoreboard players reset @s dw_pmsb_mined
tag @a[tag=dw_pmsb_pack] remove dw_pmsb_pack

# add hermit-root advancement
advancement grant @a only dw_hermit:root