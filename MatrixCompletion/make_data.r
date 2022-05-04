function(n = 100, r = 4, cpl = 10, snr = 2){
#n = number of items/subjects
#r = true matrix rank
#cpl = number of columns per latent component
#snr = signal to noise

truls <- matrix(runif(n * r), n, r) #True latent structure
d <- matrix(NA, n, r * cpl) #Matrix to hold simulated data

#Loop to create data matrix
for(i in c(1:r)) for (j in c(1:cpl)){
	#Each column is a noisy version of one latent component
	v <- truls[,i] + (runif(n) - .5)/snr #Noisy version of one component
	#Normalize to zero-one
	v <- v - min(v) + .01; v <- v/(max(v) + .01)
	v <- ceiling(v*6) #Convert to ordinal one-to-six scale
	d[,((i-1)*cpl) + j] <- v #Store in data matrix
	}
	d
}

