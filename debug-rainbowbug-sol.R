## a)
# Trigger of the error: as.graphicsAnnot(legend)
# Cause of the error: x used for the creation of x_fds has no column names
# there is actually a warning - but fboxplot assumes that x_fds was specified 
# correctly 
# If valid values are assigned to colnames(x), the error is not happening anymore

## b)
# I suggest to do further input checks at the beginning of
# fboxplot to see if data has the correct structure 
# Example: currently even this can be executed without a specific error:
rainbow::fboxplot("notadataset")
