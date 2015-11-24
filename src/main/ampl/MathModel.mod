set G;			#Set of modules (timelines)
set I;			#Set of tasks
set I_g{G};		#Set of tasks on module g
#set J_ig{I cross G};	#Set of tasks that can be placed after task i on module g
set D;			#Set of index for dependencies
#set I_d{D};		#Set of dependencies e.g. {{1,4},{3,5},...}

param l{I};	#length of task i
param g{I};	#which timeline task i belongs to
param t_s{I};	#earliest start time for task i
param t_e{I};	#latest end time for task i
param f_min{D};	#shortest distance between dependency D
param f_max{D};	#longest distance between dependency D
param I_df{D};	#from which task, dependency D
param I_dt{D};	#to which task, dependency D

var u{d in D} ;	#distance between index i and j in dependency D
var x_s {i in I} >= 0, integer; 	#?!?!?!??
var x_e {i in I} >= 0, integer;
var y {k in G, i in I,j in I} binary;
var y_s {k in G, i in I_g[k]} binary;
var y_e {k in G, i in I_g[k]} binary;

# Objective function

minimize total_cost:
	 0;


### Constraints ###

subject to first_task{k in G}:
	sum{i in I_g[k]} y_s[k,i] = 1;

subject to last_task{k in G}:
	sum{i in I_g[k]} y_e[k,i] = 1;

subject to check_if_endtask{k in G, i in I_g[k]}:
	sum{j in I_g[k]} y[k,i,j] + y_e[k,i] = 1;

subject to check_if_starttask{k in G, j in I_g[k]}:
	sum{i in I_g[k]} y[k,i,j] + y_s[k,j] = 1;

subject to start_constraint{k in G, i in I_g[k], j in I_g[k]}:
	x_s[j] - x_e[i] >=  -(t_e[i]-t_s[j])*(1-y[k,i,j]);

subject to task_length{i in I}:
	x_e[i] = x_s[i] + l[i];

subject to task_distance{d in D}:
	x_s[I_dt[d]] = x_e[I_df[d]] + u[d];

# subject to task_distance{d in D, (i,j) in I_d}: #Check this one! (i,j)
#	x_s[j] = x_e[i] + u[d];

subject to interval_constraint1{i in I}:
	t_s[i] + l[i] <= x_e[i];

subject to interval_constraint2{i in I}:
	x_e[i] <= t_e[i];

subject to dependency_constraint1{d in D}:
	u[d] <= f_max[d] ;

subject to dependency_constraint2{d in D}:
	u[d] >= f_min[d];



