# Mutual Recommendations

This repository contains code and data for a homework project called **Mutual Recommendations**. The goal is to compute “matching” or “liking” scores between different individuals (in this example, men and women), based on their similarity or dissimilarity in likes and dislikes.

## Project Structure

- **data/**: Contains your data file `HW4.Rdata`.
- **scripts/**: Contains the main R script `mutual_recommendations.R`.  
- **README.md**: Project description, instructions, references, etc.
- **requirements.txt**: Basic R requirements (or you can list out required R packages if using any).

## How to Run

1. **Clone the repository**  
   ```bash
   git clone https://github.com/hjenoudet/mutual-recommendations.git
   cd mutual-recommendations
   ```

2. **Open R (or RStudio) and set your working directory to the repository root, for example:**
   ```{r}
   setwd("path/to/Mutual-Recommendations")
   ```
3. **Load the script**
   ```{r}
   source("scripts/mutual_recommendations.R")
   ```
## Project Details 
- **Data**: The HW4.Rdata file is loaded in the script, which contains the men’s and women’s preference matrices (Liked_M_F and Liked_F_M).
- **Core Function**: calculate_liking_scores(), which calculates weighted liking scores by matching the sign of correlation to likes/dislikes.
- **Correlation Threshold**: By default, correlations between -0.15 and 0.15 are set to zero to remove weak associations.
- **Results**: The script sums the liking scores from each side to yield a mutual recommendation score, e.g., (Anna + Fiyero), (Elphaba + Kristoff), etc.

## Contributing
If you’d like to contribute or report any issues, please open a Pull Request or file an Issue on this repository.

## Acknowledgments
I would like to thank Professor Mike Palazzolo (Assistant Professor of Marketing, UC Davis Graduate School of Management, Research Affiliate, Center for Poverty & Inequality Research) for their guidance and for allowing me to share this project. Their insights and support were invaluable in completing this analysis.
