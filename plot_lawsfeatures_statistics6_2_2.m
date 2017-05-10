function plot_lawsfeatures_statistics6_2_2( I, section_size, section_num, offset, numlevel )
    L5=[1 4 6 4 1];
    E5=[- 1 , -2, 0, 2, 1];
    S5=[- 1 , 0, 2, 0, - 1];
    R5=[1 , -4, 6, -4, 1];
    W5=[- 1 , 2 , 0, -2 , -1];
    mask = R5'*W5;
    I = conv2(double(I),mask);
    [height,width] = size(I);
    h_offset = floor((height-section_size)/(section_num-1));
    w_offset = floor((width-section_size)/(section_num-1));
    statistics = zeros(section_num*section_num,1);
    for h=0:section_num-1
        for w=0:section_num-1
            subimage = I(1+h*h_offset:1+h*h_offset+section_size-1,1+w*w_offset:1+w*w_offset+section_size-1);
            statistics(h+1+w*section_num,:) = texture_coofeatures( subimage,offset,numlevel );
        end
    end
    
    plot(reshape(statistics,[1,numel(statistics)]));
    
    xlabel(sprintf('subimage index (section size = %d, numlevel = %d)',section_size,numlevel));
    ylabel('energy');
end

