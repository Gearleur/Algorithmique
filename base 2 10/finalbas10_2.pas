program finalbase10_2 ;

procedure Conv10_2_v1( nb: integer; var Tbin : array of integer ) ;
var
    Q, rest, ind: integer;
begin
	ind := length(Tbin)-1;
	repeat
        rest := nb mod 2;
        Q := nb div 2;
        Tbin[ind] := rest;
        ind := ind - 1;
        nb := Q;
    until ( Q = 0);
end;

procedure Raz_Tab(var Tb: array of integer) ;
var 
    cpt: integer;
begin
	//Tb := setlength(arr, nb) pour initialiser nautre tableau de nb colonnes)
	for cpt := 0 to length(Tb)-1 do
    	Tb[cpt] := 0;
end;

procedure Conv10_2_v2( nb: integer;var Tbin: array of integer);
var
    cpt, rest, Q: integer;
begin
	for cpt := length(Tbin)-1 downto 0 do
	begin
		rest := nb mod 2;
		Q := nb div 2;
		Tbin[cpt] := rest;
		nb := q;
	end;
end;

function Range_Ok(nb: integer): boolean;
var
    res: boolean;
begin
	res := nb< 16;
	Range_Ok := res;
end;

procedure affiche_tab(Tb: array of integer);
var
    cpt : integer;
begin
    for cpt := 0 to length(Tb)-1 do
    	write( Tb[cpt]);
    writeln('');
end;

procedure convInt_Bool(Tbin: array of integer; var Tb: array of boolean);
var
    cpt: integer;
begin
	for cpt:=0 to length(Tbin)-1 do
        Tb[cpt] := Tbin[cpt] = 1;
end;

function Nb_digit(nb: integer):integer;
var
    cpt, Q: integer;
begin
	cpt := 0;
	repeat
        Q := nb div 10;
        cpt := cpt + 1;
        nb := Q;
    until ( Q = 0 );
    Nb_digit := cpt
end;

var
     nb: integer;
     nDigit: integer;
     Tbin : array [1..5] of integer;
     Tb : array [1..5] of boolean;
begin
	nb := 14;
	if Range_Ok(nb) then
	begin
        writeln( 'Ok');
        nDigit := Nb_digit(nb);
        writeln(nDigit);
        Raz_Tab(Tbin);
        affiche_tab(Tbin);
        Conv10_2_v1(nb,Tbin);
        affiche_tab(Tbin);
        convInt_Bool(Tbin, Tb);
        affiche_tab(Tbin)
     end  
    else
        writeln('Pas ok');
end.
	
	


	








