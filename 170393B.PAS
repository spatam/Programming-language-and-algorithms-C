program indagine(input,output);
uses crt;
const
 max=4;
type
 punt=^node;
 node=record
  eta:char;
  alt:char;
  ses:char;
  eta1:integer;
  alt1:integer;
  sta:string;
  next:punt;
 end;
var
 lista,lista1:punt;
 e,h:integer;
 s:char;
 sc:string;

procedure push(e,s,h:char;e1,h1:integer;sc:string;var head:punt);
var node:punt;
begin
 new(node);
 node^.eta:=e;
 node^.eta1:=e1;
 node^.alt:=h;
 node^.alt1:=h1;
 node^.ses:=s;
 node^.sta:=sc;
 node^.next:=head;
 head:=node;
end;

function uguali(node,node1:punt):boolean;
begin
  if (node^.eta=node1^.eta) and
           (node^.alt=node1^.alt) and
           (node^.ses=node1^.ses) and
           (node^.sta=node1^.sta) then uguali:=true
  else uguali:=false;
end;

function verifica(head:punt):punt;
var node,node1,list:punt;
begin
 list:=nil;
 node:=head;
 while node^.next<>nil do
  begin
    node1:=node^.next;
    while node1<>nil do
      begin
       if uguali(node,node1) then
         begin
           push(node^.eta,node^.ses,node^.alt,node^.eta1,node^.alt1,node^.sta,list);
           push(node1^.eta,node1^.ses,node1^.alt,node1^.eta1,node1^.alt1,node1^.sta,list);
         end;
       node1:=node1^.next;
      end;
     node:=node^.next;
  end;
 verifica:=list;
end;

function cat_eta(x:integer):char;
begin
 if x<21 then cat_eta:='a'
 else if (x>=21) and (x<=40) then cat_eta:='b'
 else if (x>=41) and (x<=60) then cat_eta:='c'
 else cat_eta:='d';
end;

function cat_alt(x:integer):char;
begin
 if x<161 then cat_alt:='a'
 else if (x>=161) and (x<=170) then cat_alt:='b'
 else if (x>=171) and (x<=180) then cat_alt:='c'
 else cat_alt:='d';
end;

procedure init(var lista:punt);
var
 i:integer;
 stat:string;
 cat1,cat2:char;
begin
 lista:=nil;
 for i:=1 to max do
  begin
   writeln;
   writeln('Dati ',i,'ø persona:');
   write('Et…:');readln(e);
   cat1:=cat_eta(e);
   write('Sesso(m/f):');readln(s);
   write('Altezza:');readln(h);
   cat2:=cat_alt(h);
   write('Stato civile:');readln(sc);
   push(cat1,s,cat2,e,h,sc,lista);
  end;
end;

procedure print(head:punt);
begin
 while head<>nil do
  begin
   writeln;
   write('Et…:',head^.eta1,' ');
   write('Sesso:',head^.ses,' ');
   write('Altezza:',head^.alt1,' ');
   write('Stato civile:',head^.sta,' ');
   head:=head^.next;
  end;
end;

begin{main program}
clrscr;
 lista1:=nil;
 writeln('PROGRAMMA DI INDAGINE STATISTICA ');
 writeln('******************************** ');
 init(lista);
 lista1:=verifica(lista);
 if lista1<>nil then
  begin
   writeln;
   write('Persone che appartengono a stesse categorie:');
   print(lista1)
  end
 else writeln('Non esistono persone che hanno risposto allo stesso modo a tutti e quattro i quesiti.');
 readln;
end.