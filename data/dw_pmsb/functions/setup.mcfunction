# create bound scoreboards
scoreboard objectives add dw_pmsb_sneak minecraft.custom:minecraft.sneak_time {"text":"Sneaking","color":"gray"}
scoreboard objectives add dw_pmsb_mined minecraft.mined:minecraft.barrel {"text":"Mined Barrel","color":"gray"}
# create dummy scoreboards
scoreboard objectives add dw_pmsb_misc dummy {"text":"Temporary System Memory","color":"gray"}

# set global const
scoreboard players set dw_pmsb_Mod dw_pmsb_misc 60