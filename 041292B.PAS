program elenco1(input,output);

uses crt;

type
 punt=^node;
 node=record
  nome:string;
  eta:integer;
  h:integer;
  next:punt;
 end;

var
 head:punt;
 na:string;
 e,a,n,num:integer;

procedure push(na:string;e,a:integer;var head:punt);
var node:punt;
begin
 new(node);
 node^.nome:=na;
 node^.eta:=e;
 node^.h:=a;
 node^.next:=head;
 head:=node;
end;{push}

function pop(var head:punt):punt;
var
x:punt;
begin
 x:=head;
 head:=head^.next;
 x^.next:=nil;
 pop:=x;
end;{pop}

procedure insert(na:string;e,a:integer;var head:punt);
begin
 if head=nil then push(na,e,a,head)
 else if na<head^.nome then push(na,e,a,head)
 else if na>head^.nome then insert(na,e,a,head^.next);
end;{insert}

procedure print(head:punt);
begin
 while (head<>nil) do
  begin
   writeln;
   write('Nome ->',head^.nome,';');
   write('Eta''->',head^.eta,';') ;
   write('Altezza ->',head^.h,';');
   writeln;
   head:=head^.next;
  end
end;{print}

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
  end
end;{ins_coda1}

function merge1(node1,node2:punt):punt;
var head,tail,nodo:punt;
begin
  head:=nil;
  tail:=nil;
  while (node1<>nil) and (node2<>nil) do
  if (node1^.eta<node2^.eta) then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  while (node1<>nil) do
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end;
  while (node2<>nil) do
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  merge1:=head;
end;{merge}

procedure spezza(c:integer;head:punt;var s1,s2:punt);
var i:integer;
begin
 s1:=head;
 if c>1 then for i:=1 to c-1 do head:=head^.next;
 s2:=head^.next;
 head^.next:=nil;
end;{spezza}

function merge2(node1,node2:punt):punt;
var head,tail,nodo:punt;
begin
  head:=nil;
  tail:=nil;
  while (node1<>nil) and (node2<>nil) do
  if (node1^.h<node2^.h) then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  while (node1<>nil) do
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end;
  while (node2<>nil) do
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  merge2:=head;
end;{merge2}

function merge3(node1,node2:punt):punt;
var head,tail,nodo:punt;
begin
  head:=nil;
  tail:=nil;
  while (node1<>nil) and (node2<>nil) do
  if (node1^.nome<node2^.nome) then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  while (node1<>nil) do
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end;
  while (node2<>nil) do
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  merge3:=head;
end;{merge3}

function merge_sort(s,x:integer;head:punt):punt;
var c:integer;
    s1,s2:punt;
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
   end
  end;
end;{merge_sort}

procedure fine;
begin
 writeln('Termine momentaneo');
end;

begin {main program}
 clrscr;
 head:=nil;
 n:=0;
 repeat
 clrscr;
 writeln('1 Inserimento persone ');
 writeln('2 Stampa lista in ordine alfabetico');
 writeln('3 Stampa elenco ordinato per eta''');
 writeln('4 Stampa elenco ordinato per altezza');
 writeln('5 Fine');
 writeln;
 write('Inserisci una scelta per il menu ->');readln(num);
 case num of
  1:begin
     n:=n+1;
     writeln;
     write('Nome: ');readln(na);
     write('Eta :');readln(e);
     write('Altezza: ');readln(a);
     insert(na,e,a,head);
    readln;
    end;
  2:begin
     head:=merge_sort(3,n,head);
     writeln('****Stampa lista crescente ordinata per ordine alfabetico**** ');
     print(head);
     readln;
    end;
  3:begin
     head:=merge_sort(1,n,head);
     writeln('****Stampa lista decrescente ordinata per ordine di eta*** ');
     print(head);
     readln;
    end;
  4:begin
     head:=merge_sort(2,n,head);
     writeln('****Stampa lista decrescente ordinata per ordine di altezza****');
     print(head);
     readln;
    end;
  5:fine;
 end;
 until num=5;
readln;
end.
