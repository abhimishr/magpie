*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Fixing variables
*vm_prod_heaven_timber.fx(j,kforestry) = 0;
v73_prod_natveg.fx(j,"other",ac_sub,"wood") = 0;
vm_hvarea_other.fx(j,ac_sub,"wood") = 0;
v73_prod_natveg.fx(j,"primforest",ac_sub,kforestry)$(not sameas(ac_sub,"acx")) = 0;

****************** IIASA demand ******************
*' Taken from Supply and demand functions for global wood markets: Specification and
*' plausibility testing of econometric models within the global forest sector.
*' https://doi.org/10.1016/j.forpol.2018.04.003
*' Fiberboard value used for wood, Fuelwood value used for wood fuel (Table 5).
p73_elasticity("wood") = 1.06;
p73_elasticity("woodfuel") = -0.568;

** Select population at iso level
fm_pop_iso(t_all,iso,"%c09_pop_scenario%")$(fm_pop_iso(t_all,iso,"%c09_pop_scenario%")=0) = 0.001;
fm_gdp_ppp_iso(t_all,iso,"%c09_gdp_scenario%")$(fm_gdp_ppp_iso(t_all,iso,"%c09_gdp_scenario%")=0) = 0.001;
fm_gdp_ppp_iso(t_all,iso,"%c09_gdp_scenario%") = fm_gdp_ppp_iso("y1995",iso,"%c09_gdp_scenario%");

** Calculate gdp per capita at iso level
i73_gdp_ppp_pc_iso(t_all,iso,"%c09_gdp_scenario%") = fm_gdp_ppp_iso(t_all,iso,"%c09_gdp_scenario%")/fm_pop_iso(t_all,iso,"%c09_pop_scenario%");

*******************************************************************************
p73_income_elasticity("wood_fuel") = 0.57;
p73_income_elasticity("wood_pulp") = 0.36;
p73_income_elasticity("particle_board_and_osb") = 0.75;
p73_income_elasticity("fibreboard") = 1.06;
p73_income_elasticity("plywood") = 0.94;
p73_income_elasticity("veneer_sheets") = 0.60;
p73_income_elasticity("sawnwood") = 0.19;
p73_income_elasticity("other_industrial_roundwood") = 0.22;
** veneer_sheets and other_industrial_roundwood from buongiorno paper
p73_income_elasticity("other_sawnwood") = p73_income_elasticity("sawnwood");

** Set historical values to FAO values
pm_forestry_demand_prod_specific(t_past_ff,iso,total_wood_products) = f73_prod_specific_timber(t_past_ff,iso,total_wood_products);

** Initialize with dummy values
pm_demand_timber_nextyr(t_all,iso,total_wood_products) = 0;

** Loop over time to calculate future demand
t_all_ct(t_all) = no;
*loop(t_all$(ord(t_all)>card(t_past_ff)-1),
loop(t_all$(m_year(t_all) >= 1990),
   pm_forestry_demand_prod_specific(t_all+1,iso,total_wood_products)
          = pm_forestry_demand_prod_specific(t_all,iso,total_wood_products)
          *
          (fm_pop_iso(t_all+1,iso,"%c09_pop_scenario%")/fm_pop_iso(t_all,iso,"%c09_pop_scenario%"))
          *
          ((i73_gdp_ppp_pc_iso(t_all+1,iso,"%c09_gdp_scenario%")/i73_gdp_ppp_pc_iso(t_all,iso,"%c09_gdp_scenario%"))**p73_income_elasticity(total_wood_products))
          ;

    t_all_ct(t_all) = yes;

    display t_all_ct;

*    display pm_forestry_demand_prod_specific;

    t_all_ct(t_all) = no;
);

pm_iiasa_timber(t_all,i,kforestry) = sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)),pm_forestry_demand_prod_specific(t_all,iso,total_wood_products));

** Woodfuel fix

pm_iiasa_timber(t_all,i,"woodfuel") = (pm_iiasa_timber(t_all,i,"woodfuel") * 0.50)$(im_development_state(t_all,i)<1)
      + (pm_iiasa_timber(t_all,i,"woodfuel"))$(im_development_state(t_all,i)=1);

pm_iiasa_GLO(t_all,kforestry) = sum(i,pm_iiasa_timber(t_all,i,kforestry));
display pm_iiasa_GLO;

pm_demand_ext(t_ext,i,kforestry) = pm_iiasa_timber("y2150",i,kforestry);
pm_demand_ext(t_all,i,kforestry) = pm_iiasa_timber(t_all,i,kforestry);

***** Calculate model estimate per capita
p73_wood_products_demand_pc(t,iso,wood_panels) =1.044e-05*(im_gdp_pc_ppp_iso(t,iso)**0.9063);

p73_wood_products_demand_pc(t,iso,"wood_pulp") = 9.984e-07*(im_gdp_pc_ppp_iso(t,iso)**1.218);

p73_wood_products_demand_pc(t,iso,"sawnwood") = 7.204e-05*(im_gdp_pc_ppp_iso(t,iso)**0.8023);

p73_wood_products_demand_pc(t,iso,"wood_fuel") = sum(wood_panels,p73_wood_products_demand_pc(t,iso,wood_panels) * 0.3);

loop(t,
  if (sum(sameas(t_past,t),1) = 1,

      p73_calibration_timber_demand_pc(t,iso,wood_products)
      =
      f73_observed_timber_demand_pc(t,iso,wood_products)
      -
      p73_wood_products_demand_pc(t, iso, wood_products);

      p73_calib_lastyr_pc(iso,wood_products)
      =
      p73_calibration_timber_demand_pc(t,iso,wood_products);

  else

      p73_calibration_timber_demand_pc(t,iso,wood_products)
      =
      p73_calib_lastyr_pc(iso,wood_products);

  );
);

** Calibrated_pc is the value we get based on calibration value we create and add on top of model estimate
p73_calibrated_pc(t,iso,wood_products)
=
p73_wood_products_demand_pc(t, iso, wood_products)
+
p73_calibration_timber_demand_pc(t,iso,wood_products);

** Total demand is calculated based on pc demand multiplied by population
p73_calibrated_abs(t,iso,wood_products)
= p73_calibrated_pc(t,iso,wood_products) * im_pop_iso(t,iso);

p73_calibrated_abs_glo(t)
= sum((iso,total_wood_products),p73_calibrated_abs(t,iso,total_wood_products));

p73_wood_products_demand_reg(t,i,kforestry)
= sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)), p73_wood_products_demand_pc(t,iso,total_wood_products)*im_pop_iso(t,iso));

p73_wood_products_demand_GLO(t,kforestry) = sum(i,p73_wood_products_demand_reg(t,i,kforestry));

*display p73_calibrated_abs_glo,p73_wood_products_demand_GLO,p73_wood_products_demand_reg;