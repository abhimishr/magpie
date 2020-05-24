*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*****Costs**********************************************************************

*' The direct costs of Timber production and afforestation `vm_cost_fore` include
*' maintenance and monitoring costs for newly established plantations as well as
*' standing plantations '[@sathaye_ghg_2005]. In addition, this type of forest management
*' (including afforestation) may cause costs in other parts of the model such as costs
*' for technological change [13_tc] or land expansion [39_landconversion]. Also included
*' are additional costs for producing timber from extremely highly managed plantations
*' which are analogous to intensification using technological change from [13_tc] but
*' in a parametrized form.

q32_cost_total(i2) .. vm_cost_fore(i2) =e=
								   v32_cost_recur(i2)
								   + v32_cost_establishment(i2)
								   + sum(cell(i2,j2), v32_land_missing(j2)) * 1000000
								   ;

*****C-PRICE INDUCED AFFORESTATION
*****forestry emissions seen in maccs module************************************
*' The interface `vm_cdr_aff` provides the projected CDR of an afforestation
*' activity for a planning horizon of 30 years `s32_planing_horizon` to the [56_ghg_policy] module.

q32_cdr_aff(j2,ac) ..
vm_cdr_aff(j2,ac) =e=
v32_land(j2,"aff","ac0") * sum(ct, p32_cdr_ac(ct,j2,ac))
+ v32_land(j2,"plant","ac0") * sum(ct, p32_cdr_ac_plant(ct,j2,ac))
;

*ac0 can only increase if total afforested land increases
q32_aff_ac0(j2) ..
v32_land(j2,"aff","ac0") =l= sum(ac, v32_land(j2,"aff",ac)) - sum((ct,ac), p32_land(ct,j2,"aff",ac));

*****GENERAL
*****Land***************************************************
*' The interface `vm_land` provides aggregated forestry land pools (`type32`) to other modules.

 q32_land(j2) ..
 vm_land(j2,"forestry") =e= sum((type32,ac), v32_land(j2,type32,ac));

*' The constraint `q32_aff_pol` accounts for the exogenous afforestation prescribed by NPI/NDC policies.

 q32_aff_pol(j2) ..
 v32_land(j2,"ndc","ac0") =e= sum(ct, p32_aff_pol_timestep(ct,j2));

*' The constraint `q32_max_aff` accounts for the allowed maximum global
*' carbon-price induced endogenous afforestation defined in `s32_max_aff_area`.
*' Note that NPI/NDC afforestation policies are not counted towards the
*' maximum defined in `s32_max_aff_area`. Therefore, the right-hand side of the constraint
*' is relaxed by the value of exogenously prescribed afforestation (`p32_aff_togo`).

 q32_max_aff .. sum((j2,type32,ac)$(not sameas(type32,"plant")), v32_land(j2,type32,ac))
                =l= p32_max_aff_area - sum(ct, p32_aff_togo(ct));

*****Carbon stocks**************************************************************
*' Forestry above ground carbon stocks are calculated as the product of forestry land (`v32_land`) and the area
*' weighted mean of carbon density for carbon pools (`p32_carbon_density_ac`).

 q32_carbon(j2,ag_pools)  .. vm_carbon_stock(j2,"forestry",ag_pools) =e=
                         sum((type32,ac), v32_land(j2,type32,ac)*
                         sum(ct, p32_carbon_density_ac(ct,j2,type32,ac,ag_pools)));

*' Forestry land expansion and reduction is calculated as follows:

 q32_land_diff .. vm_landdiff_forestry =e= sum((j2,type32,ac),
 					  v32_land_expansion(j2,type32,ac)
 					+ v32_land_reduction(j2,type32,ac));

 q32_land_expansion(j2,type32,ac) ..
 	v32_land_expansion(j2,type32,ac) =g= v32_land(j2,type32,ac) - pc32_land(j2,type32,ac);

 q32_land_reduction(j2,type32,ac) ..
 	v32_land_reduction(j2,type32,ac) =g= pc32_land(j2,type32,ac) - v32_land(j2,type32,ac);

*------------------------------------------------------------------------------*

*----------------------------------------------------
****** Forestry sector for prodcution purposes ******
*----------------------------------------------------

**** Cost calculations
*---------------------

$ontext
re-establishment costs in t0
recurring costs * rotation length (thinning, monitigotr) (1/i)
harvesting costs in t30
transports in t30

PV of establishment decision cost
PV * annuity factor * time step length
$offtext

*' Cost of new plantations establishment `v32_cost_establishment` is the investment
*' made in setting up new plantations but also accounts for the expected value of
*' future transport costs and harvesting costs as well as trade costs for timber.
*' This makes sure that the model sticks to reasonable plantation patterns over time.

*(establishment costs + PV of future harvesting costs) * annuity factor
q32_cost_establishment(i2)..
						v32_cost_establishment(i2)
						=e=
            (sum((cell(i2,j2),type32), v32_land(j2,type32,"ac0") * s32_reESTBcost)
            +sum(cell(i2,j2), v32_land(j2,"plant","ac0") * pc32_yield_forestry_future(j2) * s32_harvesting_cost)
              /((1+pm_interest(i2))**sum(ct,(p32_representative_rotation(ct,i2))))
              )
            * (pm_interest(i2)/(1+pm_interest(i2)));


*' Recurring costs are paid for plantations where the trees have to be regularly monitored
*' and maintained. These costs are only calculated becuase we see active human intervebtion
*' in commercial plantations. These costs are paid for trees used for timber production or
*' trees established for afforestation purposes.

q32_cost_recur(i2) .. v32_cost_recur(i2) =e=
                    sum((cell(i2,j2),type32,ac_sub), v32_land(j2,type32,ac_sub)) * f32_fac_req_ha(i2,"recur");


*' Harvesting costs are calculated based on area removed for timber production purposes.
*' These costs are also paid when land expansion happens at the cost of plantations,


**** New establishment decision
*------------------------------

*' New plantations are already established in the optimization step based on a certain
*' percentage ('pc32_plant_prod_share_future') of future demand (pc32_demand_forestry_future)
*' This is based on the expected future yield ('pc32_yield_forestry_future') at harvest (year in time step are accounted for).

*' Global maximum constraint.
q32_establishment_max_glo ..
              sum(j2, (v32_land(j2,"plant","ac0") + v32_land_missing(j2)) * pc32_yield_forestry_future(j2))
              =l=
              sum(i2, pc32_demand_forestry_future(i2,"wood"))
              ;

*' Global minimum constraint.
q32_establishment_min_glo ..
              sum(j2, (v32_land(j2,"plant","ac0") + v32_land_missing(j2)) * pc32_yield_forestry_future(j2))
              =g=
              sum(i2, pc32_demand_forestry_future(i2,"wood")* pc32_plant_prod_share_future(i2))
              ;
*' Regional minimum constraint for maintaining current forestry area patterns, accounting for f21_self_suff of wood.
q32_establishment_min_reg(i2) ..
              sum(cell(i2,j2), (v32_land(j2,"plant","ac0") + v32_land_missing(j2)) * pc32_yield_forestry_future(j2))
              =g=
              pc32_demand_forestry_future(i2,"wood") * pc32_plant_prod_share_future(i2) * sum(ct, f21_self_suff(ct,i2,"wood"))
              ;

**** Area harvested
*------------------

*' Harvested area is the difference between plantation area from precious time
*' step ('pc32_land') and optimized plantation area from current time step ('v32_land')

q32_forestry_reduction(j2,type32,ac_sub) ..
                          vm_forestry_reduction(j2,type32,ac_sub)
                          =e=
                          pc32_land(j2,type32,ac_sub) - v32_land(j2,type32,ac_sub);

*** EOF equations.gms ***