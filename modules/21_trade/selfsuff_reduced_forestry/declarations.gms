*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 i21_trade_bal_reduction(t_all,k_trade)          Trade balance reduction (1)
 i21_trade_margin(i,k_trade)                     Trade margins (USD05MER per tDM)
 i21_trade_tariff(i,k_trade)                     Trade tariffs (USD05MER per tDM)
 i21_trade_bal_reduction_ff(t_ext,kforestry)        Trade balance reduction for timber (1)
 i21_trade_margin_ff(i,kforestry)                   Trade margins for timber (USD05MER per tDM)
 i21_trade_tariff_ff(i,kforestry)                   Trade tariffs for timber (USD05MER per tDM)
 p21_demand_ext(t_ext,i,kforestry)              Extended demand for timber beyound simulation (mio. m3)
 p21_selfsuff_ext(t_ext,i,kforestry)            Self sufficiency for timber products in extended time frame (1)
 p21_trade_balanceflow_ext(t_ext,kforestry)     Extended trade balance flow numbers (1)
 p21_exp_shr_ext(t_ext,i,kforestry)             Extended export share (1)
 i21_demand_forestry_future(i,kforestry)       Future timber demand (mio. m3)
 i21_selfsuff_forestry_future(i,kforestry)     Future self sufficiency ratio for timber products (1)
 i21_trade_bal_reduction_future(kforestry)     Future trade balance reduction (1)
 i21_trade_balanceflow_future(kforestry)       Future trade balanceflow (1)
 i21_exp_shr_future(i,kforestry)               Future export share (1)
 i21_excess_prod_ff(i,kforestry)               Excess future production of timber (mio. m3)
 i21_excess_dem_ff(kforestry)                  Global excess timber demand (mio. tDM per yr)
 p21_prod_future_reg_ff_lower(t,i,kforestry)    Lower bound (1)
 p21_prod_future_reg_ff_upper(t,i,kforestry)    Upper bound for testing (1)
 p21_prod_future_reg_ff_level(i,kforestry)    Level for testing (1)
;

positive variables
 v21_excess_dem(k_trade)                 Global excess demand (mio. tDM per yr)
 v21_excess_prod(i,k_trade)              Regional excess production (mio. tDM per yr)
 vm_cost_trade(i)                        Regional  trade costs (mio. USD05MER per yr)
 v21_cost_trade_reg(i,k_trade)           Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 vm_prod_future_reg_ff(i,kforestry)     Future production of timber based (mio. m3)
 vm_cost_trade_forestry_ff(i)           Future total timber trade costs (mio. USD)
;

equations
 q21_trade_glo(k_trade)                  Global production constraint (mio. tDM per yr)
 q21_notrade(i,k_notrade)                Regional production constraint of non-tradable commodities (mio. tDM per yr)
 q21_trade_reg(i,k_trade)                Regional trade balances i.e. minimum self-sufficiency ratio (1)
 q21_trade_reg_up(i,k_trade)             Regional trade balances i.e. maximum self-sufficiency ratio (1)
 q21_excess_dem(k_trade)                 Global excess demand (mio. tDM per yr)
 q21_excess_supply(i,k_trade)            Regional excess production (mio. tDM per yr)
 q21_cost_trade(i)                       Regional  trade costs (mio. USD05MER per yr)
 q21_cost_trade_reg(i,k_trade)           Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 q21_cost_trade_ff(i)                   Future forestry total trade costs (mio. USD)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov21_excess_dem(t,k_trade,type)           Global excess demand (mio. tDM per yr)
 ov21_excess_prod(t,i,k_trade,type)        Regional excess production (mio. tDM per yr)
 ov_cost_trade(t,i,type)                   Regional  trade costs (mio. USD05MER per yr)
 ov21_cost_trade_reg(t,i,k_trade,type)     Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 ov_prod_future_reg_ff(t,i,kforestry,type) Future production of timber based (mio. m3)
 ov_cost_trade_forestry_ff(t,i,type)       Future total timber trade costs (mio. USD)
 oq21_trade_glo(t,k_trade,type)            Global production constraint (mio. tDM per yr)
 oq21_notrade(t,i,k_notrade,type)          Regional production constraint of non-tradable commodities (mio. tDM per yr)
 oq21_trade_reg(t,i,k_trade,type)          Regional trade balances i.e. minimum self-sufficiency ratio (1)
 oq21_trade_reg_up(t,i,k_trade,type)       Regional trade balances i.e. maximum self-sufficiency ratio (1)
 oq21_excess_dem(t,k_trade,type)           Global excess demand (mio. tDM per yr)
 oq21_excess_supply(t,i,k_trade,type)      Regional excess production (mio. tDM per yr)
 oq21_cost_trade(t,i,type)                 Regional  trade costs (mio. USD05MER per yr)
 oq21_cost_trade_reg(t,i,k_trade,type)     Regional trade costs for each tradable commodity (mio. USD05MER per yr)
 oq21_cost_trade_ff(t,i,type)              Future forestry total trade costs (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################