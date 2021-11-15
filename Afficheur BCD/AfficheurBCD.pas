program AfficheurBCD;

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
    write('Chiffre � afficher : ');
    readln(chiffre);
    writeln('Coordoon�es du coin Haut-Gauche :');
    write('x = ');
    readln(x);
    write('y = ');
    readln(y);
    writeln();
    write('Zoom :');
    readln(z);
end;    


function Taille_Ok(nb: integer): boolean;
var
    res: boolean;
begin
	res := (nb >=0) AND (nb < 10) ;
	Taille_Ok := res;
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


procedure PosX(x : integer);
var
    cpt : integer;
begin
    for cpt:= x downto 1 do
        write (' ');
end;


procedure PosY(y : integer);
var
    cpt : integer;
begin
    for cpt:= y downto 1 do
        writeln();
end;


procedure AfficherHorizontal(Segment : boolean; x, z : integer);
var
  cpt : integer;
begin
    PosX(x+1);
    if Segment then
        for cpt:= z+3+(z div 2) downto 1 do write ('*')
    else
        for cpt:= z+3+(z div 2) downto 1 do write (' ');
    writeln();
end;


procedure AfficherVertical(SegmGauche, SegmDroit : boolean; x,z : integer);
var
    cpt,cpt2 : integer;
begin
    for cpt:= z+1 downto 1 do
    begin
        if SegmGauche then 
        begin
            PosX(x);
            write ('*');
            if SegmDroit then begin
                for cpt2:= z+3+(z div 2) downto 1 do write(' ');
                write('*');
            end;
            writeln();
        end
        else if SegmDroit then begin
            PosX(x);
            for cpt2:= z+4+(z div 2) downto 1 do write(' ');
            writeln('*');
        end;
    end;
end;


procedure Affichage(var TSegmBool : t_TabSegm_Bool; x, y, zoom : integer);
const
    A=0; B=1; C=2; D=3; E=4; F=5; G=6;
begin
    PosY(y);
    AfficherHorizontal(TSegmBool[A], x, zoom);
    AfficherVertical(TSegmBool[F], TSegmBool[B], x, zoom);
    AfficherHorizontal(TSegmBool[G], x, zoom);
    AfficherVertical(TSegmBool[E], TSegmBool[C], x, zoom);
    AfficherHorizontal(TSegmBool[D], x, zoom);
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
    if Taille_Ok(chiffre) then begin
        Raz_Tab(Tbin);
        Conversion_DecBin(chiffre, TBin);
        Conv_BinBool(Tbin, Tbool);
        Eq_Karnaugh(Tbool, TSegmBool);
        Affichage(TSegmBool, x, y, zoom);
    end
    else writeln('Chiffre Invalide');
end.