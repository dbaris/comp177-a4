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
	lines = [x[0].split(',') for x in lines[1:]]

for x in lines:
	country_name = x[0]


with open(outpath, "w") as f:
	f.write(str(len(lines)) + '\n')
	for x in lines:
		f.write(x[0] + ' ' + cps[x[0]][2] + '\n')
	f.write(str(len(lines) * 2) + '\n')


