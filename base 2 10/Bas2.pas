program base22;

function bas2( var a : integer) : string;
var 
    s, t: string[100] ;
    r: integer;
begin
	while ( a > 0) do
	begin
		r := a mod 2;
        str(r, t );
        s := t + s;
        a := a div 2;
    end;
    bas2 := s;
end;

var
    a : integer;
begin
	readln(a);
	writeln( bas2(a));
end.