function [ DependencyMatrix ] = Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu, rectify,constrain)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Slumpa ut vilka tasks som ska f� dependencies. Eventuellt flera deps p�
% samma task. Dock f�r det inte vara identiska deps. Att f�r varje task
% kolla alla andra tidigare tasks kan bli lite v�l mycket. Eventuellt f�r
% man ha n�gon cutoff.


%konvertera TimelineSolution till n�got anv�ndbart

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
starting_times = Tsol(:,1);

Ntasks = 0;

% Slumpa fram vilken task som ska f� en dependency

for i=1:length(TimelineSolution)
    Ntasks = Ntasks + size(TimelineSolution{i},1);
end

% TimelineSolution

% Test f�r att utv�rdera ConvertLongIndex m.m.

% a = ConvertLongIndex(25)
% 
% ConvertToLong(a(1), a(2))



for i=1:Ndependencies
    x=0;
    
    if mod(i,2) == 1
        
        while x==0
            
            candidate = ConvertLongIndex(generate_candidate(Ntasks));
            
            %         DependencyMatrix
            y=0;
            
            % M�ste ta fram indexen! G�rs p� detta s�tt.
            %           candidate(1)
            %           candidate(2)
            %         TimelineSolution{candidate(2)}(candidate(1),1)
            
            if constrain == 1
                end_times = TimelineSolution{candidate(2)}(:,1)+TimelineSolution{candidate(2)}(:,2);
                admissible_set = find(end_times <= TimelineSolution{candidate(2)}(candidate(1),1));
                if ~isempty(admissible_set)
                    admissible_set = admissible_set+prev_indices(candidate(2));
                end
                
            else
                
                admissible_set = find(ending_times <= TimelineSolution{candidate(2)}(candidate(1),1));
            end
            
            if rectify == 1
                admissible_set_lengths = [];
                for it3=1:size(admissible_set,1)
                    
                    candidate3 = ConvertLongIndex(admissible_set(it3));
                    
                    admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
                end
            end
            
            currently_dependent_upon = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
            currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
            
            
            if size(admissible_set,1) > size(currently_dependent_upon,1)
                % Skapa dependency
                x = 1;
                if rectify == 0
                    test_length = size(admissible_set,1);
                else
                    test_length = sum(admissible_set_lengths);
                end
                
                while y==0
                    % Slumpa fram en task i den till�tliga m�ngden.
                    if rectify == 0
                        candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
                    else
                        candidate2 = ConvertLongIndex(admissible_set(convert_to_index(generate_candidate(test_length),admissible_set_lengths)));
                    end
                    
                    % Detta ger indexet f�r indexet i admissible_set.
                    if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows')))
                        % Om till�tlig
                        y = 1;
                        DependencyMatrix(i,:) = [candidate2, candidate];
                    end
                    
                end
            end
        end
    else
        while x==0
            candidate = ConvertLongIndex(generate_candidate(Ntasks));
            
            y=0;
            
            if constrain == 1
                start_times = TimelineSolution{candidate(2)}(:,1);
                admissible_set = find(start_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
                    TimelineSolution{candidate(2)}(candidate(1),2));
                if ~isempty(admissible_set)
                    admissible_set = admissible_set+prev_indices(candidate(2));
                end
            else
                admissible_set = find(starting_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
                    TimelineSolution{candidate(2)}(candidate(1),2));
            end
            
            if rectify == 1
                admissible_set_lengths = [];
                for it3=1:size(admissible_set,1)
                    
                    candidate3 = ConvertLongIndex(admissible_set(it3));
                    
                    admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
                end
            end
            
            currently_dependent_upon = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
            currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
            
            if size(admissible_set,1) > size(currently_dependent_upon,1)
                % Skapa dependency
                x = 1;
                if rectify == 0
                    test_length = size(admissible_set,1);
                else
                    test_length = sum(admissible_set_lengths);
                end
                while y==0
                    % Slumpa fram en task i den till�tliga m�ngden.
                    if rectify == 0
                        candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
                    else
                        candidate2 = ConvertLongIndex(admissible_set(convert_to_index(generate_candidate(test_length),admissible_set_lengths)));
                    end
                    % Detta ger indexet f�r indexet i admissible_set.
                    if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows')))
                        % Om till�tlig
                        y = 1;
                        DependencyMatrix(i,:) = [candidate, candidate2];
                    end
                    
                end
            end
        end
    end
end

%     function bool = admissile_candidate(candidate)
%         
%         % Hitta vilka tasks som �r m�jliga att ing� i en dependency
%         % Hitta vilka tasks som redan ing�r i en dependency med candidate.
%         % Tag fram en m�ngd med tasks d�r en till�tlign dependency kan
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
                % i f�rsta fallet forts�tt, i andra avbryt
                boo=1;
            else
                
                indexiterator = indexiterator + size(TimelineSolution{ind},1);
                ind = ind+1;
            end
            
        end
        timeline = ind;
        candidate = [number, timeline];
    end

%     function longindex = ConvertToLong(number, timeline)
%         longindex = 1;
%         for k=1:timeline-1
%             longindex = longindex+size(TimelineSolution{k},1);
%         end
%         longindex = longindex + number-1;
%     end

    function long_index = convert_to_index(index, admissible_set_lengths)
        ind = 1;
        indexiterator = 1;
        boo=0;
        while boo==0 %indexiterator < index
            
            
            number =  index-indexiterator+1;
            if  number <= admissible_set_lengths(ind)
                % i f�rsta fallet forts�tt, i andra avbryt
                boo=1;
            else
                
                indexiterator = indexiterator + admissible_set_lengths(ind);
                ind = ind+1;
            end
            
        end
        timeline = ind;
        long_index = timeline;
    end

    function prev_ind = prev_indices(ind)
        prev_ind = 0;
        if ind ~= 1
            for k=1:ind-1
                
                prev_ind = prev_ind+size(TimelineSolution{k},1);
                
            end
        end
    end















% % Kan inte anv�nda samma fukntkion ty Kan ha flera dependencies p� varje.
% depvector = generatelistofstartingpoints(Ntasks, Ndependencies);

% Slumpa fram vilka tasks som ska f� det mha likformigt f�rdelade igen. Kan
% inte generera mha en l�ng vektor, utan blir en loop d�r det kollas
% till�tenhet p� varje dependency in spe.
% for j=1:length(TimelineSolution)
%     task = randn(Ntasks,1,1);
%     
%     [number, timeline] = ConvertLongIndex(task);
%     convergentnodes = find(DependencyMatrix == [number, timeline]);
%     
%     % 
%     
%     if ~empty(convergentnodes)
%         % G�r n�t h�r.
%         if size(convergentnodes,2) > allowable
%             % M�ste slumpa fream n�got nytt
%         end
%     else
%         % G�r n�t annat h�r
%         
%     end
%     
%     % Kolla om tasken �r med i dep.matrix, och hur m�nga g�nger.
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
%         % V�lj ut alla tasks med ending time <= starting time f�r den valda
%         % tasken.
%         % Kolla sedan om tasken kan ing� i en dependency.
%     end
%     
%     % x=0: till�ten dependency.
%     x=0;
%     while x==0
%         
% 
%     end
% 
% end


end

