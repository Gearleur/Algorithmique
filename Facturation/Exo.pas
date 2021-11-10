program TVA;

function exo( PUHT ,QTE : real ) : real;
var
 PTTC, TVA, PHT, FDP, REMISE: real;
 begin
 	REMISE := (1+10/100);
 	FDP := (1+10/100);
 	PHT := PUHT*QTE ;
 	TVA := (1+20/100);
 	if PHT > 1000 then
        PTTC := PHT*TVA*REMISE;
    if PHT*TVA<500 then
        if PHT*FDP-PHT< 20 then
        begin
            FDP := 20;
            PTTC := (PHT+FDP)*TVA;
            writeln( FDP :0:3);
        end
        else
        begin
            FDP := (1+10/100);
            PTTC := PHT*TVA*FDP ;
            writeln( PHT*FDP- PHT :0:3);
        end;
     if PHT*TVA >=150 then
        PTTC := PHT*TVA;
    writeln (PTTC : 0: 3);
    writeln (PHT : 0: 3);
    exo := PTTC;
end;

var
    PUHT : real;
    QTE : real;
    a : real;
BEGIN
	readln ( PUHT, QTE);
    EXO( PUHT, QTE);
END.    