Program totocalcio(input,output);
uses crt;
type
 segno=array [1..3] of char;
 colonna=array[1..13] of char;

 elem=record
  pro:segno;  { pronostici }
  n:integer;  { numero pronostici }
 end;

 schedina= array [1..13] of elem;

var
 s:schedina;
 r:segno;
 c:colonna;
 i,j,n,punt:integer;

function risultati(i:integer):char;
var
 p:string;
begin
 write(i,'ø risultato: (es.4-0) -> ');readln(p);
 if p[1]>p[3] then risultati:='1'
 else if p[1]<p[3] then risultati:='2'
                   else risultati:='x';
end;

procedure tripla(var i,acc:integer;var flag:boolean);
begin
 acc:=acc+1;
 if acc<=2 then
 begin
  writeln(i,'ø partita');
  write('1ø pronostico ');readln(s[i].pro[1]);
  write('2ø pronostico ');readln(s[i].pro[2]);
  write('3ø pronostico ');readln(s[i].pro[3]);
  s[i].n:=3;
  flag:=true;
 end
 else writeln('Non si possono inserire pi— di due triple !');
end;

procedure doppia(var i,acc:integer;var flag:boolean);
begin
 acc:=acc+1;
 if acc<=4 then
 begin
  writeln(i,'ø partita');
  write('1ø pronostico ');readln(s[i].pro[1]);
  write('2ø pronostico ');readln(s[i].pro[2]);
  s[i].n:=2;
  flag:=true;
 end
 else writeln('Non si possono inserire pi— di quattro doppie !');
end;

procedure fissa(i:integer;var flag:boolean);
begin
  write(i,'ø partita:');
  readln(s[i].pro[1]);
  s[i].n:=1;
  flag:=true;
end;

procedure pronostico;
var
 car:char;
 acct,accd:integer;
 i:integer;
 flag:boolean;
begin
 acct:=0;
 accd:=0;
 for i:=1 to 13 do
  repeat
    flag:=false;
    write('Fissa,doppia,tripla ? (f/d/t)');readln(car);
    case car of
     't' :tripla(i,acct,flag);
     'd' :doppia(i,accd,flag);
     'f' :fissa(i,flag);
     else writeln('errore')
    end
  until flag
end;

function verifica(c:colonna):boolean;
var
 flag:boolean;
 l:integer;
begin
 punt:=0;
 flag:=false;
 for i:=1 to 13 do
 for l:=1 to s[i].n do
 if c[i]=s[i].pro[l] then punt:=punt+1;
 if punt>=12 then flag:=true;
 verifica:=flag;
end;

begin {main program}
clrscr;
 for i:=1 to 13 do
 c[i]:=risultati(i);
 write('Quanti pronostici vuoi realizzare ? ');readln(n);
 for j:=1 to n do
 begin
  pronostico;
  if verifica(c) then
  begin
   writeln('Vincita di 1ø o 2ø categoria');
   writeln('Il ',j,'ø pronostico realizza ',punt,' punti');
  end
  else
  begin
   writeln('Nessuna vincita realizzata');
   writeln('Il ',j,'ø pronostico realizza ',punt,' punti');
  end
 end;
readln;
end.