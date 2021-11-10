program Tri;
    
procedure RandomTab(var Tab: array of integer);
var
    i : integer;
    r : integer;
begin
	randomize;
	for i := 0 to length(Tab)-1 do
	begin
		r := random(9);
		Tab[i] := r;
	end;
end;

procedure swap(var Tab: array of integer; i : integer);
var 
    temps: integer;
begin
    temps := Tab[i];
    Tab[i] := Tab[i+1];
    Tab[i+1] := temps;
end;
	

procedure TriBulleOpti( var Tab: array of integer);
var
    permut: boolean;
    i : integer;
begin
	permut := True;
	while permut = True do
	begin
        permut  :=False;
        for i := 0 to length(Tab)-2 do
        begin
            if Tab[i] > Tab[i+1] then
            begin
                swap(Tab, i);
            	permut := True;
            end;
        end;
    end;   
end;

procedure TriBulle(var Tab: array of integer);
var
    i, j: integer;
begin
	for i := 0 to length(Tab)-2 do
	begin
        for j := 0 to length(Tab)-i do
        begin
            if Tab[j] > Tab[j+1] then
            begin
            	swap(Tab,j);
            end;
        end;
    end;
end;  

procedure affiche_tab(Tb: array of integer);
var
    cpt : integer;
begin
    for cpt := 0 to length(Tb)-1 do
    	write( Tb[cpt]);
    writeln('');
end;

var
     Tab1 : array [0..9] of integer;
     Tab2 : array [0..9] of integer;
begin
	RandomTab(Tab1);
	affiche_tab(Tab1);
	TriBulleOpti(Tab1);
	affiche_tab(Tab1);
	RandomTab(Tab2);
	affiche_tab(Tab2);
	TriBulleOpti(Tab2);
	affiche_tab(Tab2);
end.