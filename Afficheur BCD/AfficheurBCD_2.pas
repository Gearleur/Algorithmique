program DecodeurBCD_7Segments;

Uses Crt;

const 
    TMax = 4;
    nSegm = 7;
type 
    t_Tab_Int = array [0..TMax-1] of integer;
    t_Tab_Bool = array [0..TMax-1] of boolean;
    t_TabSegm_Bool = array [0..nSegm-1] of boolean;
    t_Tab = array [0..TMax-1] of integer;


procedure Lire(var chiffre, x, y, z : integer);
begin
    write('Chiffre … afficher : ');
    readln(chiffre);
    writeln('Coordoon‚es du coin Haut-Gauche :');
    write('x = ');
    readln(x);
    write('y = ');
    readln(y);
    writeln();
    write('Zoom :');
    readln(z);
end;    

procedure Conv10_10( nb: integer; var Tnombre : t_Tab) ;
var
    Q, rest, ind: integer;
begin
	ind := length(Tnombre)-1;
	repeat
        rest := nb mod 2;
        Q := nb div 2;
        Tnombre[ind] := rest;
        ind := ind - 1;
        nb := Q;
    until ( Q = 0);
end;


procedure Raz_Tab(var Tb: t_Tab_Int) ;
var 
    cpt: integer;
begin
	for cpt := 0 to length(Tb)-1 do
    	Tb[cpt] := 0;
end;


procedure Conversion_DecBin( nb: integer;var Tbin: t_Tab_Int);
var
    cpt, reste: integer;
begin
	for cpt := length(Tbin)-1 downto 0 do
	begin
		reste := nb mod 2;
		nb := nb div 2;
		Tbin[cpt] := reste;
	end;
end;


function Conv_BinBool(var Tbin: t_Tab_Int; var Tbool:  t_Tab_Bool): t_Tab_Bool;
var
    cpt: integer;
begin
	for cpt:=0 to length(Tbin)-1 do
        Tbool[cpt] := Tbin[cpt] = 1;
    Conv_BinBool := Tbool;
end;


procedure Eq_Karnaugh(var Tbool : t_Tab_Bool; var TSegmBool : t_TabSegm_Bool);
const
    A=0; B=1; C=2; D=3; E=4; F=5; G=6;
begin
    TSegmBool[A] := Tbool[A] OR Tbool[C] OR (Tbool[B] AND Tbool[D]) OR (NOT Tbool[A] AND NOT Tbool[B] AND NOT Tbool[D]);
    TSegmBool[B] := NOT Tbool[B] OR (Tbool[C] AND Tbool[D]) OR (NOT Tbool[C] AND NOT Tbool[D]);
    TSegmBool[C] := Tbool[B] OR Tbool[D] OR NOT Tbool[C];
    TSegmBool[D] := Tbool[A] OR (Tbool[C] AND NOT Tbool[D]) OR (NOT Tbool[B] AND Tbool[C]) OR (NOT Tbool[B] AND NOT Tbool[D]) OR (Tbool[B] AND NOT Tbool[C] AND Tbool[D]);
    TSegmBool[E] := (Tbool[C] AND NOT Tbool[D]) OR (NOT Tbool[B] AND NOT Tbool[D]);
    TSegmBool[F] := Tbool[A] OR (Tbool[B] AND NOT Tbool[C]) OR (Tbool[B] AND NOT Tbool[D]) OR (NOT Tbool[C] AND NOT Tbool[D]);
    TSegmBool[G] := Tbool[A] OR (NOT Tbool[C] AND Tbool[B]) OR (Tbool[C] AND (NOT (Tbool[B] AND Tbool[D])));
end;




procedure AfficherHorizontal(Segment : boolean; x, y, z : integer);
var
  cpt : integer;
  a : integer;
begin
	a := x;
	if Segment then
        for cpt:= z+3+(z div 2) downto 1 do
        begin
            a := a + 1;
            GotoXY( a, y);
            write ('*')
        end;
end;


procedure AfficherVertical(Segment : boolean; x, y,z : integer);
var
  cpt : integer;
  b : integer;
begin
	b := y;
    for cpt:= z+3+(z div 2) downto 1 do
    begin
        b := b + 1;
        GotoXY( x, b);
        write ('*')
    end;
end;


procedure Affichage(var TSegmBool : t_TabSegm_Bool; x, y, zoom : integer);
const
    A=0; B=1; C=2; D=3; E=4; F=5; G=6;
var
    k, l, i, j, V: integer;
begin
	V := 5;
	k := x;
	l := y +7;
	i := 0;
    GotoXY(x, l);
    while i <> 5 do ;
    begin
        GotoXY(x+1, l);
        AfficherHorizontal(TSegmBool[i], x, l, zoom);
    	l := l+zoom+1;
        i :=round(6 - (i/2));
        writeln(i);
    end;
    l := y +7;
    for i := 0 to  1 do
    begin
        for j := 0 to 1 do
            begin
                GotoXY(x, l+1);
                AfficherHorizontal(TSegmBool[V], x, l, zoom);
                l := l+1;
                i :=round(6 + (i/2));
                V := V - 1;
            end;
        l := y +7;  
        GotoXY  ( x + zoom, l  );
        V := V -1;
        i := 1;
    end;   	          
end;




(*************************Programme Principal*************************)

var
    chiffre, x , y, zoom : integer;
    Tbin : t_Tab_Int;
    Tbool : t_Tab_Bool;
    TSegmBool : t_TabSegm_Bool;
    Tnombre : t_Tab;

begin
    Lire(chiffre, x, y, zoom);
    Raz_Tab(Tbin);
    Conversion_DecBin(chiffre, TBin);
    Conv_BinBool(Tbin, Tbool);
    Eq_Karnaugh(Tbool, TSegmBool);
    Affichage(TSegmBool, x, y, zoom);
end.