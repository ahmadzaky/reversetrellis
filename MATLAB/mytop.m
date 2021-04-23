close all;
clear all;
ev = 0;
e = 0;
packet = 0;
total_packet = 1;
in_place = 1; %pilih 1 untuk penggunaan metoda inplace K=9

hard = 0;
soft = 1;

decision = hard;
puncturing = 0;
read_from_file = 0; %ubah ke 1 untuk mendapatkan input dari file
nama_file = 'input.txt'; %masukkan nama file input

q = 5; %  banyak bit kuantisasi
traceback = 40;
data_long = 40; %panjang data haruslah:256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288

K = 7; % constraint length
k = 1; % laju input enkoder: 1 untuk laju 1/2
snr = 3; % signal to noise ratio dari bit yang dikirimkan
generator = [133 171 165]; % generator polynomial
G = [1 0 1 1 0 1 1;1 1 1 1 0 0 1;1 1 1 0 1 0 1];
t = poly2trellis(K,generator); % bentuk trellis

itter = 0;
while itter < 1
itter = itter+1;
    block = data_long/traceback;
	
	
    if read_from_file == 1
        data = file_read(nama_file);
    else
        random_data = rand(1,data_long);
        data = round(random_data);
    end
	for i=1:traceback
	   alldata(itter,i) = data(i);
	end
		for i=0:5
			init_state(1,i+1) = data(1,traceback-i);
		end
   tail = bin2deci(init_state);
  %data(1:6) = data(traceback-5:traceback);
    
	
    [encoded,fin_state] = convenc(data,t,tail); %encoding konvolusi
	
	if(mod(data_long,40)~=0)
        error('input harus kelipatan 256!');
    end
%	encoded2 = encoder_convo(data);
	
   if puncturing == 1
		punctured = puncture(encoded,k);
		flag_pun = flag(punctured,k);
		modulated = bpsk_mod(punctured);
	else
		modulated = QPSK(encoded);
	end
		

   %noisy_input = awgn(modulated,snr,0);
	noisy_input = modulated;
	

	l =  length(noisy_input);
for i = 0 : (l/2)-1
    if noisy_input((i*2)+1) <= -0.707 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = 3;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = 3;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = 3;
		elseif noisy_input((i*2)+2) <= 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = 3;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = 3;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = 3;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = 3;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = 3;
		end
	elseif noisy_input((i*2)+1) <= -0.471 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = 2;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = 2;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = 2;
		elseif noisy_input((i*2)+2) < 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = 2;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = 2;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = 2;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = 2;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = 2;
		end
	elseif noisy_input((i*2)+1) <= -0.236 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = 1;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = 1;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = 1;
		elseif noisy_input((i*2)+2) <= 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = 1;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = 1;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = 1;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = 1;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = 1;
		end
	elseif noisy_input((i*2)+1) <= 0 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = 0;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = 0;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = 0;
		elseif noisy_input((i*2)+2) <= 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = 0;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = 0;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = 0;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = 0;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = 0;
		end
	elseif noisy_input((i*2)+1) >= 0.707 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = -4;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = -4;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = -4;
		elseif noisy_input((i*2)+2) <= 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = -4;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = -4;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = -4;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = -4;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = -4;
		end
	elseif noisy_input((i*2)+1) >= 0.471 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = -3;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = -3;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = -3;
		elseif noisy_input((i*2)+2) <= 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = -3;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = -3;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = -3;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = -3;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = -3;
		end
	elseif noisy_input((i*2)+1) >= 0.236 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = -2;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = -2;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = -2;
		elseif noisy_input((i*2)+2) <= 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = -2;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = -2;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = -2;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = -2;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = -2;
		end
	elseif noisy_input((i*2)+1) >= 0 
		if noisy_input((i*2)+2) <= -0.707
			channel_output((i*2)+1) = 3;
			channel_output((i*2)+2) = -1;
		elseif noisy_input((i*2)+2) <= -0.471
			channel_output((i*2)+1) = 2;
			channel_output((i*2)+2) = -1;
		elseif noisy_input((i*2)+2) <= -0.236
			channel_output((i*2)+1) = 1;
			channel_output((i*2)+2) = -1;
		elseif noisy_input((i*2)+2) <= 0
			channel_output((i*2)+1) = 0;
			channel_output((i*2)+2) = -1;
		elseif noisy_input((i*2)+2) >= 0.707
			channel_output((i*2)+1) = -4;
			channel_output((i*2)+2) = -1;
		elseif noisy_input((i*2)+2) >= 0.471
			channel_output((i*2)+1) = -3;
			channel_output((i*2)+2) = -1;
		elseif noisy_input((i*2)+2) >= 0.236
			channel_output((i*2)+1) = -2;
			channel_output((i*2)+2) = -1;
		elseif noisy_input((i*2)+2) >= 0
			channel_output((i*2)+1) = -1;
			channel_output((i*2)+2) = -1;
		end
    end
end
	
	
	%channel_output = file_read('test_data.txt');
	
	
	L=size(G,2)/k;
	number_of_states=2^((L-1)*k);

    if(mod(data_long,traceback)~=0)
        error('input harus kelipatan 64!');
    end

    % %memecah data agar lacak balik dilakukan setiap n traceback data
    fin_state_metric = zeros(number_of_states,3);

	ns = t.nextStates;
        for x=0:number_of_states-1
            start_seq(x+1,1)=x;
        end
    % end
	


	
    % %Dekoder Viterbi
     for k = 1 : 1
	 	
		nxtState = t.nextStates;
		weight   = t.outputs;
		nStates  = t.numStates;
		% data	 = channel_out;
			
		nstart_seq = start_seq; 
		cycle	 = traceback-6;
		dist_metric = zeros(nStates,1);
		ndist_metric = zeros(nStates,1);
		path_metric = zeros(nStates,traceback+1);
		npath_metric = zeros(nStates,traceback+1);

for i=1:nStates
	path_metric(i,traceback+1) = start_seq(i);
end
ruteA	= zeros(1,traceback);
ruteB	= zeros(1,traceback);
	 
         block_data = channel_output(1,((k-1)*(traceback*3))+1:k*(traceback*3));
		 viterbi_data = block_data(19:traceback*3);
		 for x=0:5
		 head_data((3*x)+1)	  = block_data(18-(3*x)-2);
		 head_data((3*x)+2)	  = block_data(18-(3*x)-1);
		 head_data((3*x)+3)	  = block_data(18-(3*x));
		 end
		  % head_data	  = block_data(1:18);
		
		 for j = 0 : 1%cycle-1	
	
			input = viterbi_data((j*3)+1:(j*3)+3)
			distA = 0;
			distA = 0;
						% 0 until traceback (63)
			for b = 0:1							% input 0 and 1
				for i=0:(nStates/2)-1         % states 000000 - 111111
						next_state = nxtState((i*2)+1,b+1);
						distA = dist_metric((i*2)+1);
						distB = dist_metric((i*2)+2);
						ruteA = path_metric(((i*2)+1),:);
						ruteB = path_metric(((i*2)+2),:);
						ruteA(j+1) = b;
						ruteB(j+1) = b;
						wA = weight((i*2)+1,b+1);
						wB =  weight((i*2)+2,b+1);
						sweightA = deci2soft(wA);
						sweightB = deci2soft(wB);
							diffA1 = (input(1)-sweightA(1)) * (input(1)-sweightA(1));
							diffA2 = (input(2)-sweightA(2)) * (input(2)-sweightA(2));
							diffA3 = (input(3)-sweightA(3)) * (input(3)-sweightA(3));
							diffB1 = (input(1)-sweightB(1)) * (input(1)-sweightB(1));
							diffB2 = (input(2)-sweightB(2)) * (input(2)-sweightB(2));
							diffB3 = (input(3)-sweightB(3)) * (input(3)-sweightB(3));
							
								 eucA = sqrt(diffA1+diffA2+diffA3)
								 eucB = sqrt(diffB1+diffB2+diffB3)
								
									distA = distA+eucA;
									distB = distB+eucB;
							if distA < distB
								dist = distA;
								rute = ruteA;
							else
								dist = distB;
								rute = ruteB;
							end;
						ndist_metric(next_state+1) = dist;
						npath_metric((next_state+1),:) = rute;
				end
			end
			dist_metric = ndist_metric;
			path_metric = npath_metric;
		end	 
		
		%reverse trellis
		
		for i=1:nStates
			start_rev_state(i,1) = path_metric(i,traceback+1);
		end
		
		for i=1:nStates         % states 000000 - 111111
			temp(1:6)  = deci2bin(i-1,6);
			temp(7:12) = deci2bin(path_metric(i,41),6);
			for x=0:5
			revRute(x+1) = temp(6-x);
			revRute(x+7) = temp(12-x);
			end 
			%distn  = 0;
			distn = dist_metric(i,1);
			for j = 0 : 5	
				rv_rute = revRute(6-j:11-j);
				for g = 1:6
				r_rute(g)	= rv_rute(7-g);
				end
			present_state = bin2deci(r_rute);
			present_input = revRute(12-j);
			cost_n = weight((present_state+1),(present_input+1));
			cost   = deci2bin(cost_n,3);
			distance = head_data((3*j)+1:(3*j)+3);
			dist_st(i,:) = distance;
			cost_st(i,:) = cost_n;
			ps_st(i)   = present_state;
			rev_st(i,:) = revRute;
				for x=1:3
					if cost(x)~=distance(x)
						distn = distn+1;
					end
				end
			end
			dist_metricA(i,1) = distn;
			for n = 1 : traceback-6
			npath_metric(i,n+6) = path_metric(i,n)
			end
			for n = 1 : 6
			npath_metric(i,n) = temp(13-n);
			end
		end	 
		path_metric = npath_metric;
	
		 path_min = 99999999;
		 
		for i = 1:nStates
			if dist_metricA(i) < path_min
				min_index = i;
				path_min = dist_metricA(i);
			end;
		end;
		 
     end
		 min_rute = path_metric(min_index,1:traceback);
		 for i=1:traceback
		 allminrute(itter,i) = min_rute(i);
		 end
    final_output = reshape(min_rute',1,traceback);

	er = 0;
    for m = 1 : traceback    % mengecek berapa bit yang error
        if (data(m) ~= final_output(m)),
            e = e + 1;
			er = er + 1;
        end
    end
			err(1,itter) = er;
			
	%-----------------------------------------------------------------------------------------------------------------%		
	 for k = 1 : 1
	 	
		nxtState = t.nextStates;
		weight   = t.outputs;
		nStates  = t.numStates;
		% data	 = channel_out;
			
		nstart_seq = start_seq; 
		cycle	 = traceback;
		dist_metric_v = zeros(nStates,1);
		ndist_metric_v = zeros(nStates,1);
		path_metric_v = zeros(nStates,traceback);
		npath_metric_v = zeros(nStates,traceback);

		
ruteA	= zeros(1,traceback);
ruteB	= zeros(1,traceback);
	 
         block_data = channel_output(1,((k-1)*(traceback*3))+1:k*(traceback*3));
		 for j = 0 : cycle-1	
		 
			input = block_data((j*3)+1:(j*3)+3)
			distA = 0;
			distA = 0;
						% 0 until traceback (63)
			for b = 0:1							% input 0 and 1
				for i=0:(nStates/2)-1         % states 000000 - 111111
						next_state = nxtState((i*2)+1,b+1);
						distA = dist_metric_v((i*2)+1);
						distB = dist_metric_v((i*2)+2);
						ruteA = path_metric_v(((i*2)+1),:);
						ruteB = path_metric_v(((i*2)+2),:);
						ruteA(j+1) = b;
						ruteB(j+1) = b;
						wA = weight((i*2)+1,b+1);
						wB =  weight((i*2)+2,b+1);
							weightA = deci2bin(wA,3);
							weightB = deci2bin(wB,3);
							for i=1:3
								if input(i)~=weightA(i)
									distA = distA+1;
								end
								if input(i)~=weightB(i)
									distB = distB+1;
								end
							end
							if distA < distB
								dist = distA;
								rute = ruteA;
							else
								dist = distB;
								rute = ruteB;
							end;
						ndist_metric_v(next_state+1) = dist;
						npath_metric_v((next_state+1),:) = rute;
				end
			end
			dist_metric_v = ndist_metric_v;
			path_metric_v = npath_metric_v;
		end	 
	
		 path_min_v = 99999999;
		 
		for i = 1:nStates
			if dist_metric_v(i) < path_min_v
				min_index_v = i;
				path_min_v = dist_metric_v(i);
			end;
		end;
		 
     end
		 min_rute_v = path_metric_v(min_index_v,1:traceback);
		 for i=1:traceback
		 allminrute_v(itter,i) = min_rute_v(i);
		 end
    final_output_v = reshape(min_rute_v',1,traceback);

	erv = 0;
    for m = 1 : traceback    % mengecek berapa bit yang error
        if (data(m) ~= final_output_v(m)),
            ev = ev + 1;
			erv = erv + 1;
        end
    end
			errv(1,itter) = erv;		
			
			
			
end


% % hitung BER
 p = e/(itter*traceback);
 pv = ev/(itter*traceback);
 
 test(1,1) = 0.42969;     
 test(1,2) = 0.32500;
 test(1,3) = 0.21250;
 test(1,4) = 0.11406;
 test(1,5) = 0.03438;
 test(1,6) = 0.00937;
 test(1,7) = 0.00781;
% input561_dec = channel_output(1:2:length(channel_output));
% input753_dec = channel_output(2:2:length(channel_output));
% input561_bin = my_dec2bin(input561_dec);
% input753_bin = my_dec2bin(input753_dec);

% fid = fopen('modulated.txt','w');
% fprintf(fid,'%.0f\n',modulated);
% fclose(fid);

% fid = fopen('demod.txt','w');
% fprintf(fid,'%.0f\n',channel_output);
% fclose(fid);

% fid = fopen('inputencoder.txt','w');
% fprintf(fid,'%.0f\n',data);
% fclose(fid);

% fid = fopen('encoderout.txt','w');
% fprintf(fid,'%.0f\n',encoded);
% fclose(fid);

% fid = fopen('inputdecoder.txt','w');
% fprintf(fid,'%.0f\n',noisy_input);
% fclose(fid);

% fid = fopen('outdecoder.txt','w');
% fprintf(fid,'%.0f\n',min_rute);
% fclose(fid);

% fid = fopen('input561.txt','w');
% fprintf(fid,'"%c%c%c%c%c",\n',input561_bin');
% fclose(fid);
% fid2 = fopen('input753.txt','w');
% fprintf(fid2,'"%c%c%c%c%c",\n',input753_bin');
% fclose(fid2);

% in_and_out = [data;final_output];
% fid3 = fopen('output.txt','w');
% fprintf(fid3,'''%.0f'',\n',final_output');
% fclose(fid3);

% fid4 = fopen('rangkuman.txt','w');
% fprintf(fid4,'Panjang Constraint : %.0f\n',K);
% fprintf(fid4,'Laju kode : %.0f\n',k);
% fprintf(fid4,'Generator : %.0f %.0f dan %.0f\n',generator(1), generator(2), generator(3));
% fprintf(fid4,'SNR : %.0f\n',snr);
% fprintf(fid4,'Total bit data : %.0f\n',traceback*itter);
% fprintf(fid4,'Total bit rusak: %.0f\n',e);
% fprintf(fid4,'BER : %.5f\n',p);
% fclose(fid4);