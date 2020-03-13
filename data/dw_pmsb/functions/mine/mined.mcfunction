# break barrel
data modify entity @s Item.tag.display.Name set value '{"italic":false,"color":"red","text":"Broken Poor Man\'s Shulker Box"}'
playsound minecraft:block.wooden_trapdoor.close block @a[distance=..15] ~ ~ ~ 1 .5

# reset score
scoreboard players reset @s dw_pmsb_mined