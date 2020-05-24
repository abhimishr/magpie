$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
$setglobal c32_aff_policy  npi
$setglobal c32_rot_length  rlGTM
$setglobal c32_rot_length_estb  rlGTM
$setglobal c32_bef  ipccBEF
$setglobal c32_timber_plantations  plantations

scalars
  s32_reESTBcost Reestablishment cost in USD per ha / 2000 /
  s32_recurring_cost Recurring costs in USD per ha / 100 /
  s32_harvesting_cost Harvesting cost in USD per ha / 200 /
  s32_planing_horizon Afforestation planing horizon (years)            / 50 /
  s32_recurring_cost_multiplier Cost multiplier for recurring costs only for testing (1)            / 10 /
  s32_rotation_extension Rotation extension in percentage terms / 1 /
  s32_faustmann_rotation Switch to activate faustmann rotations / 0 /
  s32_initial_distribution Switch to Activate ageclass distribution in plantations / 1 /
  s32_price     Price for timber (only used in faustmann calculations)      / 45      /
;

scalars
  s32_max_aff_area         maximum total global afforestation in Mha    / Inf /
  s32_aff_plantation switch for using natveg (0) or plantation (1) growth curves for afforestation / 0 /
  s32_timber_plantation switch for using natveg (0) or plantation (1) growth curves for plantations / 1 /
;

parameter f32_aff_mask(j) afforestation mask (binary)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/;

table f32_fac_req_ha(i,fcosts32) Afforestation factor requirement costs (US Dollar 2004 per ha per annum)
$ondelim
$include "./modules/32_forestry/input/f32_fac_req_ha.csv"
$offdelim
;
f32_fac_req_ha(i,"recur") = f32_fac_req_ha(i,"recur") * s32_recurring_cost_multiplier;

parameter fm_harvest_cost_ha(i) Harvesting cost (US Dollar 2004 per ha)
/
$ondelim
$include "./modules/32_forestry/input/f32_harvestingcost.cs4"
$offdelim
/
;

table f32_aff_pol(t_all,j,pol32) npi+ndc afforestation policy (Mha new forest wrt to 2010)
$ondelim
$include "./modules/32_forestry/input/npi_ndc_aff_pol.cs3"
$offdelim
;

parameter f32_plant_prod_share(t_all) share (percentage)
/
$ondelim
$include "./modules/32_forestry/input/f32_plant_prod_share.csv"
$offdelim
/
;