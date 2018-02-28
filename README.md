# biased-means

Comparing Pure-Mean Ranking to SE-Biased Means

## Setup

We arbitrarily generate true mean scores and true mean SDs for 10 individuals. We calculate from this the true pooled mean and true pooled SD.

We generate a rank-order of each individual, by their true mean scores.

Then we sample: for each individual, we take between 5 and 50 random samples. From these, we calculate individual sample means and sample SDs. We then pool the sampled data to get the sample pooled mean and SD.

The first test is to simply rank them by their sample means.

The second test is to bias the means: based on the ratio (sample sigma / pooled sigma) (where sigma = SD / sqrt n) - we average the pooled mean and their sample mean. A higher ratio means we go more towards the sample mean. Then we rank them by their biased means.

To test these ranks, we do two things. For each either mean or biased mean, we compute how significantly they deviate from the true individual means (hopefully we see our biased mean is more accurate). We also compare the rank-orders to the real rank order, and calculate how many individuals were misplaced from their correct spot (again, hopefully our biased mean will yield fewer misplacements).

## Other

Side note: compare overlapping distributions of two samples, calc area (for each individual) of distribution that is not overlapped and that is either above or below the other sample's mean?
