    iter = 0;
    for i = x0.parameters.map
        iter = iter + 1;
        eval("x0.parameters.values(x0.parameters.map("+iter+").ValueIndices(1):x0.parameters.map("+iter+").ValueIndices(2)) = "+  i.Identifier+";")
    end