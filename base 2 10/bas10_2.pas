program bas10_2;

procedure tableau( var nb : integer);
var 
    i: integer;
    tab : Array [1..4] of Integer;
begin
	for  i := 1 to 4  do;
        tab[i] := i;
end;


procedure conv10_2( var a : integer);
var 
    r, i : integer;
    tab : Array [1..4] of Integer;
begin
	if a < 16 then
	begin
        for i := 0 to 3 do
        begin
            tab[4-i] := a mod 2;
            a := a div 2;
        end;
        for i := 1 to 4 do
            write(tab[i]);
    end
    else
    begin
        writeln( 'le nombre est trop grand');
    end; 
end;

var
    a : integer;
begin
	readln(a);
	conv10_2(a);
end.
     