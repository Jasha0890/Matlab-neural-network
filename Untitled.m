numHidden = 3;
numInputs = 2;

% w1 w3 n/a
% n/a w4 w6

inputs = [0 1; 1 0];
outputs = [1; 1];
inputToHidden = [0.3 0.2 0; 0 0.3 0.2];
inputToOutput = [0.2 -0.1];
hiddenToOutput = [-0.1, -0.1, 0.2];


learningRate = 1;

%matrices for the weight changes
deltaInputToHidden = zeros(numInputs, numHidden);
deltaInputToOutput = zeros(1, numInputs);
deltaHiddenToOutput = zeros(1, numHidden);

outYs = zeros(1, numHidden);
betaIs = [numHidden];





for epoc = 0:1
    
    for j = 1:numHidden
        inp = mod(epoc,numInputs) + 1;
        
        s = 0;
        out_1 = 0;
        out_2 = 0;

        for i = 1:numInputs
            s = s + (inputToHidden(i,j))*(inputs(inp,i));
            
            

        end
        
        outYs(j) = 1 / (1+ exp(-(s)));
        
   
        
        
    end
    
    for k = 1:numInputs
        out_2 = out_2 + ((inputs(inp, k) * inputToOutput(k)));
        
    end
    
    for i = 1:numHidden
    
        out_1 =  out_1 +(outYs(i) * hiddenToOutput(i));
    
    end
        
    out_final = out_1 + out_2;
    beta_out = outputs(epoc+1) - (out_final);
    
    for k = 1:numHidden
    
        deltaHiddenToOutput(k) = (learningRate) * (beta_out) * (outYs(k));
        betaIs(k) = (outYs(k)) * (1 - outYs(k)) * (beta_out) * (hiddenToOutput(k));
        
       
        
        
        for p = 1:numInputs
             if  inputToHidden(p,k) ~= 0
            
                deltaInputToHidden(p,k) = 1 * (betaIs(k) * (inputs(inp,p)));
                deltaInputToOutput(p) = 1 * (beta_out) * (inputs(inp, p));
            
             end
            
            
        end
        
  
    end
    
    hiddenToOutput = hiddenToOutput + deltaHiddenToOutput;
    inputToHidden = inputToHidden + deltaInputToHidden;
    inputToOutput = inputToOutput + deltaInputToOutput;
    
  
   
    
    
end

disp(inputToHidden);
disp(hiddenToOutput);
disp(inputToOutput);