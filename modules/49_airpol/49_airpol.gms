*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @title Air pollution
*'
*' @description The airpol module provides air pollution using global fire
*' emissions database.
*'
*' @authors Abhijeet Mishra, Benjamin Leon Bodirsky

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%airpol%" == "feb19" $include "./modules/49_airpol/feb19.gms"
$Ifi "%airpol%" == "off" $include "./modules/49_airpol/off.gms"
*###################### R SECTION END (MODULETYPES) ############################
