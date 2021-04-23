%nxt_stat.m
%Modified:
% Date       		Who      What		
%May 4,2007  	    fai     add comments
%============================================================
%input:
%		current_state:state sequence (from 0 to 63)
%		input:input sequence('0' or '1')
%		L: constrain length conv. enc = 7.
%		k: input bit number rate (1) to convolutional encoder
%Output:
%		next_state:state at t+1
%		memory_contents: consists of "binary_input" and "binary_state".
%=============================================================
function [next_state,memory_contents]=nxt_stat(current_state,input,L,k)

binary_state=deci2bin(current_state,k*(L-1));
binary_input=deci2bin(input,k);    
next_state_binary=[binary_input,binary_state(1:(L-2)*k)];    
next_state=bin2deci(next_state_binary);    
memory_contents=[binary_input,binary_state];