*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

s73_counter = 0;

if(ord(t)>1,

while(floor(smax((i,kforestry), sum(cell(i,j),v73_prod_heaven_timber.l(j,kforestry)))) > 0 AND s73_counter <= s73_maxiter,

**** Update prices in intersolve -- will fail codecheck
*    pm_prices_woodymass(t,i,kforestry) = q16_supply_forestry.m(i,kforestry);
*    pm_prices_woodymass("y1995",i,kforestry)$(pm_prices_woodymass("y1995",i,kforestry)=0) = 1;

    p73_price_ratio_before(t,i,kforestry) = pm_prices_woodymass(t,i,kforestry)/pm_prices_woodymass("y1995",i,kforestry);

    s73_counter = s73_counter + 1;
    p73_criterion = floor(smax((i,kforestry), sum(cell(i,j),v73_prod_heaven_timber.l(j,kforestry))));
  	display p73_criterion;
  	display "Warning: There are trade imbalances for timber. Restarting solve with adjusted timber demand!";

    if (s73_price_adjuster = 1,
      p73_price_ratio(t,i,kforestry) = pm_prices_woodymass(t,i,kforestry)/pm_prices_woodymass("y1995",i,kforestry);
** Clipping price index to 300%
      p73_price_ratio(t,i,kforestry)$(p73_price_ratio(t,i,kforestry)>3) = 3;
** Only adjust for positive numbers (<1 will mean reduction)
      pm_demand_ext(t,i,kforestry)$(p73_price_ratio(t,i,kforestry) > 0) = pm_demand_ext(t,i,kforestry) * (p73_price_ratio(t,i,kforestry)**s73_price_elasticity);
      pm_demand_ext(t,i,kforestry)$(pm_demand_ext(t,i,kforestry)<1) = 1;

      else

      pm_demand_ext(t,i,kforestry) = pm_demand_ext(t,i,kforestry) - sum(cell(i,j),v73_prod_heaven_timber.l(j,kforestry));
    );

    p73_timder_adjustment_ratio(t,i,"wood") = pm_demand_ext(t,i,"wood")/pm_demand_ext_original(t,i,"wood");
    p73_timder_adjustment_ratio(t,i,"woodfuel") = pm_demand_ext(t,i,"woodfuel")/pm_demand_ext_original(t,i,"woodfuel");

    if(round(smin(i,p73_timder_adjustment_ratio(t,i,"wood")),2) < 0.75 OR round(smin(i,p73_timder_adjustment_ratio(t,i,"woodfuel")),2) < 0.75,
    display "Warning: Ratio between prescribed demand and adjusted demand in some regions diverge heavily!";
    display p73_timder_adjustment_ratio;
    );

	s73_counter2 = 0;
	repeat(
      s73_counter2 = s73_counter2 + 1;
	  solve magpie USING nlp MINIMIZING vm_cost_glo;
* if solve stopped with an error, try it again with conopt3
	  if((magpie.modelstat = 13),
      	display "WARNING: Modelstat 13 | retry with CONOPT3!";
      	option nlp = conopt;
        solve magpie USING nlp MINIMIZING vm_cost_glo;
      	option nlp = conopt4;
       );
$batinclude "./modules/include.gms" price_update       
* write extended run information in list file in the case that the final solution is infeasible
  if((s73_counter2 >= (s73_maxiter2-1) and magpie.modelstat > 2 and magpie.modelstat ne 7),
    magpie.solprint = 1
  );
  until (magpie.modelstat <= 2 or s73_counter2 >= s73_maxiter2)
);

if ((magpie.modelstat < 3),
  put_utility 'shell' / 'mv -f magpie_p.gdx magpie_' t.tl:0'.gdx';
);

if ((magpie.modelstat > 2 and magpie.modelstat ne 7),
  Execute_Unload "fulldata.gdx";
  abort "no feasible solution found!";
);

);

);