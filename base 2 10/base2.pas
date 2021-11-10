rogram base2;

function pow( a , i : integer) : longint;
var
    c: integer;
    s : longint;
begin
	if i = 0 then
        pow := 1
    else
    begin
        s := 1;
        for  c:=1 to i  do
            s := s*a;
        pow := s
    end;
end;


function transfbase2(var  a :longint) : longint;
var
    s: longint;
    i : integer;
begin
	i := 0;
	s:= 0;
	while ( a > 0) do
	begin
        s := s + ( a mod 2 )*pow( 10,i);
        i := i + 1;
        a := a div 2;
    end;
    transfbase2 := s
end;

var 
    a : longint;
begin
	readln ( a);
	writeln( transfbase2(a));
end.
    
        