program liste(input,output);

type
 punt=^node;
 node=record
  info:integer;
  next:punt;
 end;

vettore= array [1..10] of punt;
var
 lista:punt;
 a:vettore;
 i,j,num,n,x,y,t:integer;

procedure push(x:integer;var h:punt);
var newnode:punt;
begin
 new(newnode);
 newnode^.info:=x;
 newnode^.next:=h;
 h:=newnode;
end;{push}

procedure pop(var x:integer;var h:punt);
var node:punt;
begin
 node:=h;
 h:=node^.next;
 x:=node^.info;
 dispose(node);
end;{pop}

function search(x:integer;h:punt):punt;
var node:punt; flag:boolean;
begin
 flag:=false;
 node:=h;
 while (node<>nil) do
  begin
   if node^.info=x then flag:=true
                   else node:=node^.next;
  end;
 if flag then writeln('Numero trovato')
         else writeln('Numero non trovato');
 search:=node;
end;{search}

procedure insert(x:integer;var h:punt);{inserimento con rel. di ord. (<)}
begin
 if h=nil then push(x,h)
          else if x<h^.info then push(x,h)
          else if x>h^.info then insert(x,h^.next);
end;{insert}
procedure print(h:punt);
var node:punt;
begin
 writeln;
 node:=h;
 while (node<>nil) do
  begin
   write(node^.info);
   node:=node^.next;
   if node=nil then writeln('.') else write(',');
  end;
end;{print}

procedure swap(var a,b:integer);
var x:integer;
begin
 x:=a;
 a:=b;
 b:=x;
end;{swap}

procedure bubble_sort(a:vettore;n:integer);
var i,j:integer;
begin
 for j:=n-1 downto 1 do
  for i:=1 to j do
   if a[i]^.info>a[i+1]^.info then swap(a[i]^.info,a[i+1]^.info);
end;{bubble_sort}

procedure fine;
begin
 writeln('Termine momentaneo utilizzo');
end;{fine}

begin{main program}
 repeat
  writeln('Inserisci un numero per la scelta del seguente menu'' ');
  writeln('1)Inserimento liste');
  writeln('2)Inserimento numero in lista');
  writeln('3)Stampa  lista');
  writeln('4)Fine');
  readln(num);
  case num of
   1:begin
      write('Digitare il numero di liste da inserire');readln(n);
      for i:=1 to n do
       begin
        a[i]:=nil;
        writeln('Inserire la ',i,' lista di numeri interi');
        writeln;
        write('Quanti numeri?');readln(y);
        for t:=1 to y do
         begin
          write('Inserire un numero intero prego');
          readln(x);
          insert(x,a[i]);
         end;
       end;
     end;
   2:begin
      write('Digitare in quale delle "i" liste inserire il numero "j" ');
      readln(i);
      write('Digitare il numero "j" ');readln(j);
      insert(j,a[i]);
     end;
   3:begin
      writeln('Stampa delle "i" liste ------>');
      bubble_sort(a,n);
      for i:=1 to n do print(a[i]);
     end;
   4:fine;
 end;
 until num=4;
readln;
end.

