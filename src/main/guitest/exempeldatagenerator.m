clear;

N=100000000; %uppl�sningen p� tidsaxeln.

Ntasks = 100;

Ntimelines = 10;

space_param = 20;

x=0;

NumberoftasksinTimelinevector = [];

while x==0
    numbers_vector = sort(randi(Ntasks,Ntimelines-1,1));
    NumberoftasksinTimelinevector = [numbers_vector(1); diff(numbers_vector); Ntasks-numbers_vector(end)];
    if min(NumberoftasksinTimelinevector) > floor(Ntasks/Ntimelines/3) % godtyckligt satt f.n.
        x=1;
    end
end

x=0;

% Starttider och l�ngder f�r tasks. 
% vill ha vilken tidslinje varje task m�ste ligga p�.

% Starttider och sluttider f�r tasks, skillnaden ger l�ngden f�r varje
% task. B�dda in timeline ocks�?
total_start_vector = [];
total_end_vector = [];
timeline_vector = [];

for i=1:Ntimelines
    start_time_vector = [];
    end_time_vector = [];
    time_line_vector = [time_line_vector; i*ones(NumberoftasksinTimelinevector,1)];
    first_start_time = randi(space_param+1,1,1)-1;
    last_end_time = randi(space_param+1,1,1)-1+N-space_param;
    
    while x==0

        end_time_vector = [first_start_time; ...
            randi(N,NumberoftasksinTimelinevector(i)-first_start_time-last_end_time,1)-1+first_start_time; ...
            last_end_time];
        end_time_vector = sort(end_time_vector);
        
        % Generera starttider och sluttider. Separat p� n�got s�tt.
        
        if min(diff(end_time_vector))>space_param && end_time_vector(1) > space_param && end_time_vector(end-1) < N-space_param % godt. satt
            x=1;
        end
        
        
    end
    x=0;
    % G�r en starttidsvektor.
    while x==0
        for j=1:length(start_time_vector)-1
            end_time_vector = [];
        end
        end_time_vector = [end_time_vector last_end_time];
        
    end
    
    % De ovanst�ende looparna m�ste relateras till varandra! Hur ska vi
    % j�mf�ra tiderna till varandra.
    
    
    
    x=0;
    total_start_vector = [total_start_vector; start_time_vector];
end



% Slumpa fram starttider medelst annan f�rdelning


% Slumpa fram deadlines och tidigaste starttider, trivialt

% Slumpa fram beroenden, kan bli litet sv�rare.

