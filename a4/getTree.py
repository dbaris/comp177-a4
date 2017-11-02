poppath = "continents_pop.csv"
masterpath = "simple.csv"
outpath = masterpath[:-4] + "_tree.csv"


# creating dictionary mapping country names to
# 0. continent
# 1. subregion
# 2. population
cps = dict()
with open(poppath, "r") as f:
	lines = [x.split('\r') for x in f]
	lines = [x.split('\t') for x in lines[0]]
	for x in lines:
		x[0] = ' '.join(x[0].split(' ')[1:])
		cps[x[0]] = x[1:]

with open(masterpath, "r") as f:
	lines = [x.split('\r') for x in f]
	lines = [x.split('\t') for x in lines[0][1:]]

names = set([x[0] for x in lines])

print([x for x in names if x not in cps.keys()])
bleb = list(cps.keys())
bleb.sort()
#print(bleb)

