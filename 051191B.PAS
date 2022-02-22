program archivio(input,output);

uses crt;

type
 punt=^node;
 node=record
  titolo:string;
  autore:string;
  ramo  :string;
  numero:integer;
  next:punt;
 end;

var
 lista:punt;
 num:integer;

procedure push(t,a,r:string;n:integer;var head:punt);
var node:punt;
begin
 new(node);
 node^.titolo:=t;
 node^.autore:=a;
 node^.ramo:=r;
 node^.numero:=n;
 node^.next:=head;
 head:=node;
end;

function pop(var head:punt):punt;
var node:punt;
begin
 node:=head;
 head:=head^.next;
 node^.next:=nil;
 pop:=node;
end;

procedure ins_coda(node:punt;var head,tail:punt);
begin
 if head=nil then
  begin
   head:=node;
   tail:=node;
  end
 else
  begin
   tail^.next:=node;
   tail:=node;
  end;
end;

function merge1(node1,node2:punt):punt;
var
 head,tail,nodo:punt;
begin
 head:=nil;
 tail:=nil;
 while (node1<>nil) and (node2<>nil) do
  if node1^.titolo<node2^.titolo then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
 while node1<>nil do
  begin
   nodo:=pop(node1);
   ins_coda(nodo,head,tail);
  end;
 while node2<>nil do
  begin
   nodo:=pop(node2);
   ins_coda(nodo,head,tail);
  end;
 merge1:=head;
end;

function merge2(node1,node2:punt):punt;
var
 head,tail,nodo:punt;
begin
 head:=nil;
 tail:=nil;
 while (node1<>nil) and (node2<>nil) do
  if node1^.autore<node2^.autore then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
 while node1<>nil do
  begin
   nodo:=pop(node1);
   ins_coda(nodo,head,tail);
  end;
 while node2<>nil do
  begin
   nodo:=pop(node2);
   ins_coda(nodo,head,tail);
  end;
 merge2:=head;
end;

function merge3(node1,node2:punt):punt;
var
 head,tail,nodo:punt;
begin
 head:=nil;
 tail:=nil;
 while (node1<>nil) and (node2<>nil) do
  if node1^.ramo<node2^.ramo then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
 while node1<>nil do
  begin
   nodo:=pop(node1);
   ins_coda(nodo,head,tail);
  end;
 while node2<>nil do
  begin
   nodo:=pop(node2);
   ins_coda(nodo,head,tail);
  end;
 merge3:=head;
end;

function merge4(node1,node2:punt):punt;
var
 head,tail,nodo:punt;
begin
 head:=nil;
 tail:=nil;
 while (node1<>nil) and (node2<>nil) do
  if node1^.numero<node2^.numero then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
 while node1<>nil do
  begin
   nodo:=pop(node1);
   ins_coda(nodo,head,tail);
  end;
 while node2<>nil do
  begin
   nodo:=pop(node2);
   ins_coda(nodo,head,tail);
  end;
 merge4:=head;
end;

procedure spezza(c:integer;head:punt;var s1,s2:punt);
var i:integer;
begin
 s1:=head;
 if c>1 then for i:=1 to c-1 do head:=head^.next;
 s2:=head^.next;
 head^.next:=nil;
end;

function merge_sort(s,x:integer;head:punt):punt;
var c:integer;s1,s2:punt;
begin
 if x<=1 then merge_sort:=head
 else
  begin
   c:=(x div 2);
   spezza(c,head,s1,s2);
   s1:=merge_sort(s,c,s1);
   s2:=merge_sort(s,x-c,s2);
   case s of
    1:merge_sort:=merge1(s1,s2);
    2:merge_sort:=merge2(s1,s2);
    3:merge_sort:=merge3(s1,s2);
    4:merge_sort:=merge4(s1,s2);
   end
  end
end;

procedure print(head:punt);
begin
 while head<>nil do
 begin
  write('Titolo:',head^.titolo,' ');
  write('Autore:',head^.autore,' ');
  write('Ramo scientifico:',head^.ramo,' ');
  write('Numero serie:',head^.numero,' ');
  head:=head^.next;
 end;
 writeln;
end;

procedure init(var lista:punt);
var
 n,i:integer;
 t,r,a:string;
begin
 lista:=nil;
 writeln('PROGRAMMA BIBLIOTECA ');
 writeln('******************** ');
 write('Quanti volumi vuoi inserire ? ');readln(num);
 for i:=1 to num do
  begin
   write('Titolo ',i,'ø volume:');readln(t);
   write('Autore ',i,'ø volume:');readln(a);
   write('Ramo scientifico ',i,'ø volume:');readln(r);
   write('Numero ',i,'ø volume:');readln(n);
   writeln;
   push(t,r,a,n,lista);
  end;
end;

begin {main program}
clrscr;
 init(lista);
 writeln('Stampa "at MUZZU "');
 print(lista);writeln;
 writeln('Stampa lista ordinata per ordine alfabetico titolo:');
 lista:=merge_sort(1,num,lista);
 print(lista);writeln;
 writeln('Stampa lista ordinata per ordine alfabetico autore:');
 lista:=merge_sort(2,num,lista);
 print(lista);writeln;
 writeln('Stampa lista ordinata per ordine alfabetico ramo scientifico:');
 lista:=merge_sort(3,num,lista);
 print(lista);writeln;
 writeln('Stampa lista ordinata per ordine crescente numero serie:');
 lista:=merge_sort(4,num,lista);
 print(lista);writeln;
readln;
end.