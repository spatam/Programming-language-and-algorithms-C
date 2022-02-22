program elenco(input,output);

uses crt;

type
 punt=^node;
 node=record
  nome:string;
  eta:integer;
  h:integer;
  nextalf:punt;
  nexteta:punt;
  nextalt:punt;
 end;

var
 head1,head2,head3:punt;
 na:string;
 n,e,a,j,x,num:integer;
 nodo:punt;

function getnode(na:string;e,a:integer):punt;
var node:punt;
begin
 new(node);
 node^.nome:=na;
 node^.eta:=e;
 node^.h:=a;
 node^.nextalf:=nil;
 node^.nexteta:=nil;
 node^.nextalt:=nil;
 getnode:=node;
end;{push}

procedure insert1(node:punt;var head:punt);
begin
 if head=nil then head:=node
 else if node^.nome<head^.nome then
                                 begin
                                   node^.nextalf:=head;
                                   head:=node
                                 end
 else if node^.nome>head^.nome then insert1(node,head^.nextalf);
end;{insert1}

procedure insert2(node:punt;var head:punt);
begin
 if head=nil then head:=node
 else if node^.eta<head^.eta then
                              begin
                               node^.nexteta:=head;
                               head:=node
                              end
 else if node^.eta>head^.eta then insert2(node,head^.nexteta);
end;{insert2}

procedure insert3(node:punt;var head:punt);
begin
 if head=nil then head:=node
 else if node^.h<head^.h then
                          begin
                           node^.nextalt:=head;
                           head:=node
                          end
 else if node^.h>head^.h then insert3(node,head^.nextalt);
end;{insert3}

procedure print(n:integer;head:punt);
begin
 while (head<>nil) do
  begin
   write('Nome ',head^.nome);
   write(' Eta ',head^.eta);
   write(' Altezza ',head^.h);
   writeln;
   case n of
    1:head:=head^.nextalf;
    2:head:=head^.nexteta;
    3:head:=head^.nextalt;
   end
  end
end;{print}

procedure fine;
begin
 writeln('Termine momentaneo');
end;

begin {main program}
 clrscr;
 head1:=nil;
 head2:=nil;
 head3:=nil;
 repeat
 writeln('1 Inserimento elenco persone ');
 writeln('2 Stampa lista con ordinamento alfabetico');
 writeln('3 Stampa ordinamento persone per eta''');
 writeln('4 Stampa ordinamento persone per altezza ');
 writeln('5 Fine');
 writeln;
 write('Inserisci una scelta per il menu ->');readln(num);
 case num of
  1:begin
     write('Quante persone ? ');readln(x);
     for j:=1 to x do
      begin
       writeln;
       write('Nome:');readln(na);
       write('Eta:');readln(e);
       write('Altezza:');readln(a);
       nodo:=getnode(na,e,a);
       insert1(nodo,head1);
       insert2(nodo,head2);
       insert3(nodo,head3);
      end;
    end;
  2:begin
     writeln('****Stampa lista ordinata per ordine alfabetico**** ');
     print(1,head1);
     writeln;
    end;
  3:begin
     writeln('****Stampa lista ordinata per ordine di eta**** ');
     print(2,head2);
     writeln;
    end;
  4:begin
     writeln('****Stampa lista ordinata per ordine di altezza**** ');
     print(3,head3);
     writeln;
    end;
  5:fine;
 end;
 until num=5;
readln;
end.
