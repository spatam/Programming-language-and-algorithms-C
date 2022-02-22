program stringhe(input,output);

uses crt;
type
 punt=^node;
 node=record
  info:char;
  next:punt;
 end;
var
 a,b:string;
 head,tail,lista:punt;
 n,l:integer;

procedure ins_coda(c:char;var head,tail:punt);
var node:punt;
begin
 new(node);
 node^.info:=c;
 node^.next:=nil;
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
end;

function count(a:string):integer;
var i:integer;
begin
 i:=1;
 while a[i]<>'.' do i:=i+1;
 count:=i-1;
end;

function normale(head:punt):boolean;
var
 flag:boolean;
 c:char;
begin
 flag:=true;
 while (head^.next<>nil) and (flag) do
 if head^.info<=head^.next^.info then head:=head^.next
 else flag:=false;
 normale:=flag;
end;

function pulisci(head:punt;elem:integer):punt;
var
 lista,tail:punt;
 i:integer;
begin
 lista:=nil;
 tail:=nil;
 i:=1;
 while head<>nil do
  begin
   if i<>elem then ins_coda(head^.info,lista,tail);
   i:=i+1;
   head:=head^.next;
  end;
 pulisci:=lista;
end;

procedure print(head:punt);
begin
 while head<>nil do
 begin
  write(head^.info);
  head:=head^.next;
 end;
 write(' ');writeln;
end;

function esamina(head:punt;n:integer;var l:integer):punt;
var
 max,i:integer;
 s,h,p,nodo:punt;
begin
 if normale(head) then
  begin
   s:=head;
   l:=n;
  end
 else
  begin
   max:=0;
   for i:=2 to n do
     begin
      nodo:=pulisci(head,i);
      p:=esamina(nodo,n-1,l);
      if l>max then
       begin
        max:=l;
        s:=p;
       end;
     end
  end;
 esamina:=s;
end;


procedure inser(a:string);
var i:integer;
begin
i:=1;
while a[i]<>'.' do
 begin
  ins_coda(a[i],head,tail);
  i:=i+1;
 end;
end;

begin {main program}
clrscr;
head:=nil;
tail:=nil;
lista:=nil;
write('Inserisci una stringa qualunque che finisca con un punto:');readln(a);
inser(a);
n:=count(a);
lista:=esamina(head,n,l);
write('Sottostringa normale massimale:');print(lista);
readln;
end.