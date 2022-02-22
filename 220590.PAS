program cartelle1(input,output);
uses crt;

type
 posizione=array [1..12] of integer;
 range=1..3;
 cartella=array [1..12] of range;
 cartelle=array [1..5] of cartella;
var
 p:posizione;
 cart:cartelle;
 m:integer;
 n:string;
 flag:boolean;

procedure init;
var
 i,j:integer;
begin
 for i:=1 to 5 do
 for j:=1 to 12 do
 cart[i][j]:=random(3)+1;
end;

procedure print(c:cartelle);
var i,j:integer;
begin
 for i:=1 to 5 do
 begin
  writeln('Cartella nø',i);
  for j:=1 to 12 do
  write(c[i][j],' ');
  writeln;
 end
end;

function verifica_pos:integer;
var
 pos:integer;
 n:string;
begin
 write('Nome:');readln(n);
 if n='luisa' then pos:=1
 else if n='marco' then pos:=2
 else if n='luigi' then pos:=3
 else if n='enzo'  then pos:=4
 else if n='anna'  then pos:=5
 else if n='lucia' then pos:=6
 else if n='aldo'  then pos:=7
 else if n='lina'  then pos:=8
 else if n='elena' then pos:=9
 else if n='andrea'then pos:=10
 else if n='gino'  then pos:=11
 else if n='maria' then pos:=12
 else writeln('Nome non presente in elenco');
 verifica_pos:=pos;
end;

function esiste:boolean;
var
 i,j:integer;
 flag:boolean;
begin
 flag:=false;
 for i:=1 to 3 do
 begin
  p[i]:=verifica_pos;
  writeln('Posizione:',p[i]);
 end;
 for j:=1 to 5 do
 if (cart[j][p[1]]=cart[j][p[2]])
 and (cart[j][p[2]]=cart[j][p[3]]) then flag:=true;
 esiste:=flag;
end;

begin
 clrscr;
 writeln(' INIZIO PROGRAMMA CARTELLE ');
 init;
 print(cart);
 if esiste then
 writeln('Esistono cartelle ove i tre nomi sono associati allo stesso numero')
 else
 writeln('Non esistono cartelle ove i tre nomi sono associati allo stesso numero');
readln;
end.