program AfficheurBCD_3;

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

procedure RazX_Tab(var Tb: t_Tab) ;
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

procedure Conv10_2_v1( nb: integer; var Tnombre : t_Tab) ;
var
    Q, rest, ind: integer;
begin
	ind := length(Tnombre)-1;
	repeat
        rest := nb mod 10;
        Q := nb div 10;
        Tnombre[ind] := rest;
        ind := ind - 1;
        nb := Q;
    until ( Q = 0);
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


procedure AfficherHorizontal(var Segment : boolean; var x, y, z : integer);
var
  cpt : integer;
begin
    gotoXY(x+1, y);
    if Segment then
        for cpt:= z+3+(z div 2) downto 1 do write ('*');
    y := y+1;
end;


procedure AfficherVertical(var SegmGauche, SegmDroit : boolean; var x, y, z : integer);
var
    cpt,cpt2 : integer;
begin
    for cpt:= z+1 downto 1 do
    begin
        if SegmGauche then 
        begin
            gotoXY(x,y);
            write ('*');
            if SegmDroit then begin
                gotoXY( x+z+3+(z div 2)+1, y);
                write('*');
            end;
        y := y + 1;
        end
        else if SegmDroit then begin
            gotoXY(x, y);
            gotoXY( x+z+4+(z div 2),y);
            writeln('*');
            y := y+1;
        end;
    end;
end;


procedure Affichage(var TSegmBool : t_TabSegm_Bool; var x, y, zoom : integer);
const
    A=0; B=1; C=2; D=3; E=4; F=5; G=6;
begin
    y := y +7;
    AfficherHorizontal(TSegmBool[A], x, y, zoom);
    AfficherVertical(TSegmBool[F], TSegmBool[B], x, y, zoom);
    AfficherHorizontal(TSegmBool[G], x, y, zoom);
    AfficherVertical(TSegmBool[E], TSegmBool[C], x, y, zoom);
    AfficherHorizontal(TSegmBool[D], x, y, zoom);
    
end;

procedure AfficheNombre(chiffre: integer; var Tnombre : t_Tab; var Tbin :  t_Tab_Int; var Tbool : t_Tab_Bool; var TSegmBool : t_TabSegm_Bool; var x, y, zoom: integer );
var
    j , i, a , b: integer;
begin
	for j := 0 to 3 do
	begin
        a := x;
        b := y;
        Raz_Tab(Tbin);
        Conversion_DecBin(Tnombre[j], TBin);
        Conv_BinBool(Tbin, Tbool);
        Eq_Karnaugh(Tbool, TSegmBool);
        Affichage(TSegmBool, a, b, zoom);
        x := x+ zoom +7+(zoom div 2);
        GotoXY(x ,y);
    end;
end;



(*************************Programme Principal*************************)

var
    chiffre, x , y, zoom : integer;
    Tbin : t_Tab_Int;
    Tbool : t_Tab_Bool;
    TSegmBool : t_TabSegm_Bool;
    Tnombre : t_Tab;
    j : integer;

begin
    Lire(chiffre, x, y, zoom);
    RazX_tab(Tnombre);
    Conv10_2_v1( chiffre, Tnombre) ;
    AfficheNombre(chiffre, Tnombre, Tbin, Tbool, TSegmBool, x, y, zoom); 
end.