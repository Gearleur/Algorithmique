program finalbase10_2 ;

const 
    Tmax = 4;
type 
    t_Tab = array [0..Tmax-1] of integer;
    t_TabBool = array [0..Tmax-1] of boolean;
        
procedure Conv10_2_v1( nb: integer; var Tbin : t_Tab) ;
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

procedure Raz_Tab(var Tb: t_Tab) ;
var 
    cpt: integer;
begin
	//Tb := setlength(arr, nb) pour initialiser nautre tableau de nb colonnes)
	for cpt := 0 to length(Tb)-1 do
    	Tb[cpt] := 0;
end;

procedure Conv10_2_v2( nb: integer;var Tbin: t_Tab);
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

procedure affiche_tab(Tb: t_Tab);
var
    cpt : integer;
begin
    for cpt := 0 to length(Tb)-1 do
    	write( Tb[cpt]);
    writeln('');
end;

procedure affiche_tabBool(Tb: t_TabBool);
var
    cpt : integer;
begin
    for cpt := 0 to length(Tb)-1 do
    	write( Tb[cpt],' ');
    writeln('');
end;

function convInt_Bool(Tbin: t_Tab; var Tb:  t_TabBool): t_TabBool;
var
    cpt: integer;
begin
	for cpt:=0 to length(Tbin)-1 do
        Tb[cpt] := Tbin[cpt] = 1;
    convInt_Bool := Tb;
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
    Nb_digit := cpt;
end;

var
     nb: integer;
     nDigit: integer;
     Tbin : t_Tab;
     Tb :  t_TabBool;
begin
	writeln('Entrer un nombre');
	readln(nb);
	if Range_Ok(nb) then
	begin
        writeln( 'Ok');
        nDigit := Nb_digit(nb);
        writeln(nDigit);
        Raz_Tab(Tbin);
        affiche_tab(Tbin);
        Conv10_2_v1(nb,Tbin);
        affiche_tab(Tbin);
        Tb := convInt_Bool(Tbin, Tb);
        affiche_tabBool(Tb)
     end  
    else
        writeln('Pas ok');
end.