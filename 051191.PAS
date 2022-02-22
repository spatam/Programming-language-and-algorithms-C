program biblioteca(input,output);
uses crt;
type
 tree=^node;
 node=record
  titolo:string;
  autore:string;
  ramo:string;
  numero:integer;
  next_t:tree;
  next_a:tree;
  next_r:tree;
  next_n:tree;
 end;

var
 num,m,i,nu:integer;
 head1,head2,head3,head4:tree;
 nodo:tree;
 ti,au,ra:string;

function getnode(t,a,r:string;n:integer):tree;
var
 node:tree;
begin
 new(node);
 node^.titolo:=t;
 node^.autore:=a;
 node^.ramo:=r;
 node^.numero:=n;
 node^.next_t:=nil;
 node^.next_r:=nil;
 node^.next_n:=nil;
 getnode:=node;
end;

procedure insert1(node:tree;var head:tree);
begin
 if head=nil then head:=node
 else if node^.titolo<head^.titolo then
 begin
  node^.next_t:=head;
  head:=node;
 end
 else insert1(node,head^.next_t);
end;

procedure insert2(node:tree;var head:tree);
begin
 if head=nil then head:=node
 else if node^.autore<head^.autore then
 begin
  node^.next_a:=head;
  head:=node;
 end
 else insert2(node,head^.next_a);
end;

procedure insert3(node:tree;var head:tree);
begin
 if head=nil then head:=node
 else if node^.ramo<head^.ramo then
 begin
  node^.next_r:=head;
  head:=node;
 end
 else if node^.ramo>head^.ramo then insert3(node,head^.next_r)
 else { volumi con lo stesso ramo }
   if node^.titolo<head^.titolo then
   begin
    node^.next_r:=head;
    head:=node;
   end
 else insert3(node,head^.next_r);
end;

procedure insert4(node:tree;var head:tree);
begin
 if head=nil then head:=node
 else if node^.numero<head^.numero then
 begin
  node^.next_n:=head;
  head:=node;
 end
 else insert4(node,head^.next_n);
end;

procedure print(n:integer;head:tree);
begin
 while head<>nil do
 begin
  writeln;
  write('Titolo:',head^.titolo);
  write(' Autore:',head^.autore);
  write(' Ramo scientifico:',head^.ramo);
  write(' Numero di archivio:',head^.numero);
  case n of
  1:head:=head^.next_t;
  2:head:=head^.next_a;
  3:head:=head^.next_r;
  4:head:=head^.next_n;
  end
 end
end;

begin{main program}
 head1:=nil;
 head2:=nil;
 head3:=nil;
 head4:=nil;
 repeat
 clrscr;
 writeln;
 writeln('1* Inserimento dati volume');
 writeln('2* Elenco alfabetico titoli dei volumi');
 writeln('3* Elenco alfabetico autori dei volumi');
 writeln('4* Elenco alfabetico rami scientifici dei volumi');
 writeln('5* Elenco numeri di archivio dei volumi');
 writeln('6* Fine ');
 writeln;
 write('Inserisci una scelta sul seguente men— ');readln(num);
 case num of
  1:begin
     write('Quanti volumi vuoi inserire ? ');readln(m);
     for i:=1 to m do
     begin
      write('Titolo:');readln(ti);
      write('Autore:');readln(au);
      write('Ramo  :');readln(ra);
      write('Numero:');readln(nu);
      writeln;
      nodo:=getnode(ti,au,ra,nu);
      insert1(nodo,head1);
      insert2(nodo,head2);
      insert3(nodo,head3);
      insert4(nodo,head4);
     end;
    readln;
    end;
  2:begin
     writeln;
     writeln('***Stampa lista volumi ordine alfabetico titoli***');
     print(1,head1);
    readln;
    end;
  3:begin
     writeln;
     writeln('***Stampa lista volumi ordine alfabetico autori***');
     print(2,head2);
    readln;
    end;
  4:begin
     writeln;
     writeln('***Stampa lista volumi ordine alfabetico rami scientifici***');
     print(3,head3);
    readln;
    end;
  5:begin
     writeln;
     writeln('***Stampa lista volumi in ordine numerico***');
     print(4,head4);
    readln;
    end;
  6:writeln('Fine della procedura ');
 end;
 until num=6;
end.
