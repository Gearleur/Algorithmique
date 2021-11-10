program Facture;

const
    TVA = 20/100;
    
procedure Entree(var PUHT, QTE, Remise, FrDP : real);
begin
	writeln( 'Prix untaire');
	readln ( PUHT);
	writeln('La quantit‚');
	readln( QTE);
	writeln('remise');
	readln( Remise);
	writeln ('Frais de port');
	readln ( FrDP);
end;


procedure CalcPHT(PUHT, QTE : real; var PHT: real);
begin
	PHT := PUHT * QTE;
end;


procedure CalcRemise ( PHT, Remise: real; var PrixRemise: real );
begin
	if PHT >    600 then
        PrixRemise := PHT*(Remise/100)
    else
    begin
    	PrixRemise := 0;
    end;
end;


function CalcFrDP (PHT, PrixRemise, FrDP: real; var PrixFraisDPort : real ) : real;
begin
	if PHT < 500 then
	begin
        if (PHT-PrixRemise)*(FrDP/100)< 20 then
        begin
        	PrixFraisDPort :=20;
        end
        else
        begin
            PrixFraisDPort := (PHT-PrixRemise)*(FrDP/100);
        end;
    end
    else
    begin
    PrixFraisDPort := 0;
    end;
end;



procedure CalcTVA(  PHT, PrixRemise, PrixFraisDPort: real; var PrixTVA: real);
begin
	PrixTVA :=  (PHT - PrixRemise + PrixFraisDPort)*TVA;
end;



procedure CalcPTTC( PHT,PrixRemise, PrixFraisDPort, PrixTVA: real; var PTTC: real);
begin
	PTTC := ( PHT - PrixRemise + PrixFraisDPort + PrixTVA);
end;



procedure DataProcess ( var PUHT, QTE, Remise, FrDP, PHT, PrixRemise, PrixFraisDPort, PrixTVA, PTTC : real );
begin
    CalcPHT ( PUHT, QTE, PHT );
    CalcRemise( PHT, Remise, PrixRemise);
	CalcFrDP ( PHT,PrixRemise, FrDP, PrixFraisDPort);
	CalcTVA( PHT, PrixRemise, PrixFraisDPort, PrixTVA);
	CalcPTTC( PHT, PrixRemise, PrixFraisDPort, PrixTVA, PTTC);
end;

procedure Factu( PHT, PrixRemise, PrixFraisDPort, PrixTVA, PTTC: real);
begin
	writeln ( 'Facture au nom de ');
	writeln ( PHT:0:2,' Prix hors taxe' );
	writeln ( '-', PrixRemise:0:2, ' REMISE');
	writeln ( '+' , PrixFraisDPort:0:2, ' Frais de port');
	writeln( '+', PrixTVA:0:2,' TVA');
	writeln('Prix toutes Taxes Comprises: ',PTTC:0:2);
end;

var
    PUHT : real;
    QTE : real;
    Remise : real;
    FrDP: real;
    PHT, PTTC, PrixRemise, PrixFraisDPort, PrixTVA: real;
BEGIN
	Entree(PUHT, QTE, Remise, FrDP );
	DataProcess ( PUHT, QTE, Remise, FrDP, PHT, PrixRemise, PrixFraisDPort, PrixTVA, PTTC );
    Factu ( PHT, PrixRemise, PrixFraisDPort, PrixTVA, PTTC );
END. 

