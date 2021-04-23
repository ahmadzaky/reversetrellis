function [dist_metric,path_metric]=viterbi(t,traceback,channel_out)

nxtState = t.nextStates;
weight   = t.outputs;
nStates  = t.numStates;
cycle	 = traceback;
data	 = channel_out;

dist_metric = zeros(nStates);
ndist_metric = zeros(nStates);
path_metric = zeros(nStates,traceback);
npath_metric = zeros(nStates,traceback);
	
for j=0:cycle-1	
	
	input = data((j*3)+1:(j*3)+3)
						% 0 until traceback (63)
		for b=0:1							% input 0 and 1
			for i=0:((nStates/2)-1)         % states 000000 - 111111
					next_state = nxtState((i*2)+1,b+1);
					distA = dist_metric((i*2)+1);
					distB = dist_metric((i*2)+2);
					ruteA = path_metric((i*2)+1);
					ruteB = path_metric((i*2)+2);
					ruteA(j+1) = b;
					ruteB(j+1) = b;
					wA = weight((i*2)+1,b+1);
					wB =  weight((i*2)+2,b+1);
				%	[dist,rute]=ACS(distA,distB,ruteA,ruteB,input,wA,wB)
					ndist_metric(next_state+1) = dist;
					npath_metric(next_state+1) = rute;
			end
		end
	dist_metric = ndist_metric;
	path_metric = npath_metric;
end
