program liste(input,output);

uses crt;

const
 max=3;

type
 punt=^node;
 node=record
  info:integer;
  next:punt;
 end;
 vettore=array [1..max] of punt;

var
 v:vettore;
 lista:punt;
 i,j:integer;

procedure push(x:integer;var head:punt);
var node:punt;
begin
 new(node);
 node^.info:=x;
 node^.next:=head;
 head:=node;
end;

procedure insert(x:integer; var head:punt);
begin
 if head=nil then push(x,head)
 else if x<head^.info then push(x,head)
 else if x>head^.info then insert(x,head^.next);
end;

procedure print(head:punt);
begin
 while head<>nil do
  begin
   write(head^.info,' ');
   head:=head^.next;
  end;
end;

procedure init(var lista:punt;var v:vettore);
var i,j,m,num:integer;
begin
 for i:=1 to max do
  begin
   v[i]:=nil;
   lista:=nil;
   writeln('Inserisci la ',i,'ø lista :');
   write('Quanti numeri inserire ? ');readln(m);
   for j:=1 to m do
    begin
     write(j,'ø Numero:');readln(num);
     insert(num,v[i]);
    end;
  end;
end;

begin{ main program }
 clrscr;
 init(lista,v);
 writeln;
 writeln('Inserisci una coppia di numeri interi:');
 write('Numero "i":');readln(i);
 write('Numero "j":');readln(j);
 insert(j,v[i]);
 for i:=1 to max do
  begin
   writeln;
   write('Stampa ',i,'ø lista -->');
   print(v[i]);
   writeln;
  end;
 readln;
end.

