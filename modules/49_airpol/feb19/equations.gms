*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


q49_emission(i2,emis_fire49,pollutants_gfed) ..
                 vm_btm_reg(i2,emis_fire49,pollutants_gfed)
                 =e=
                 sum((pol_map(emis_fire49,emis49),cell(i,j)),vm_land(j,emis49))
                 *sum((i_to_iso(i,iso),pol_map(emis_fire49,emis49)),f49_emis_factor_land(iso,emis49,pollutants_gfed))
                 ;

q49_emis_deforest(i2,pollutants_gfed) ..
                 vm_btm_reg(i2,"deforest",pollutants_gfed)
                 =e=
                vm_btm_reg(i2,"deforest","co2_c") * f49_emis_factor_c(pollutants_gfed,"defo")
                 ;

q49_emis_residues(i2,pollutants_gfed) ..
                  vm_btm_reg(i2,"resid_burn",pollutants_gfed)
                  =e=
                  sum(kcr,vm_res_ag_burn(i2,kcr,"c")) * f49_emis_factor_c(pollutants_gfed,"agri");
