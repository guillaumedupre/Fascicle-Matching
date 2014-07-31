Fascicle-Matching
=================

Matlab code to match brain fascicles using functional maps

## Usage

The library [CVX](http://cvxr.com/cvx/) is required, download and load the library and run cvx_startup.m.

Load the fascicle data using loadFascicle.m
Then run on of the examples :

### Match two fascicles

This script computes a functional map between two fascicles

### DeformAndMatchFascicle.m

This script applies several times a deformation to a given fascicle and compute functional maps between the modified fascicles and the original one. 
Three deformation functions are available in deformation/

