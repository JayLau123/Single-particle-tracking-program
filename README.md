# Single-particle-tracking-program
It's an entry-level program to learn the particle tracking in acceralor physics with SAD software. Our goal is to find the relation of 6D coordinates of particle before and after tracking with neural network or other mathematical physics tools.
Set the initial 6D coordinates and get the new 6D coordinates after tracking. The files contains the parameters. Different variables(1500 samples) would produce new lattice file, and tracking the dynamic aperture of the new lattice outputs the objective function value.

The definition of variables: pattern.sad 

The list of new variables: x.97858.181.2p.list 

Original lattice file: CEPC_RING_v20171218_by_1.5mm_sext_32fam.sad 

The program: x.97858.181.2p.sad  (Substitute the new variable into the original lattice to generate a new lattice file)

New lattice file: cepc.lat.diff.97858.181.2p.sad

‘obj0.sad’ and ‘obj1.sad’ are two programs to calculate cost value (Dynamic aperture tracking)

The others are relevant files.

There are 10 subfiles in data.rar, and each one contains 1500 observations. In each observation, there are 52 variables(50 independent variables in lastparent.x.txt file, and 2 dependent variables in last parent.objcost.txt file). We need to build a neural network to find the relation between independent variables and dependent variables. Please find more details in SAD software for the physical meaning of these variables.

For some mathematic functions used in SAD, please see the link below: 
https://hep-project-sad.web.cern.ch/SADHelp/SADHelp.html#L2

P.S. The program is a single-particle tracking program, which gets the coordinates of a single particle, but it is easy to change it to multi-particle tracking.

Useful public learning resources for machine learning applications in high energy physics: https://github.com/iml-wg/HEP-ML-Resources

### Other packages for ML in MATLAB


Regression: train regression model to make predictions using supervised ML 

Classification: train models to classify data using supervised ML

Clustering: solve clustering problem using self-organizing masp(SOM)

Fitting: solve the problem using two-layer feed-forward networks

Pattern recognition: solve the problem using two-layer feed-forward networks

Time series: solve nonlinear time series problem using dynamic neural networks






