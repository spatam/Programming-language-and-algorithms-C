Program numeri_primi(s,output);
uses crt;
type
 punt1=^node1;
 node1=record
  info:integer;
  next:punt1;
 end;
 punt2=^node2;
 node2=record
  info:punt1;
  next:punt2;
 end;
var
 s,m:text;
 k:integer;
 head,lista:punt1;
 headlist:punt2;

procedure push(n:integer;var head:punt1);
var
 node:punt1;
begin
 new(node);
 node^.info:=n;
 node^.next:=head;
 head:=node
end;

procedure insert(n:integer;var head:punt1);
begin
 if head=nil then push(n,head)
 else if n<head^.info then push(n,head)
 else if n>head^.info then insert(n,head^.next);
end;

procedure ins_coda(node:punt1;var head,tail:punt1);
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

function primo(p:integer):boolean;
var
 i:integer;
 flag:boolean;
begin
 i:=2;flag:=false;
 while (i<=(p/2)) and not flag do
 if (p mod i)=0 then flag:=true
 else i:=i+1;
 if flag then primo:=false
 else writeln('ATTENZIONE il numero:',p,' Š primo');
end;

function multipli(p:integer):punt1;
var
 head:punt1;
 num:integer;
begin
 head:=nil;
 reset(m);
 while not eof(m) do
  begin
   readln(m,num);
   if (num mod p)=0 then insert(num,head);
  end;
 multipli:=head;
end;

procedure print(head:punt1);
begin
 while head<>nil do
  begin
   write(head^.info,',');
   head:=head^.next;
  end;
end;

procedure insertlist(head:punt1;var headlist:punt2);
var
 node:punt2;
begin
 new(node);
 node^.info:=head;
 node^.next:=headlist;
 headlist:=node;
end;

procedure init;
var
 p:integer;
begin
 assign(s,'dati');
 assign(m,'dati');
 reset(s);
 for p:=2 to k do
  begin
   if primo(p) then
    begin
     head:=multipli(p);
     write('Lista crescente multipli di ',p,' ->');print(head);
     insertlist(head,headlist);
     writeln;
    end;
  end;
end;

function pop(var head:punt1):punt1;
var node:punt1;
begin
 node:=head;
 head:=head^.next;
 node^.next:=nil;
 pop:=node;
end;

function merge(node1,node2:punt1):punt1;
var head,tail,nodo:punt1;
begin
 head:=nil;
 tail:=nil;
 while (node1<>nil) and (node2<>nil) do
 if (node1^.info<node2^.info) then
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
 while(node2<>nil) do
  begin
   nodo:=pop(node2);
   ins_coda(nodo,head,tail);
  end;
 merge:=head;
end;

function immersione(headlist:punt2):punt1;
var
 lista:punt1;
 node:punt2;
begin
 lista:=nil;
 node:=headlist;
 while node<>nil do
  begin
   lista:=merge(node^.info,lista);
   node:=node^.next;
  end;
 immersione:=lista;
end;

begin {main program}
clrscr;
headlist:=nil;
write('Inserisci un numero intero k>=2 :');readln(k);
init;
lista:=immersione(headlist);
write('Immersione delle liste in una unica:');print(lista);
readln;
end.
