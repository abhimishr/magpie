*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

table f49_emis_factor_land(iso,emis49,pollutants) GFED data
$ondelim
$include "./modules/49_airpol/input/f49_emis_factor_land.cs3"
$offdelim
;

table f49_emis_factor_c(pollutants,gfed_emis_cat) GFED data
$ondelim
$include "./modules/49_airpol/input/f49_emis_factors_C.cs3"
$offdelim
;
