# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)
#withMetadata(TRUE) ## Doesn't work.

###############################################################################################################
## Following script is with H12 regions, All SSPs (ref and rcp2.6), on a livestock gridded configuration,    ##
## with forest protection policy in Japan and new tau implementation jun18. Includes correct GDP calculation ##
## and also includes other land protetction in Japan.														 ##
###############################################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

cfg$input <- c("magpie4.0_default_sep18.tgz","additional_data_rev3.65.tgz","isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev35_c200_690d3718e151be1b450b394c1064b1c5.tgz","air_pollution_test_20190218.tgz")
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/air_pollution_test"=NULL),
                           getOption("magpie_repos"))


cfg$results_folder <- "output/:title:"

start_run(cfg,codeCheck=FALSE)
