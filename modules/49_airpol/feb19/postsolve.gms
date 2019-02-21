*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

p49_burn_emis(t,i,emis_fire49,pollutants_gfed) = vm_btm_reg.l(i,emis_fire49,pollutants_gfed);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 oq49_emission(t,i,emis_fire49,pollutants_gfed,"marginal") = q49_emission.m(i,emis_fire49,pollutants_gfed);
 oq49_emis_residues(t,i,pollutants_gfed,"marginal")        = q49_emis_residues.m(i,pollutants_gfed);
 oq49_emis_deforest(t,i,pollutants_gfed,"marginal")        = q49_emis_deforest.m(i,pollutants_gfed);
 oq49_emission(t,i,emis_fire49,pollutants_gfed,"level")    = q49_emission.l(i,emis_fire49,pollutants_gfed);
 oq49_emis_residues(t,i,pollutants_gfed,"level")           = q49_emis_residues.l(i,pollutants_gfed);
 oq49_emis_deforest(t,i,pollutants_gfed,"level")           = q49_emis_deforest.l(i,pollutants_gfed);
 oq49_emission(t,i,emis_fire49,pollutants_gfed,"upper")    = q49_emission.up(i,emis_fire49,pollutants_gfed);
 oq49_emis_residues(t,i,pollutants_gfed,"upper")           = q49_emis_residues.up(i,pollutants_gfed);
 oq49_emis_deforest(t,i,pollutants_gfed,"upper")           = q49_emis_deforest.up(i,pollutants_gfed);
 oq49_emission(t,i,emis_fire49,pollutants_gfed,"lower")    = q49_emission.lo(i,emis_fire49,pollutants_gfed);
 oq49_emis_residues(t,i,pollutants_gfed,"lower")           = q49_emis_residues.lo(i,pollutants_gfed);
 oq49_emis_deforest(t,i,pollutants_gfed,"lower")           = q49_emis_deforest.lo(i,pollutants_gfed);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
