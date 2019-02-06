*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


q49_emission(i2,emis_fire49,pollutants_gfed) ..
                 vm_btm_reg(i2,emis_fire49,pollutants_gfed)
                 =g=
                 0
                 ;

q49_emis_deforest(i2,pollutants_gfed) ..
                 vm_btm_reg(i2,"deforest",pollutants_gfed)
                 =g=
                 0
                 ;

q49_emis_residues(i2,pollutants_gfed) ..
                    vm_btm_reg(i2,"resid_burn",pollutants_gfed)
                    =g=
                    0;
