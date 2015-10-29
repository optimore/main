function [ DependencyMatrix ] = Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Slumpa ut vilka tasks som ska få dependencies. Eventuellt flera deps på
% samma task. Dock får det inte vara identiska deps. Att för varje task
% kolla alla andra tidigare tasks kan bli lite väl mycket. Eventuellt får
% man ha någon cutoff.


%konvertera TimelineSolution till något användbart

Tsol = [];

for j=1:length(TimelineSolution)
    Tsol = [Tsol; TimelineSolution{j}, j*ones(size(TimelineSolution{j},1),1)];
    % size(TimelineSolution{j},1)
end

% length(TimelineSolution)

% size(Tsol)
DependencyMatrix = zeros(Ndependencies,4);

% Vektor med sluttider.
ending_times = Tsol(:,1)+Tsol(:,2);

Ntasks = 0;

% Slumpa fram vilken task som ska få en dependency

for i=1:length(TimelineSolution)
    Ntasks = Ntasks + size(TimelineSolution{i},1);
end

% TimelineSolution

% Test för att utvärdera ConvertLongIndex m.m.

% a = ConvertLongIndex(25)
% 
% ConvertToLong(a(1), a(2))



for i=1:Ndependencies
    x=0;
    
    while x==0
        candidate = ConvertLongIndex(generate_candidate(Ntasks));
        
%         DependencyMatrix
        y=0;
        
        % Måste ta fram indexen! Görs på detta sätt.
%           candidate(1)
%           candidate(2)
%         TimelineSolution{candidate(2)}(candidate(1),1)
        admissible_set = find(ending_times <= TimelineSolution{candidate(2)}(candidate(1),1));
        
        currently_dependent_upon = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
        currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
        
        if size(admissible_set,1) > size(currently_dependent_upon,1)
            % Skapa dependency
            x = 1;
            test_length = size(admissible_set,1);
            while y==0
                % Slumpa fram en task i den tillåtliga mängden.
                candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
                
                % Detta ger indexet för indexet i admissible_set.
                if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows')))
                    % Om tillåtlig
                    y = 1;
                    DependencyMatrix(i,:) = [candidate2, candidate];
                end
                
            end
        end
    end
end

%     function bool = admissile_candidate(candidate)
%         
%         % Hitta vilka tasks som är möjliga att ingå i en dependency
%         % Hitta vilka tasks som redan ingår i en dependency med candidate.
%         % Tag fram en mängd med tasks där en tillåtlign dependency kan
%         % slumpas fram.
%         
%     end



    function task_index = generate_candidate(Ntasks)
        task_index = randi(Ntasks,1,1);
    end


    function candidate = ConvertLongIndex(index)
        ind = 1;
        indexiterator = 1;
        boo=0;
        while boo==0 %indexiterator < index
            
            
            number =  index-indexiterator+1;
            if  number <= size(TimelineSolution{ind},1)
                % i första fallet forstätt, i andra avbryt
                boo=1;
            else
                
                indexiterator = indexiterator + size(TimelineSolution{ind},1);
                ind = ind+1;
            end
            
        end
        timeline = ind;
        candidate = [number, timeline];
    end

    function longindex = ConvertToLong(number, timeline)
        longindex = 1;
        for k=1:timeline-1
            longindex = longindex+size(TimelineSolution{k},1);
        end
        longindex = longindex + number-1;
    end























% % Kan inte använda samma fukntkion ty Kan ha flera dependencies på varje.
% depvector = generatelistofstartingpoints(Ntasks, Ndependencies);

% Slumpa fram vilka tasks som ska få det mha likformigt fördelade igen. Kan
% inte generera mha en lång vektor, utan blir en loop där det kollas
% tillåtenhet på varje dependency in spe.
% for j=1:length(TimelineSolution)
%     task = randn(Ntasks,1,1);
%     
%     [number, timeline] = ConvertLongIndex(task);
%     convergentnodes = find(DependencyMatrix == [number, timeline]);
%     
%     % 
%     
%     if ~empty(convergentnodes)
%         % Gör nåt här.
%         if size(convergentnodes,2) > allowable
%             % Måste slumpa fream något nytt
%         end
%     else
%         % Gör nåt annat här
%         
%     end
%     
%     % Kolla om tasken är med i dep.matrix, och hur många gånger.
%     
%     while x==0
%         
%         while y==0
%             
%             
%             
%         end
%         
%     end
%     
%     % Slumpa fram vilken task den ska va beroende till.
%     
%     for i=1:length(TimelineSolution)
%         % Välj ut alla tasks med ending time <= starting time för den valda
%         % tasken.
%         % Kolla sedan om tasken kan ingå i en dependency.
%     end
%     
%     % x=0: tillåten dependency.
%     x=0;
%     while x==0
%         
% 
%     end
% 
% end


end

