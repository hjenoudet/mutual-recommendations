# -------------------------------------------------------
# mutual_recommendations.R
# 
# Author: Henri Jenoudet
# Description:
#   This script loads the mutual_recommendations.Rdata file, calculates correlation
#   scores, and then computes matching (liking) scores for
#   "Mutual Recommendations" between men and women.
# -------------------------------------------------------

# --- 1. Load data ---
load("../data/mutual_recommendations.Rdata")   # Adjust path if needed.

# Transpose and create correlation scores for men
Liked_M_F_new <- t(Liked_M_F)
MenCorrelationScores <- as.data.frame(
  cor(Liked_M_F_new, use = "pairwise.complete.obs")
)

# Transpose and create correlation scores for women
Liked_F_M_new <- t(Liked_F_M)
WomenCorrelationScores <- as.data.frame(
  cor(Liked_F_M_new, use = "pairwise.complete.obs")
)

# Rename columns for clarity
colnames(MenCorrelationScores) <- as.character(1:100)
colnames(WomenCorrelationScores) <- as.character(1:100)

# Convert to data frames
Liked_M_F <- as.data.frame(Liked_M_F)
Liked_F_M <- as.data.frame(Liked_F_M)
Liked_M_F_new <- as.data.frame(Liked_M_F_new)
Liked_F_M_new <- as.data.frame(Liked_F_M_new)

# --- 2. Adjust correlation thresholds (example: zero out values between -0.15 and 0.15) ---
MenCorrelationScores[MenCorrelationScores >= -0.15 & MenCorrelationScores <= 0.15] <- 0
WomenCorrelationScores[WomenCorrelationScores >= -0.15 & WomenCorrelationScores <= 0.15] <- 0

# --- 3. Define function to calculate liking scores ---
calculate_liking_scores <- function(correlation_vector, Liked_data, target_column) {
  valid_indices <- which(correlation_vector != 0)
  filtered_corr <- correlation_vector[valid_indices]
  filtered_likes <- Liked_data[[target_column]][valid_indices]
  
  L_values <- ifelse(filtered_corr > 0 & filtered_likes == 1, 1,
                     ifelse(filtered_corr < 0 & filtered_likes == 0, 1, 0))
  
  weighted_sum <- sum(abs(filtered_corr) * L_values, na.rm = TRUE)
  normalization_factor <- sum(abs(filtered_corr), na.rm = TRUE)
  
  if (normalization_factor > 0) {
    score <- weighted_sum / normalization_factor
  } else {
    score <- NA
  }
  
  return(score)
}

# --- 4. Example calculations for men: Fiyero(1), Kristoff(2), Bruno(3) ---
fiyero_corr <- MenCorrelationScores$`1`
fiyero_with_anna <- calculate_liking_scores(fiyero_corr, Liked_M_F, "X1")
fiyero_with_elphaba <- calculate_liking_scores(fiyero_corr, Liked_M_F, "X2")
fiyero_with_rosie <- calculate_liking_scores(fiyero_corr, Liked_M_F, "X3")

kristoff_corr <- MenCorrelationScores$`2`
kristoff_with_anna <- calculate_liking_scores(kristoff_corr, Liked_M_F, "X1")
kristoff_with_elphaba <- calculate_liking_scores(kristoff_corr, Liked_M_F, "X2")
kristoff_with_rosie <- calculate_liking_scores(kristoff_corr, Liked_M_F, "X3")

bruno_corr <- MenCorrelationScores$`3`
bruno_with_anna <- calculate_liking_scores(bruno_corr, Liked_M_F, "X1")
bruno_with_elphaba <- calculate_liking_scores(bruno_corr, Liked_M_F, "X2")
bruno_with_rosie <- calculate_liking_scores(bruno_corr, Liked_M_F, "X3")

# --- 5. Example calculations for women: Anna(1), Elphaba(2), Rosie(3) ---
rownames(WomenCorrelationScores) <- 1:nrow(WomenCorrelationScores)
rownames(Liked_F_M) <- 1:nrow(Liked_F_M)
colnames(Liked_F_M) <- paste0("X", 1:ncol(Liked_F_M))

anna_corr <- WomenCorrelationScores$`1`
anna_with_fiyero <- calculate_liking_scores(anna_corr, Liked_F_M, "X1")
anna_with_kristoff <- calculate_liking_scores(anna_corr, Liked_F_M, "X2")
anna_with_bruno <- calculate_liking_scores(anna_corr, Liked_F_M, "X3")

elphaba_corr <- WomenCorrelationScores$`2`
elphaba_with_fiyero <- calculate_liking_scores(elphaba_corr, Liked_F_M, "X1")
elphaba_with_kristoff <- calculate_liking_scores(elphaba_corr, Liked_F_M, "X2")
elphaba_with_bruno <- calculate_liking_scores(elphaba_corr, Liked_F_M, "X3")

rosie_corr <- WomenCorrelationScores$`3`
rosie_with_fiyero <- calculate_liking_scores(rosie_corr, Liked_F_M, "X1")
rosie_with_kristoff <- calculate_liking_scores(rosie_corr, Liked_F_M, "X2")
rosie_with_bruno <- calculate_liking_scores(rosie_corr, Liked_F_M, "X3")

# --- 6. Example final matching scores ---
cat("Anna and Fiyero =", anna_with_fiyero + fiyero_with_anna, "\n")
cat("Anna and Kristoff =", anna_with_kristoff + kristoff_with_anna, "\n")
cat("Anna and Bruno =", anna_with_bruno + bruno_with_anna, "\n")

cat("Elphaba and Fiyero =", elphaba_with_fiyero + fiyero_with_elphaba, "\n")
cat("Elphaba and Kristoff =", elphaba_with_kristoff + kristoff_with_elphaba, "\n")
cat("Elphaba and Bruno =", elphaba_with_bruno + bruno_with_elphaba, "\n")

cat("Rosie and Fiyero =", rosie_with_fiyero + fiyero_with_rosie, "\n")
cat("Rosie and Kristoff =", rosie_with_kristoff + kristoff_with_rosie, "\n")
cat("Rosie and Bruno =", rosie_with_bruno + bruno_with_rosie, "\n")

# -------------------------------------------------------
# End of mutual_recommendations.R
# -------------------------------------------------------
