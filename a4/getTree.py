poppath = "continents_pop.csv"
masterpath = "simple.csv"
outpath = masterpath[:-4]+"_tree.csv"


# creating dictionary mapping country names to
# 0. continent
# 1. subregion
# 2. population
cps = dict()
with open(poppath, "r") as f:
	lines = [x.split('\r') for x in f]
	lines = [x.split(',') for x in lines[0]]
	for x in lines:
		x[0] = ' '.join(x[0].split(' ')[1:])
		cps[x[0]] = x[1:]

with open(masterpath, "r") as 

print(cps)