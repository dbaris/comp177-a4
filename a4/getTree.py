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

continent_sub = dict()
for x in lines:
	country_name = x[0]
	continent = cps[x[0]][0]
	subregion = cps[x[0]][1]
	if continent not in continent_sub.keys():
		continent_sub[continent] = set()
	continent_sub[continent].add(subregion)	

with open(outpath, "w") as f:
	f.write(str(len(lines)) + '\n')
	for x in lines:
		f.write(x[0] + ',' + cps[x[0]][2] + '\n')

	subregion_num = 0
	for x in continent_sub.values():
		subregion_num += len(x)

	total_relations = len(lines) + subregion_num + len(continent_sub.keys())
					  # number of subregion-country relations
					   # number of continent-subregion relations
					   # number of world-continent relations
	f.write(str(total_relations) + '\n')
	for c in continent_sub.keys():
		f.write("world," + c + '\n')
		for s in continent_sub[c]:
			f.write(c + ',' + s + '\n')

	for x in lines:
		f.write(cps[x[0]][1]+ ',' + x[0] + '\n')


