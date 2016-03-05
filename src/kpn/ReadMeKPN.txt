This set of three matlab files pertain to the K-previous neighbors filtering algorithm. 
knn.m and opp.m developed by Teal Hobson-Lowther, mongain.m co-developed by Teal Hobson-Lowther and Michael Mason. 

knn.m
-This function takes an input row vector (data) of FOREX data, and outputs a "property" row vector that 
contains the property values for the k previous neighbors.
-Specific input arguments the data matrix, k value, and tolerance specifications 
for a k-previous neighbors smoothing algorithm. 
-The output is a vector of property-values, a total l2norm error, and an error message. 

opp.m
-This function outputs a binary opportunity matrix, which classifies whether a datapoint has opportunity
based on the sign of the difference between the KNN (output of knn()) and the data itself.
-The input arguments, data and knn, are the original data matrix to be analyzed, and knn, the output of knn.m,
respectively. 

mongain.m
-Utilizes the opportunity vector produced by opp.m, in order to make trades and calculate monetary 
gain, based on a starting monetary value of $100 USD. 
-Input arguments are the original data matrix, and op, the matrix output of opp.m
-The output value is the number of USD one has at the end of the data period. 