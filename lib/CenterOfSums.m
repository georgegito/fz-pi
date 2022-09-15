function defuzzfun = CenterOfSums(xmf, ymf)

    [pks, locs] = findpeaks(ymf, xmf); 
    total_area_sum = 0;
    area_sum = 0;
    
    for i = 1:length(pks)
        
        start = find(xmf == locs(i)); 
        pos_mf = length(ymf(ymf == ymf(start)));
        end_ = start + pos_mf - 1; 
        upper_base = abs(xmf(end_) - xmf(start)); 
        area = 0.5*(1/4 + upper_base) * pks(i);
        center = 0.5*(xmf(end_) + xmf(start) );
        area_sum = area_sum + area;
        total_area_sum = total_area_sum + area * center;
    end
    
     if (ymf(1) ~= 0) 
        
        start = 1;
        pos_mf = length(ymf(ymf == ymf(start)));
        end_ = start + pos_mf - 1; 
        
        upper_base = abs(xmf(end_) - xmf(start));
        area = 0.5*(1/4 + upper_base) * ymf(1);
        
        y1 =@(w) (ymf(1) .*w);
        y2 =@(w) ((ymf(1) / (xmf(end_) + 0.5)) .* (w + 0.5) .*w); 
        
        int_1 = integral(y1, - 1, xmf(end_)); 
        int_2 = integral(y2, xmf(end_), - 0.5);
        int_total =int_1+int_2;
        
        center =  int_total / area;
        area_sum = area_sum + area;
        total_area_sum = total_area_sum + center * area;
        
     end

    if (ymf(end) ~= 0) 
      
        start = 101;
        pos_mf = length(ymf(ymf == ymf(start)));
        end_ = start - pos_mf - 1; 
        
        upper_base = abs( xmf(start)- xmf(end_));
        area = 0.5*(1/4 + upper_base) * ymf(end);
        
        y1 =@(w) ((ymf(end) / (xmf(end_) - 0.50)) .* (w - 0.50) .* w);
        y2 =@(w) (ymf(end) .*w);
        
        int_1 = integral(y1, 0.5, xmf(end_));
        int_2 = integral(y2, xmf(end_), 1);
        int_total =int_1+int_2;
        
        center =  int_total / area;
        area_sum = area_sum + area;
        total_area_sum = total_area_sum + center * area;
        
    end

    defuzzfun = total_area_sum / area_sum;
    
end