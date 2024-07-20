function z = dominate(p, q)
    c1 = [p.cost];
    c2 = [q.cost];
    r1 = [p.referencepoint];
    r2 = [q.referencepoint];
    
    if all(c1 <= c2) && any(c1 < c2)
        z = 1;
    elseif ~all(c1 >= c2)
        if r1 == r2 
            if (c1(1)^2 + c1(2)^2)^0.5 < (c2(1)^2 + c2(2)^2)^0.5
                z = 1;
            else
                z = 0;
            end
        else
            z = 0;
        end
    else
        z = 0;
    end
end
