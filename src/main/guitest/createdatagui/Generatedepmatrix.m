% Created by: Isak Bohman, 2015
function [ DependencyMatrix ] = Generatedepmatrix(TimelineSolution, Ndependencies, variance, mu, rectify,constrain)
% Deprecated. Naïve dependency creator.

while i <= Ndeps
    
    p = rand(avg_chain_len,1,1);
    if p==avg_chain_len
        % create chain.
        create_chain(Ndeps-i+1);
        % subtract awaya the chain's length.
    else
        % Do as usually.
        
    end
end

create_chain
direction = 1;
admissible_set = create_admissible_set(candidate,direction);
if isempty(admissible_set)
    direction=2;
    admissible_set = create_admissible_set(candidate,direction);
end

if isempty(admissible_set)
    % Don't create a chain nor even a dependency.
else
    % Create chain in the desired driection.
    % Assumes that admissible_set is created in a "good" way.
    % Just randomize. Depends on rectify!
    j=2;
    while chain_bool == 1
        % Add element in dependency matrix.
        % Create the next admissible_set, calculate admissible_set based on
        % this next element.
        
    end
    
end






end