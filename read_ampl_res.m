b = [1 7 6 2 8 4 9 7 6 5 4 1 9 2 4];


for LNS_res_it = 1:(length(b)/3)
    
       result_matrix_LNS(LNS_res_it,1) = LNS_res_it;
       result_matrix_LNS(LNS_res_it,2) = b(1+3*(LNS_res_it-1));
       result_matrix_LNS(LNS_res_it,3) = b(3+3*(LNS_res_it-1));
end


result_matrix_LNS
