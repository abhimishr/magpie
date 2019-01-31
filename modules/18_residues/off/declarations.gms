*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_res_biomass_ag(i,kcr,attributes)                   production of aboveground residues in each region (mio. tDM)
 vm_res_biomass_bg(i,kcr,dm_nr)                   production of belowground residues in each region (mio. tDM)
 vm_res_recycling(i,npk)                residues recycled to croplands (mio tons nutrients)
 vm_res_ag_burn(i,kcr,attributes)          Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_res_biomass_ag(t,i,kcr,attributes,type) production of aboveground residues in each region (mio. tDM)
 ov_res_biomass_bg(t,i,kcr,dm_nr,type)      production of belowground residues in each region (mio. tDM)
 ov_res_recycling(t,i,npk,type)             residues recycled to croplands (mio tons nutrients)
 ov_res_ag_burn(t,i,kcr,attributes,type)    Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
