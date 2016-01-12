% Created by: Isak Bohman, 2015
function [ DependencyMatrix ] = Generatedependencymatrix(TimelineSolution, Ndependencies, variance, mu, rectify,constrain)
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


DependencyMatrix = zeros(Ndependencies,4);
% DependencyMatrix = [];

% Vektor med sluttider.

ending_times = Tsol(:,1)+Tsol(:,2);
starting_times = Tsol(:,1);

Ntasks = 0;

% Slumpa fram vilken task som ska få en dependency

for i=1:length(TimelineSolution)
    Ntasks = Ntasks + size(TimelineSolution{i},1);
end

tasks_left = Tsol;

% Ndeps >= 2*antalet tasks. Väldigt enkelt att få en tillåten lösning.
% if Ntasks <= Ndependencies && constrain == 0
%     for it1=1:Ntasks
%         cur_task = tasks_left(1,:);
%         
%         
%         cur_index = [find(ismember(TimelineSolution{cur_task(end)},cur_task),1),cur_task(end)];
%         dir=1;
%         if cur_index ~[length(TimelineSolution),size(TimelineSolution{end},1)]
%             tasks_left = tasks_left(2:end,:);
%         end
%         
%         admissible_set = find(ending_times <= TimelineSolution{candidate(2)}(candidate(1),1));
%         
%         if rectify == 1
%             admissible_set_lengths = [];
%             for it3=1:size(admissible_set,1)
%                 
%                 candidate3 = ConvertLongIndex(admissible_set(it3));
%                 
%                 admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
%             end
%         end
%         if isempty(admissible_set)
%             
%             dir = 2; 
%             admissible_set =  [];
%         end
%         
%         % Slumpa fram ur admissible_set
%         x=0;
%         while x==0
%             
%             
%             
%         end
%         
%         
%         
%     end
%     
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% if Ntasks <= Ndependencies
%     % Skapa kedjor av dependencies. Antagligen ett lager.
%     % Varje kedja är 3-10 tasks lång.
%     min_chain_length = 3;
%     max_chain_length = 10;
%     avg_chain_len = ceil((min_chain_length+max_chain_length)/2);
%     x=0;
%     
% 
%     % direction=1 om vi ska kolla framåt.
%     direction = 1;
%     while x==0
%         % Sannolikheten att skapa att inleda en chain bör vara 0.5, måste
%         % dock kompensera med kedjans förväntade längd = ~5? Så p =
%         % 0.5*2/5. Tag p=0.2.
%         p = rand(avg_chain_len,1,1);
%         
%         cur_task = tasks_left(1,:);
%         cur_index = find(ismember(TimelineSolution{cur_task(end)},cur_task),1);
%         % Måste hitta motsvarande index i TimelineSolution
%         tasks_left = tasks_left(2:end,:);
%         
%         % Hur många gånger vi har hoppat till en annan timeline.
%         timeline_jumps = 0;
%         
%         % Finns inga möjligheter att skapa en kedja?
%         no_admissible_chain = 0;
%         
%         
%         if p==avg_chain_len
%             chain_length = randi(max_chain_length-min_chain_length+1,1,1)+min_chain_length-1; 
%             chain_bool = 1;
%             j=2; % Vilken task vi är på nu i dependencyn. cur_task betraktas som redan inkluderad.
%             
%             %% ta reda på om vi kan skapa kedja, och åt vilket håll.
%             while chain_bool == 1
%                 % Hitta en task med nöjaktig starttid, måste nog ta hänsyn
%                 % till hur många tasks det finns kvar att välja på. Välj ut
%                 % en mängd tasks med starttid <= (L-task1_end)/chain_length
%                 
%                 bool = 0;
%                 admissible_set = [];
%                 % Jobbigt. Om det inte finns någon task efteråt måste vi
%                 % börja kolla på tidigare tasks, dvs vända på hela
%                 % schabraket.
%                 % Här tar vi reda på om kedjan ska gå framåt eller bakåt.
%                 check_iterator =1;
%                 
%                 % Vid varje steg måste man pröva först om dir=1 el 2.
%                 % Sedan måste man när kedjan påbörjas kolla om man ska gå
%                 % bakåt eller om det går att komma framåt.
%                 
%                 
%                 % Kolla om vi kan skapa en framåtgående kedja.
%                 while bool == 0
%                     % Fler villkor behövs. Kolla att inte ingår i dep med
%                     % någon i admissible_set.
%                     admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
%                     
%                     % Måste dela upp detta i en del på den egna tidslinjen.
%                     currently_dependent_upon = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
%                     currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
%                     
%                     if size(admissible_set,1) > size(currently_dependent_upon,1)
%                         bool =1;
%                     elseif check_iterator >= max_chain_length
%                         % Pröva att gå bakåt. Om inte ens det lyckas, gör
%                         % vanlig dependency.
%                         direction = 2;
%                         bool = 1;
%                     end
%                     
%                 end
%                 
%                 
%                 % Kolla om vi kan skapa en bakåtgående kedja.
%                 if direction == 2
%                     bool = 0;
%                     while bool == 0
%                         % Kan eventuellt behöva en iterator här, som dock
%                         % alltid kommer att ge att vi får en tillräckligt
%                         % lång chain.
%                         admissible_set = find(ending_times <= cur_task(1) && ending_times >= cur_task(1)-round(check_iterator*cur_task(1)/max_chain_length));
%                         currently_dependent_upon = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
%                         currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
%                         
%                         
%                         if size(admissible_set,1) > size(currently_dependent_upon,1)
%                             bool =1;
%                         elseif check_iterator >= max_chain_length
%                             % Pröva att gå bakåt. Om inte ens det lyckas, gör
%                             % vanlig dependency.
%                             no_admissible_chain = 1;
%                             chain_bool = 0;
%                             bool = 1;
%                         end
%                     end
%                 end
%                 
%                 % Dependencies ska vara på den egna tidslinjen, främst. Så
%                 % börja kolla om det funkar på den egna tidslinjen, givet
%                 % ingen chain.
%                 
%             end
%             
%             %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             % Här skapar vi en kedja.
%             % Måste dock kolla om timeline_jumps = 1, då får vi bara kolla
%             % på innevarande timelinen. Dessutom måste vi kolla om det
%             % finns tasks i admissible_set som vi redan står i dependency
%             % med.
%             if direction == 1 && no_admissible_chain == 0
%                 % Skapa chain genom att söka framåt
%                 while chain_bool == 1
%                     bool = 0;
%                     admissible_set = [];
%                     % Här tar vi reda på om kedjan ska gå framåt eller bakåt.
%                     check_iterator =1;
%                     
%                     % Följande används för att leta en task i närheten, så
%                     % att dpendencyn kan vara tillräckligt lång.
%                     while bool == 0
%                         if timeline_jumps == 0
%                             admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
%                             start_times = TimelineSolution{candidate(2)}(:,1);
%                             admissible_set = find(start_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
%                                 TimelineSolution{candidate(2)}(candidate(1),2));
%                             if ~isempty(admissible_set)
%                                 admissible_set = admissible_set+prev_indices(candidate(2));
%                             end
%                             
%                             
%                         else % förstora upp sannolikheten att träffa på en på den egna tidslinjen med antal tidslinjer*förväntade kedjelängden/2
%                             
%                         end
%                         
%                         
%                         if ~isempty(admissible_set)
%                             bool =1;
%                         elseif check_iterator >= max_chain_length
%                             % Pröva att gå bakåt. Om inte ens det lyckas, gör
%                             % vanlig dependency.
%                             direction = 2;
%                         end
%                     end
%                     % Dependencies ska vara på den egna tidslinjen, främst. Så
%                     % börja kolla om det funkar på den egna tidslinjen, givet
%                     % ingen chain.
%                     
%                     j=j+1;
%                     if j > chain_length
%                         chain_bool = 0;
%                     end
%                 end
%                 
%             elseif no_admissible_chain == 0 
%                 %%
%                 % Skapa chain genom att söka bakåt
%                 while chain_bool == 1
%                     % Hitta en task med nöjaktig starttid, måste nog ta hänsyn
%                     % till hur många tasks det finns kvar att välja på. Välj ut
%                     % en mängd tasks med starttid <= (L-task1_end)/chain_length
%                     
%                     bool = 0;
%                     admissible_set = [];
%                     % Jobbigt. Om det inte finns någon task efteråt måste vi
%                     % börja kolla på tidigare tasks, dvs vända på hela
%                     % schabraket.
%                     % Här tar vi reda på om kedjan ska gå framåt eller bakåt.
%                     check_iterator =1;
%                     
%                     % Vid varje steg måste man pröva först om dir=1 el 2.
%                     % Sedan måste man när kedjan påbörjas kolla om man ska gå
%                     % bakåt eller om det går att komma framåt.
%                     while bool == 0
%                         %                     admissible_set = find(starting_times >= TimelineSolution{cur_task(end)}(candidate(1),1)+ ...
%                         %                     TimelineSolution{candidate(2)}(candidate(1),2));
%                         admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
%                         
%                         if ~isempty(admissible_set)
%                             bool =1;
%                         elseif check_iterator >= max_chain_length
%                             % Pröva att gå bakåt. Om inte ens det lyckas, gör
%                             % vanlig dependency.
%                             direction = 2;
%                         end
%                         
%                         if direction == 2
%                             % Kan eventuellt behöva en iterator här, som dock
%                             % alltid kommer att ge att vi får en tillr'ckligt
%                             % lång chain.
%                             admissible_set = find(ending_times <= cur_task(1) && ending_times >= cur_task(1)-round(check_iterator*cur_task(1)/max_chain_length));
%                             
%                             
%                         end
%                     end
%                     % Dependencies ska vara på den egna tidslinjen, främst. Så
%                     % börja kolla om det funkar på den egna tidslinjen, givet
%                     % ingen chain.
%                     
%                     j=j+1;
%                     if j > chain_length
%                         chain_bool = 0;
%                     end
%                 end
%             else
%                 % Kan inte skapa kedja.
%                 
%             end
%             
%         else
%             % Skapa bara enkla dependencies.
%             % Här skapar vi dependencies på det gamla sättet, förmodligen
%             % p.s.s. att de flesta är inom tidslinjen.
%             
%         end
%         
%         
%         chain_length = 1;
%         
%     end
% else
%     % Gör på det gamla sättet.
%     
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

min_chain_length = 3;
max_chain_length = 10;
avg_chain_len = ceil((min_chain_length+max_chain_length)/2);

if Ntasks<=Ndependencies
    first_pass = 1;
else
    first_pass = 0;
end


all_connected = 0;
if Ndependencies >= Ntasks
    all_connected = 1;
end
i=1;
while i <= Ndependencies
        
    x=0;
    
    p = rand(avg_chain_len,1,1);
    % Behövs specialfall då tasks_left är tom.
    cur_task = tasks_left(1,:);
    cur_index = find(ismember(TimelineSolution{cur_task(end)},cur_task),1);
    tasks_left = tasks_left(2:end,:);
    % Hur många gånger vi har hoppat till en annan timeline.
    timeline_jumps = 0;
    
    % Finns inga möjligheter att skapa en kedja?
    no_admissible_chain = 0;
    direction = 1;
    if p==avg_chain_len
        chain_length = randi(max_chain_length-min_chain_length+1,1,1)+min_chain_length-1;
        chain_bool = 1;
        j=2; % Vilken task vi är på nu i dependencyn. cur_task betraktas som redan inkluderad.
        % Skapa chainzzzZz
        while chain_bool == 1
            % Hitta en task med nöjaktig starttid,
            
            bool = 0;
            admissible_set = [];
            % Här tar vi reda på om kedjan ska gå framåt eller bakåt.
            check_iterator =1;
            
            % Kolla om vi kan skapa en framåtgående kedja.
            candidate = [cur_index,cur_task(end)];
            while bool == 0
                % Fler villkor behövs. Kolla att inte ingår i dep med
                % någon i admissible_set.
                if first_pass == 1 && i <= Ntasks && size(tasks_left,1) > 0
                    % Hitta tasks som har högst en tidigare dependency.
                    if constrain == 1
                        
                        task_start = cur_task(1);
                        task_length = cur_task(2);
                        task_timeline = cur_task(end);
                        
                        start_times = TimelineSolution{task_timeline}(:,1);
                        
                        admissible_set = find(start_times >= task_start+task_length && ...
                            start_times <= round(check_iterator*(L-(task_start+task_length))/max_chain_length));
                        
                        if ~isempty(admissible_set)
                            admissible_set = admissible_set+prev_indices(task_timeline);
                        end
                    else
                        admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && ...
                            starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
                    end
                    % subtrahera bort tasks med fler än ett beroende.
                    if size(admissible_set,1) > 0
                        for it=1:size(admissible_set,1)
                            candidate = ConvertLongIndex(admissible_set(i));
                            dependencies_beginning_with = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
                            dependencies_ending_with = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
                            if size(dependencies_beginning_with,1)+size(dependencies_ending_with,1) >= 2
                                admissible_set = subtract_row(admissible_set,i);
                            end
                            
                        end
                        % Måste också subtrahera bort element som cur_task
                        % redan är beroende med.
                        
                        
                        
                    else
                        bool = 1;
                        direction=2;
                    end
                    
                else
                    
                end
                
                if size(admissible_set,1) > size(currently_dependent_upon,1)
                    bool =1;
                elseif check_iterator >= max_chain_length
                    % Pröva att gå bakåt. Om inte ens det lyckas, gör
                    % vanlig dependency.
                    direction = 2;
                    bool = 1;
                end
                
            end
            
            
            % Kolla om vi kan skapa en bakåtgående kedja.
            if direction == 2
                bool = 0;
                while bool == 0
                    % Kan eventuellt behöva en iterator här, som dock
                    % alltid kommer att ge att vi får en tillräckligt
                    % lång chain.
                    if first_pass == 1 && i <= Ntasks && size(tasks_left,1) > 0
                    admissible_set = find(ending_times <= cur_task(1) && ...
                        ending_times >= cur_task(1)-round(check_iterator*cur_task(1)/max_chain_length));
                    else
                        
                    end
                    currently_dependent_upon = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
                    
                    if size(admissible_set,1) > size(currently_dependent_upon,1)
                        bool =1;
                    elseif check_iterator >= max_chain_length
                        % Pröva att gå bakåt. Om inte ens det lyckas, gör
                        % vanlig dependency.
                        no_admissible_chain = 1;
                        chain_bool = 0;
                        bool = 1;
                    end
                end
            end
            
            
            %% Här börjar vi konstruera en chain.
            
            % Måste dock kolla om timeline_jumps = 1, då får vi bara kolla
            % på innevarande timelinen. Dessutom måste vi kolla om det
            % finns tasks i admissible_set som vi redan står i dependency
            % med.
            if direction == 1 && no_admissible_chain == 0
                % Skapa chain genom att söka framåt
                while chain_bool == 1
                    bool = 0;
                    admissible_set = [];
                    
                    % Följande används för att leta en task i närheten, så
                    % att dpendencyn kan vara tillräckligt lång.
                    while bool == 0
                        if timeline_jumps == 0
                            if first_pass == 1 && i <= Ntasks && size(tasks_left,1) > 0
                                
                                admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
                                
                            end
                            start_times = TimelineSolution{candidate(2)}(:,1);
                            admissible_set = find(start_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
                                TimelineSolution{candidate(2)}(candidate(1),2));
                            if ~isempty(admissible_set)
                                admissible_set = admissible_set+prev_indices(candidate(2));
                            end
                            
                            
                        else % förstora upp sannolikheten att träffa på en på den egna tidslinjen med antal tidslinjer*förväntade kedjelängden/2
                            % får göra liknande kollar här. 
                            if first_pass == 1 && i <= Ntasks && size(tasks_left,1) > 0
                            
                            admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
                            else
                            
                                
                                
                            end
                        end
                        
                        
                        if ~isempty(admissible_set) && j <= max_chain_length
                            bool =1;
                            % Lägg till dependency, 
                            
                            if rectify == 1
                                admissible_set_lengths = [];
                                for it3=1:size(admissible_set,1)
                                    
                                    candidate3 = ConvertLongIndex(admissible_set(it3));
                                    
                                    admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
                                end
                            end
                            
                            
                            currently_dependent_upon = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
                            currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
                            
                            % Denna if-sats är onödig, detta ska hanteras
                            % genom hur admissible_set skapas troligtvis.
                            if size(admissible_set,1) > size(currently_dependent_upon,1)
                                % Skapa dependency
                                bool = 1;
                                if rectify == 0
                                    test_length = size(admissible_set,1);
                                else
                                    test_length = sum(admissible_set_lengths);
                                end
                                while y==0
                                    % Slumpa fram en task i den tillåtliga mängden.
                                    if rectify == 0
                                        candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
                                    else
                                        candidate2 = ConvertLongIndex(admissible_set(convert_to_index(generate_candidate(test_length),admissible_set_lengths)));
                                    end
                                    % Detta ger indexet för indexet i admissible_set.
                                    if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows')))
                                        % Om tillåtlig
                                        y = 1;
                                        DependencyMatrix(i,:) = [cur_task, candidate2];
                                        cur_task = candidate2;
                                        % Om hittar candidate2 i
                                        % tasks_remining, uppdatera tasks
                                        % remaining.
                                        to_be_removed = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
                                        if ~isempty(to_be_removed)
                                            % Kan bli specialfall om endera
                                            % halva av listan är tom.
                                            tasks_remaining
                                        end
                                    end
                                    
                                end
                            end
                            
                            % Uppdater j, tasks remaining
                            
                            
                        elseif check_iterator >= max_chain_length
                            % terminera kedjan.
                            bool = 1;
                            chain_bool = 0;
                        end
                    end
                    
                    j=j+1;
                    if j > chain_length
                        chain_bool = 0;
                    end
                end
                
            elseif no_admissible_chain == 0 
                %%
                % Skapa chain genom att söka bakåt
                while chain_bool == 1
                    % Hitta en task med nöjaktig starttid, måste nog ta hänsyn
                    % till hur många tasks det finns kvar att välja på. Välj ut
                    % en mängd tasks med starttid <= (L-task1_end)/chain_length
                    
                    bool = 0;
                    admissible_set = [];
                    % Jobbigt. Om det inte finns någon task efteråt måste vi
                    % börja kolla på tidigare tasks, dvs vända på hela
                    % schabraket.
                    % Här tar vi reda på om kedjan ska gå framåt eller bakåt.
                    check_iterator =1;
                    
                    % Vid varje steg måste man pröva först om dir=1 el 2.
                    % Sedan måste man när kedjan påbörjas kolla om man ska gå
                    % bakåt eller om det går att komma framåt.
                    while bool == 0
                        %                     admissible_set = find(starting_times >= TimelineSolution{cur_task(end)}(candidate(1),1)+ ...
                        %                     TimelineSolution{candidate(2)}(candidate(1),2));
                        admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
                        
                        if ~isempty(admissible_set)
                            bool =1;
                        elseif check_iterator >= max_chain_length
                            % Pröva att gå bakåt. Om inte ens det lyckas, gör
                            % vanlig dependency.
                            direction = 2;
                        end
                        
                        if direction == 2
                            % Kan eventuellt behöva en iterator här, som dock
                            % alltid kommer att ge att vi får en tillr'ckligt
                            % lång chain.
                            admissible_set = find(ending_times <= cur_task(1) && ending_times >= cur_task(1)-round(check_iterator*cur_task(1)/max_chain_length));
                            
                            
                        end
                    end
                    % Dependencies ska vara på den egna tidslinjen, främst. Så
                    % börja kolla om det funkar på den egna tidslinjen, givet
                    % ingen chain.
                    
                    j=j+1;
                    if j > chain_length
                        chain_bool = 0;
                    end
                end
            else
                % Kan inte skapa kedja.
                
            end
            
        end
        
    else
        
    
    
    while x==0
        
        % Slumpa en task i en dep.
        
        if all_connected == 0 || i > Ntasks
            if rectify == 1
                test_length = sum(Tsol(:,2));
            end
            
            
            if rectify == 0
                candidate = ConvertLongIndex(generate_candidate(Ntasks));
            else
                candidate = ConvertLongIndex(convert_to_index(generate_candidate(test_length),Tsol(:,2)));
            end
        else
            candidate = ConvertLongIndex(i);
            
%             % Alla får inte va mé.
%             if candidate == prev_candidate
%                 all_connected = 1;
%             end
%             
%             prev_candidate = candidate;
        end
        
        y=0;
        
        
        if constrain == 1
            start_times = TimelineSolution{candidate(2)}(:,1);
            end_times = TimelineSolution{candidate(2)}(:,1)+TimelineSolution{candidate(2)}(:,2);
            admissible_set1 = find(end_times <= TimelineSolution{candidate(2)}(candidate(1),1));
            admissible_set2 = find(start_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
                TimelineSolution{candidate(2)}(candidate(1),2));
            admissible_set = [admissible_set1; admissible_set2];
            if ~isempty(admissible_set)
                admissible_set = admissible_set+prev_indices(candidate(2));
            end
            
        else
            
            admissible_set1 = find(ending_times <= TimelineSolution{candidate(2)}(candidate(1),1));
            admissible_set2 = find(starting_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
                TimelineSolution{candidate(2)}(candidate(1),2));
            admissible_set = [admissible_set1; admissible_set2];
        end
        
        if rectify == 1
            admissible_set_lengths = [];
            for it3=1:size(admissible_set,1)
                
                candidate3 = ConvertLongIndex(admissible_set(it3));
                
                admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
            end
        end
        
        currently_dependent_upon1 = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
        currently_dependent_upon_set1 = DependencyMatrix(currently_dependent_upon1,1:2);
        currently_dependent_upon2 = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
        currently_dependent_upon_set2 = DependencyMatrix(currently_dependent_upon2,3:4);
        currently_dependent_upon = [currently_dependent_upon1; currently_dependent_upon2];
        currently_dependent_upon_set = [currently_dependent_upon_set1; currently_dependent_upon_set2];
        
        if size(admissible_set,1) > size(currently_dependent_upon,1)
            % Skapa dependency
            x = 1;
            if rectify == 0
                test_length = size(admissible_set,1);
            else
                test_length = sum(admissible_set_lengths);
            end
            
            while y==0
                % Slumpa fram en task i den tillåtliga mängden.
                if rectify == 0
                    candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
                else
                    candidate2 = ConvertLongIndex(admissible_set(convert_to_index(generate_candidate(test_length),admissible_set_lengths)));
                end
                
                % Detta ger indexet för indexet i admissible_set.
                
                % Måste kolla om tasken ligger före eller efter!
                task1_start = TimelineSolution{candidate(2)}(candidate(1),1);
                task1_end = TimelineSolution{candidate(2)}(candidate(1),1)+TimelineSolution{candidate(2)}(candidate(1),2);
                task2_start = TimelineSolution{candidate2(2)}(candidate2(1),1);
                task2_end = TimelineSolution{candidate2(2)}(candidate2(1),1)+TimelineSolution{candidate2(2)}(candidate2(1),2);
                
                if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows'))) && task2_end <= task1_start
                    % Om tillåtlig
                    y = 1;
                    
                    dep_cand = [candidate2, candidate];
                    if isempty(find(dep_cand==0))
                        DependencyMatrix = [DependencyMatrix; dep_cand];
%                         DependencyMatrix(i,:) = [candidate2, candidate];

                    end
                elseif isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows'))) && task1_end <= task2_start
                    % Om tillåtlig
                    y = 1;
                    
                    % Quick-fix. Måste granska koden närmare för att se vad
                    % som går fel.
                    dep_cand = [candidate, candidate2];
                    if isempty(find(dep_cand==0))
                        DependencyMatrix = [DependencyMatrix; dep_cand];
                    end
                    
                end
            end
        end
        i=i+1;
%     end
    
    
%         while x==0
%             % Tror man måste specialbehandla rectify här
%             % Slumpa fram första tasken i dep.
%             if rectify == 1
%                 test_length = sum(Tsol(:,2));
%             end
%             
%             
%             if rectify == 0
%                 candidate = ConvertLongIndex(generate_candidate(Ntasks));
%             else
%                 
%                 candidate = ConvertLongIndex(convert_to_index(generate_candidate(test_length),Tsol(:,2)));
%             end
%             
%             y=0;
%             
%             if constrain == 1
%                 start_times = TimelineSolution{candidate(2)}(:,1);
%                 admissible_set = find(start_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
%                     TimelineSolution{candidate(2)}(candidate(1),2));
%                 if ~isempty(admissible_set)
%                     admissible_set = admissible_set+prev_indices(candidate(2));
%                 end
%             else
%                 admissible_set = find(starting_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
%                     TimelineSolution{candidate(2)}(candidate(1),2));
%             end
%             
%             if rectify == 1
%                 admissible_set_lengths = [];
%                 for it3=1:size(admissible_set,1)
%                     
%                     candidate3 = ConvertLongIndex(admissible_set(it3));
%                     
%                     admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
%                 end
%             end
%             
%             currently_dependent_upon = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
%             currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
%             
%             if size(admissible_set,1) > size(currently_dependent_upon,1)
%                 % Skapa dependency
%                 x = 1;
%                 if rectify == 0
%                     test_length = size(admissible_set,1);
%                 else
%                     test_length = sum(admissible_set_lengths);
%                 end
%                 while y==0
%                     % Slumpa fram en task i den tillåtliga mängden.
%                     if rectify == 0
%                         candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
%                     else
%                         candidate2 = ConvertLongIndex(admissible_set(convert_to_index(generate_candidate(test_length),admissible_set_lengths)));
%                     end
%                     % Detta ger indexet för indexet i admissible_set.
%                     if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows')))
%                         % Om tillåtlig
%                         y = 1;
%                         DependencyMatrix(i,:) = [candidate, candidate2];
%                     end
%                     
%                 end
%             end
%         end

end
end
% for i=1:Ndependencies
%     x=0;
%     
%     if mod(i,2) == 1
%         
%         while x==0
%             
%             % Slumpa fram sista tasken i en dep.
%             % Tror man måste specialbehandla rectify här
%             
%             if rectify == 1
%                 test_length = sum(Tsol(:,2));
%             end
%             
%             
%             if rectify == 0
%                 candidate = ConvertLongIndex(generate_candidate(Ntasks));
%             else
%                 candidate = ConvertLongIndex(convert_to_index(generate_candidate(test_length),Tsol(:,2)));
%             end
%             %         DependencyMatrix
%             y=0;
%             
%             % Måste ta fram indexen! Görs på detta sätt.
%             %           candidate(1)
%             %           candidate(2)
%             %         TimelineSolution{candidate(2)}(candidate(1),1)
%             
%             if constrain == 1
%                 end_times = TimelineSolution{candidate(2)}(:,1)+TimelineSolution{candidate(2)}(:,2);
%                 admissible_set = find(end_times <= TimelineSolution{candidate(2)}(candidate(1),1));
%                 if ~isempty(admissible_set)
%                     admissible_set = admissible_set+prev_indices(candidate(2));
%                 end
%                 
%             else
%                 
%                 admissible_set = find(ending_times <= TimelineSolution{candidate(2)}(candidate(1),1));
%             end
%             
%             if rectify == 1
%                 admissible_set_lengths = [];
%                 for it3=1:size(admissible_set,1)
%                     
%                     candidate3 = ConvertLongIndex(admissible_set(it3));
%                     
%                     admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
%                 end
%             end
%             
%             currently_dependent_upon = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
%             currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,1:2);
%             
%             
%             if size(admissible_set,1) > size(currently_dependent_upon,1)
%                 % Skapa dependency
%                 x = 1;
%                 if rectify == 0
%                     test_length = size(admissible_set,1);
%                 else
%                     test_length = sum(admissible_set_lengths);
%                 end
%                 
%                 while y==0
%                     % Slumpa fram en task i den tillåtliga mängden.
%                     if rectify == 0
%                         candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
%                     else
%                         candidate2 = ConvertLongIndex(admissible_set(convert_to_index(generate_candidate(test_length),admissible_set_lengths)));
%                     end
%                     
%                     % Detta ger indexet för indexet i admissible_set.
%                     if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows')))
%                         % Om tillåtlig
%                         y = 1;
%                         DependencyMatrix(i,:) = [candidate2, candidate];
%                     end
%                     
%                 end
%             end
%         end
%     else
%         while x==0
%             % Tror man måste specialbehandla rectify här
%             % Slumpa fram första tasken i dep.
%             if rectify == 1
%                 test_length = sum(Tsol(:,2));
%             end
%             
%             
%             if rectify == 0
%                 candidate = ConvertLongIndex(generate_candidate(Ntasks));
%             else
%                 
%                 candidate = ConvertLongIndex(convert_to_index(generate_candidate(test_length),Tsol(:,2)));
%             end
%             
%             y=0;
%             
%             if constrain == 1
%                 start_times = TimelineSolution{candidate(2)}(:,1);
%                 admissible_set = find(start_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
%                     TimelineSolution{candidate(2)}(candidate(1),2));
%                 if ~isempty(admissible_set)
%                     admissible_set = admissible_set+prev_indices(candidate(2));
%                 end
%             else
%                 admissible_set = find(starting_times >= TimelineSolution{candidate(2)}(candidate(1),1)+ ...
%                     TimelineSolution{candidate(2)}(candidate(1),2));
%             end
%             
%             if rectify == 1
%                 admissible_set_lengths = [];
%                 for it3=1:size(admissible_set,1)
%                     
%                     candidate3 = ConvertLongIndex(admissible_set(it3));
%                     
%                     admissible_set_lengths = [admissible_set_lengths; TimelineSolution{candidate3(2)}(candidate3(1),2)];
%                 end
%             end
%             
%             currently_dependent_upon = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
%             currently_dependent_upon_set = DependencyMatrix(currently_dependent_upon,3:4);
%             
%             if size(admissible_set,1) > size(currently_dependent_upon,1)
%                 % Skapa dependency
%                 x = 1;
%                 if rectify == 0
%                     test_length = size(admissible_set,1);
%                 else
%                     test_length = sum(admissible_set_lengths);
%                 end
%                 while y==0
%                     % Slumpa fram en task i den tillåtliga mängden.
%                     if rectify == 0
%                         candidate2 = ConvertLongIndex(admissible_set(generate_candidate(test_length)));
%                     else
%                         candidate2 = ConvertLongIndex(admissible_set(convert_to_index(generate_candidate(test_length),admissible_set_lengths)));
%                     end
%                     % Detta ger indexet för indexet i admissible_set.
%                     if isempty(find(ismember(currently_dependent_upon_set,candidate2,'rows')))
%                         % Om tillåtlig
%                         y = 1;
%                         DependencyMatrix(i,:) = [candidate, candidate2];
%                     end
%                     
%                 end
%             end
%         end
%     end
% end

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
                % i första fallet fortsätt, i andra avbryt
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
                % i första fallet fortsätt, i andra avbryt
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

    function element = subtract_row(admissible_set, i)
        if i == 1
            element = admissible_set(i+1:end,:);
        elseif i == size(admissible_set,1)
            element = admissible_set(1:i-1,:);
        else
            element = [admissible_set(1:i-1,:); admissible_set(i+1:end,:)];
        end
    end


%     function direction = check_direction()
%         
%         
%     end
% 
% 
    function admissible_set = create_admissible_set(constrain, cur_task, first_pass, direction, timeline_jumps)
        
    % framåt
        if direction == 1
            if first_pass == 1 && i <= Ntasks && size(tasks_left,1) > 0
                if  timeline_jumps == 1 || constrain == 1
                    
                    task_start = cur_task(1);
                    task_length = cur_task(2);
                    task_timeline = cur_task(end);
                    
                    start_times = TimelineSolution{task_timeline}(:,1);
                    
                    admissible_set = find(start_times >= task_start+task_length && ...
                        start_times <= round(check_iterator*(L-(task_start+task_length))/max_chain_length));
                    
                    if ~isempty(admissible_set)
                        admissible_set = admissible_set+prev_indices(task_timeline);
                    end
                    
                    
                    
                else
                    admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && ...
                        starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
                end
                
                %%%%%%%%%%%
                
                if size(admissible_set,1) > 0
                    for it=1:size(admissible_set,1)
                        candidate = ConvertLongIndex(admissible_set(i));
                        dependencies_beginning_with = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
                        dependencies_ending_with = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
                        if size(dependencies_beginning_with,1)+size(dependencies_ending_with,1) >= 2
                            admissible_set = subtract_row(admissible_set,i);
                        end
                        
                    end
                    % Måste också subtrahera bort element som cur_task
                    % redan är beroende med.
                    
                else
                    bool = 1;
                    direction=2;
                end
                
                %%%%%%%%%%
            else
                if timeline_jumps == 1 || constrain == 1
                    
                else
                    
                end
            end
            
        else
            if first_pass == 1 && i <= Ntasks && size(tasks_left,1) > 0
                if timeline_jumps == 1 || constrain == 1
                    
                else
                    
                end
            else
                if timeline_jumps == 1 || constrain == 1
                    
                else
                    
                end
            end
            
        end
        
        
        
        if first_pass == 1 && i <= Ntasks && size(tasks_left,1) > 0
            % Hitta tasks som har högst en tidigare dependency.
            if constrain == 1
                
                task_start = cur_task(1);
                task_length = cur_task(2);
                task_timeline = cur_task(end);
                
                start_times = TimelineSolution{task_timeline}(:,1);
                
                admissible_set = find(start_times >= task_start+task_length && ...
                    start_times <= round(check_iterator*(L-(task_start+task_length))/max_chain_length));
                
                if ~isempty(admissible_set)
                    admissible_set = admissible_set+prev_indices(task_timeline);
                end
            else
                admissible_set = find(starting_times >= cur_task(1)+cur_task(2) && ...
                    starting_times <= round(check_iterator*(L-(cur_task(1)+cur_task(2)))/max_chain_length));
            end
            % subtrahera bort tasks med fler än ett beroende.
            if size(admissible_set,1) > 0
                for it=1:size(admissible_set,1)
                    candidate = ConvertLongIndex(admissible_set(i));
                    dependencies_beginning_with = find(ismember(DependencyMatrix(:,1:2),candidate,'rows'));
                    dependencies_ending_with = find(ismember(DependencyMatrix(:,3:4),candidate,'rows'));
                    if size(dependencies_beginning_with,1)+size(dependencies_ending_with,1) >= 2
                        admissible_set = subtract_row(admissible_set,i);
                    end
                    
                end
                % Måste också subtrahera bort element som cur_task
                % redan är beroende med.
                
            else
                bool = 1;
                direction=2;
            end
            
        else
            % här behöver vi inte subtrahera bort tasks med >2 beroenden.
            
            
            
        end
        
        if size(admissible_set,1) > size(currently_dependent_upon,1)
            bool =1;
        elseif check_iterator >= max_chain_length
            % Pröva att gå bakåt. Om inte ens det lyckas, gör
            % vanlig dependency.
            direction = 2;
            bool = 1;
        end
        
        
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
DependencyMatrix(all(DependencyMatrix==0,2),:)=[];

end

