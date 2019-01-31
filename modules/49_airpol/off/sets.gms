*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

sets

emis_fire_all(emis_source)       Emission sources common with the GFED data
/
  primforest_vegc, secdforest_vegc, past_vegc, other_vegc,forestry_vegc, resid_burn, deforest
/

emis_fire_non_gfed (emis_source)
   / inorg_fert, man_crop, awms, resid, man_past, som,
     rice, ent_ferm,
     crop_vegc, crop_litc, crop_soilc,
     past_litc, past_soilc,
     forestry_litc, forestry_soilc,
     primforest_litc, primforest_soilc,
     secdforest_litc, secdforest_soilc,
     urban_vegc, urban_litc, urban_soilc,
     other_litc, other_soilc,
     beccs
    /

emis_fire49(emis_fire_all)       Emission sources common with the GFED data
/
  primforest_vegc, secdforest_vegc, past_vegc, other_vegc,forestry_vegc, deforest
/


emis49(land)       Emission sources common with the GFED data
/
  primforest,secdforest,forestry,past,other
/


gfed_emis_cat GFED emission categories
/
sava, borf, temf, defo, peat, agri, natveg
/

pol_map(emis_fire49,emis49) mapping between land and pollution
      /
       past_vegc         . (past)
       other_vegc        . (other)
       primforest_vegc   . (primforest)
       secdforest_vegc   . (secdforest)
       forestry_vegc     . (forestry)
      /

;
