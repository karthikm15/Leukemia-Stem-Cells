setwd('/Users/adityamittal/Documents/FocusHackathon/')
outcomes = c( 'prot-a-1868', 'prot-a-235', 'prot-a-1130', 'prot-a-1736', 'prot-a-1737')
exposures = c('prot-a-569', 'prot-a-532', 'prot-c-4500_50_2', 'prot-c-2475_1_3', 'prot-c-2966_65_2', 'prot-a-1652')

df = NULL
for (exposure in exposures){
  for (outcome in outcomes){
    if (file.exists(paste0("RES_MOE/", exposure, "_", outcome, ".csv"))){
      print("HERE")
      res_moe_df = read.csv(file = paste0("RES_MOE/",exposure,"_", outcome, ".csv"))
      estimates = res_moe_df
      index = which.min(x = estimates$pval)
      print(index)
      loc_exposure = which(ao$id == as.character(estimates$id.exposure[index]))
      exposure_name = as.character(ao[loc_exposure,]$trait)
      loc_outcome = which(ao$id == as.character(estimates$id.outcome[index]))
      outcome_name = as.character(ao[loc_outcome,]$trait)
      val = cbind(estimates[index,], exposure_name)
      val = cbind(val, outcome_name)
      if (is.null(df)) {
        df = val
      } else {
        df = rbind(df, val)
      }
    }
  }
}

df = df[order(df$pval),]
write.csv(x = df, file = "Best_MR_Results.csv")

