program indagine(input,output);

uses crt;

const
 max=3;

type
 categ=(a,b,c,d);
 persona=record
  co:string;
  st:categ;
  se:categ;
  et:categ;
  al:categ;
 end;

 vettore=array [1..max] of persona;

var
 v:vettore;
 car,ses:char;
 e,i,num,eta1,alt:integer;
 sta,cog:string;

function leggi_stato(sta:string):categ;
var
 s:categ;
 car:char;
begin
 car:=sta[1];
 case car of
  'c':s:=a;
  'v':s:=b;
  's':s:=c;
  'd':s:=d;
 else writeln('***Errore***')
 end;
 leggi_stato:=s;
end;{leggi_stato}

function leggi_sesso(ses:char):categ;
var
 s:categ;
begin
 case ses of
  'm':s:=a;
  'f':s:=b;
 else writeln('***Errore***')
 end;
 leggi_sesso:=s;
end;{leggi_sesso}

function leggi_altezza(alt:integer):categ;
var
 h:categ;
begin
 if (alt<161) then h:=a
 else if (alt<=170) then h:=b
 else if (alt<=180) then h:=c
 else h:=d;
 leggi_altezza:=h;
end;{leggi_altezza}

function leggi_eta(e:integer):categ;
var
 et:categ;
begin
 if (e<21) then et:=a
 else if (e<=40) then et:=b
 else if (e<=60) then et:=c
 else et:=d;
 leggi_eta:=et;
end;{leggi_eta}

Procedure stampa_eta(et:categ);
begin
 case et of
  a:writeln('Categoria "a" fino a 20 anni');
  b:writeln('Categoria "b" fino a 40 anni');
  c:writeln('Categoria "c" fino a 60 anni');
  d:writeln('Categoria "d" oltre  60 anni');
 end
end;{stampa_eta}

Procedure stampa_sesso(se:categ);
begin
 case se of
  a:writeln('Categoria "a" sesso maschile ');
  b:writeln('Categoria "b" sesso femminile');
 end
end;{stampa_sesso}

Procedure stampa_altez(h:categ);
begin
 case h of
  a:writeln('Categoria "a" fino a 161 cm');
  b:writeln('Categoria "b" fino a 170 cm');
  c:writeln('Categoria "c" fino a 180 cm');
  d:writeln('Categoria "d" oltre  180 cm');
 end
end;{stampa_altez}

Procedure stampa_stato(st:categ);
begin
 case st of
  a:writeln('Categoria "a" celibe');
  b:writeln('Categoria "b" vedovo');
  c:writeln('Categoria "c" sposato');
  d:writeln('Categoria "d" divorziato');
 end
end;{stampa_stato}

Procedure print(elem:persona);
begin
 writeln('Cognome ->',elem.co);
 stampa_eta(elem.et);
 stampa_sesso(elem.se);
 stampa_altez(elem.al);
 stampa_stato(elem.st);
 writeln;
end;{print}

procedure uguali(s:vettore;n:integer);
var
 i,j:integer;
begin
 for i:=1 to (n-1) do
  for j:=i+1 to n do
   begin
    if (s[i].et=s[j].et) and
       (s[i].al=s[j].al) and
       (s[i].se=s[j].se) and
       (s[i].st=s[j].st) then
     begin
      print(s[i]);
      print(s[j]);
     end
   end;
end;{uguali}

begin {main program}
 for i:=1 to max do
  begin
   clrscr;
   writeln('Inserimento dati ',i,' persona: ');
   write('Cognome: ');readln(v[i].co);
   with v[i] do
    begin
     write('Eta: ');readln(eta1);
     et:=leggi_eta(eta1);
     write('Sesso (m/f): ');readln(ses);
     se:=leggi_sesso(ses);
     write('Altezza: ');readln(alt);
     al:=leggi_altezza(alt);
     write('Stato civile ("v":vedovo "c":celibe "s":sposato "d":divorziato): ');
     readln(sta);
     st:=leggi_stato(sta);
    end
  end;
 writeln;
 writeln('Stampa delle persone che appartengono alla stessa categoria');
 uguali(v,max);
readln;
end.










