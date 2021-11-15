program DECODEUR_BCD_final;

Uses Crt;

const 
    TMax = 4;
    nSegm = 7;
type 
    t_Tab_Int_dyn_Int = array [0..TMax-1] of integer;
    t_Tab_Int_dyn_Bool = array [0..TMax-1] of boolean;
    t_Tab_Int_dynSegm_Bool = array [0..nSegm-1] of boolean;
    t_Tab_Int_dyn = array of Integer;


(***************************FS1***************************)

// LIRE
// A.T. - J.V. 2021-11-15
// Lit le nombre à afficher et les paramètres de coordoonées et de zoom
// IN: -NONE- (variables 'vides' à remplir)
// OUT: nombre, x, y, z
procedure Lire(var nombre : longint; var x, y, z : integer);
begin
    write('Nombre a afficher : ');
    readln(nombre);
    writeln('Coordonnees du coin Haut-Gauche :'); 
    write('x = ');
    readln(x);
    write('y = ');
    readln(y);
    writeln();
    write('Zoom :');
    readln(z);
end;    


(***************************FS2***************************)

// Raz_Tab_nb
// A.T. - J.V. 2021-11-15
// Initialisation à 0 des cases d'un tableau dynamique d'entiers
// IN: taille, Tb
// OUT: Tb
procedure Raz_Tab_nb(taille : integer; var Tb: t_Tab_Int_dyn) ;
var 
    cpt: integer;
begin
	for cpt := 0 to taille-1 do
    	Tb[cpt] := 0;
end;


// cpt_NBchiffres
// A.T. - J.V. 2021-11-15
// Fonction retournant le nombre de chiffres d'un entier long
// IN: nb
// OUT: cpt_NBchiffres = cpt
function cpt_NBchiffres(nb : longint) : integer;
var
    cpt : integer;
begin
    cpt := 0;
    while nb <> 0 do begin
        nb := nb div 10;rest
        cpt := cpt + 1;
    end;
    cpt_NBchiffres := cpt;
end;


// Conv_nombre_tableau
// A.T. - J.V. 2021-11-15
// Remplit un tableau dynamique initialisé avec les différents chiffres du nombre
// IN: nb, taille, Tnombre
// OUT: Tnombre
procedure Conv_nombre_tableau( nb : longint; taille: integer; var Tnombre : t_Tab_Int_dyn) ;
var
    Q : longint;
    rest, cpt: integer;
begin
	cpt := taille-1;
	repeat
        rest := nb mod 10;
        Q := nb div 10;
        Tnombre[cpt] := rest;
        cpt := cpt - 1;
        nb := Q;
    until ( Q = 0);
end;


// Nombre_MAIN
// A.T. - J.V. 2021-11-15
(*// Fonction Principale du service lié au nombre, allouant dynamiquement la mémoire nécessaire au tableau de chiffres
du nombre, et gérant les appels aux fils ci-dessus dont cpt_NBchiffres, Raz_tab_nb et Conv_nombre_tableau *)
// IN: nombre, Tnombre
// OUT: Tnombre, Nombre_MAIN = taille
function Nombre_MAIN(nombre : longint; var Tnombre : t_Tab_Int_dyn) : integer;
var
    taille : integer;
begin
    taille:=cpt_NBchiffres(nombre);
    SetLength(Tnombre, taille);
    Raz_tab_nb(taille, Tnombre);
    Conv_nombre_tableau( nombre, taille, Tnombre) ;
    Nombre_MAIN:=taille;
end;


(***************************FS3***************************)

// Raz_Tab_bin
// A.T. - J.V. 2021-11-15
// Initialisation à 0 des cases d'un tableau d'entiers binaires
// IN: taille, Tb
// OUT: Tb
procedure Raz_Tab_bin(taille : integer; var Tb: t_Tab_Int_dyn_Int) ;
var 
    cpt: integer;
begin
	for cpt := 0 to taille-1 do
    	Tb[cpt] := 0;
end;


// Raz_Tab_bin
// A.T. - J.V. 2021-11-15
// Initialisation à 0 des cases d'un tableau d'entiers binaires
// IN: taille, Tb
// OUT: Tb
procedure Conversion_DecBin( nb: longint; var Tbin: t_Tab_Int_dyn_Int);
var
    cpt, reste: integer;
begin
	for cpt := TMax-1 downto 0 do
	begin
		reste := nb mod 2;
		nb := nb div 2;
		Tbin[cpt] := reste;
	end;
end;


// Conv_BinBool
// A.T. - J.V. 2021-11-15
// Remplit un tableau de booleens en fonction d'un tableau d'entiers binaires, 1 donne VRAI, 0 donne FAUX
// IN: Tbin, Tbool
// OUT: Tbool
procedure Conv_BinBool(var Tbin: t_Tab_Int_dyn_Int; var Tbool:  t_Tab_Int_dyn_Bool);
var
    cpt: integer;
begin
	for cpt:=0 to length(Tbin)-1 do
        Tbool[cpt] := Tbin[cpt] = 1;
end;


// Eq_Karnaugh
// A.T. - J.V. 2021-11-15
// Remplit un tableau de booleens en fonction des valeurs d'un autre tableau de booleens selon des equations de Karnaugh
// IN: Tbool, TSegmBool
// OUT: TSegmBool
procedure Eq_Karnaugh(var Tbool : t_Tab_Int_dyn_Bool; var TSegmBool : t_Tab_Int_dynSegm_Bool);
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


// AfficherHorizontal
// A.T. - J.V. 2021-11-15
// Affiche une barre horizontale aux coordoonées en paramètres si le booleen en paramètre est VRAI, et incrémente la coordoonées y dans tous les cas
// IN: Segment, x, y, z
// OUT: y
procedure AfficherHorizontal(var Segment : boolean; var x, y, z : integer);
var
  cpt : integer;
begin
    gotoXY(x+1, y);
    if Segment then
        for cpt:= z+3+(z div 2) downto 1 do write ('*');
    y := y+1;
end;


// AfficherVertical
// A.T. - J.V. 2021-11-15
// Affiche 1 ou 2 barres verticales aux coordoonées voulues selon les booleens en paramètres
// IN: SegmGauche, SegmDroit, x, y, z
// OUT: y
procedure AfficherVertical(var SegmGauche, SegmDroit : boolean; var x, y, z : integer);
var
    cpt : integer;
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


// Affichage
// A.T. - J.V. 2021-11-15
// Appelle ses procédures filles AfficherHorizontal et AfficherVertical pour afficher les 7 segments
// IN: TSegmBool, x, y, zoom
// OUT: -NONE-
procedure Affichage(var TSegmBool : t_Tab_Int_dynSegm_Bool; var x, y, zoom : integer);
const
    A=0; B=1; C=2; D=3; E=4; F=5; G=6;
begin
    AfficherHorizontal(TSegmBool[A], x, y, zoom);
    AfficherVertical(TSegmBool[F], TSegmBool[B], x, y, zoom);
    AfficherHorizontal(TSegmBool[G], x, y, zoom);
    AfficherVertical(TSegmBool[E], TSegmBool[C], x, y, zoom);
    AfficherHorizontal(TSegmBool[D], x, y, zoom);
end;


// Chiffre_MAIN
// A.T. - J.V. 2021-11-15
(*// Fonction Principale du service chiffre par chiffre, appelant ses procédures filles (Raz_Tab_bin, Conversion_DecBin, Conv_BinBool, Eq_Karnaugh, Affichage) qui (ré)initialisent le tableau d'entiers binaires, convertissent
le chiffre en binaire, puis en tableau de booleens, avant de vérifier quels segments afficher grâce aux equations de Karnaugh, et enfin les afficher *)
// IN: taille, Tnombre, Tbin, Tbool, TSegmBool, x, y, zoom
// OUT: -NONE-
procedure Chiffre_MAIN(taille: integer; var Tnombre : t_Tab_Int_dyn; var Tbin :  t_Tab_Int_dyn_Int; var Tbool : t_Tab_Int_dyn_Bool; var TSegmBool : t_Tab_Int_dynSegm_Bool; var x, y, zoom: integer );
var
    cpt, a , b: integer;
begin
    ClrScr;
    GotoXY(1,1);
	for cpt := 0 to taille-1 do
	begin
	    a := x;
        b := y;
        Raz_Tab_bin(TMax,Tbin);
        Conversion_DecBin(Tnombre[cpt], TBin);
        Conv_BinBool(Tbin, Tbool);
        Eq_Karnaugh(Tbool, TSegmBool);
        Affichage(TSegmBool, a, b, zoom);
        x := x+ zoom +7+(zoom div 2);
        GotoXY(x ,y);
    end;
    GotoXY(1, 2*(zoom+1)+4);
end;



(********************Programme Principal********************)
// Programme Principal
// A.T. - J.V. 2021-11-15
(*// Programme Principal appelant ses 3 fils direct pour respectivement : 
    -lire le nombre et les paramètres d'affichage,
    -découper le nombre en chiffres pour les traiter séparément
    -pour chaque chiffre, le convertir en binaire et afficher les segments selon des équations de Karnaugh *)
var
    nombre : longint;
    taille, x , y, zoom : integer;
    Tbin : t_Tab_Int_dyn_Int;
    Tbool : t_Tab_Int_dyn_Bool;
    TSegmBool : t_Tab_Int_dynSegm_Bool;
    Tnombre : t_Tab_Int_dyn;

begin
    Lire(nombre, x, y, zoom);
    taille := Nombre_MAIN(nombre, Tnombre);
    Chiffre_MAIN(taille, Tnombre, Tbin, Tbool, TSegmBool, x, y, zoom); 
    SetLength(Tnombre, 0);
end.