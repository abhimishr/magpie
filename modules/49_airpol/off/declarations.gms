*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


equations
 q49_emission(i,emis_fire49,pollutants_gfed)          Emission from GFED data (mio. ton)
 q49_emis_residues(i,pollutants_gfed)                 Agricultural emissions (mio. ton)
 q49_emis_deforest(i,pollutants_gfed)                 Deforestation emissions (mio. ton)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq49_emission(t,i,emis_fire49,pollutants_gfed,type) Emission from GFED data (mio. ton)
 oq49_emis_residues(t,i,pollutants_gfed,type)        Agricultural emissions (mio. ton)
 oq49_emis_deforest(t,i,pollutants_gfed,type)        Deforestation emissions (mio. ton)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
