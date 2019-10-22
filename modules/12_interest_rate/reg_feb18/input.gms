*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c12_interest_rate  low

table f12_interest_bound(t,bound12) Lower and higher bounds of interest rates (% per yr)
$ondelim
$include "./modules/12_interest_rate/input/f12_interest_rate_bound.cs3"
$offdelim
;


$if "%c12_interest_rate%" == "coupling" parameter f12_interest_coupling(t_all) Interest rate (% per yr)
$if "%c12_interest_rate%" == "coupling" /
$if "%c12_interest_rate%" == "coupling" $ondelim
$if "%c12_interest_rate%" == "coupling" $include "./modules/12_interest_rate/input/f12_interest_rate_coupling.csv"
$if "%c12_interest_rate%" == "coupling" $offdelim
$if "%c12_interest_rate%" == "coupling" /
$if "%c12_interest_rate%" == "coupling" ;

table fm_interest(t_all,scen12)  Interest rate scenarios (% per yr)
$ondelim
$include "./modules/12_interest_rate/input/f12_interest_rate.cs3"
$offdelim
;

fm_interest(t_all,"1pc") =  0.01;
fm_interest(t_all,"15pc") =  0.15;
fm_interest(t_past,"1pc") =  fm_interest(t_past,"medium");
fm_interest(t_past,"15pc") =  fm_interest(t_past,"medium");
