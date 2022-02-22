program garage(input,output);

uses crt;
const max=10;
type
punt=^node;
node=record
 n,count:integer;
 next:punt;
end;
var
 num,nt,co,pl:integer;
 car:char;
 lista,nodo:punt;

procedure push(nt,co:integer;var head:punt);
var newnode:punt;
begin
 new(newnode);
 newnode^.n:=nt;
 newnode^.count:=co;
 newnode^.next:=head;
 head:=newnode;
end;{push}

procedure pop(var nt,co:integer;var head:punt);
var node:punt;
begin
 node:=head;
 head:=head^.next;
 nt:=node^.n;
 co:=node^.count;
 dispose(node);
end;{pop}

function search(nt:integer;head:punt):punt;
var node:punt; flag:boolean;
begin
 flag:=false;
 node:=head;
 while (node<>nil) and (not flag) do
  if (node^.n=nt) then flag:=true
  else node:=node^.next;
  if flag then writeln('L''automobile si trova in garage')
          else writeln('L''automobile non si trova in garage');
  search:=node;
end;{search}

procedure print(h:punt);
begin
 writeln;
 while h<>nil do
 begin
  writeln('Auto in garage --> ',h^.n,' numero movimenti -> ',h^.count);
  h:=h^.next;
 end;
 readln;
end;{print}

procedure par(var lista:punt);
var lista1:punt;
    targa,mov:integer;
begin
 lista1:=nil;
 writeln('Automobile in partenza');
 write('Inserirne la targa :');readln(nt);
 while (lista<>nil) and (nt<>lista^.n) do  {SVUOTAMENTO }
  begin
   pop(targa,mov,lista);
   push(targa,mov+1,lista1);
  end;
 if (lista=nil) then writeln('macchina inesistente .. CRETINO !!')
 else
  begin
    co:=co-1;
    pop(targa,mov,lista);
    writeln('Numero targa auto uscita :',targa,' nø movimenti',mov);
  end;
 while lista1<>nil do
  begin
   pop(targa,mov,lista1);
   push(targa,mov,lista);
  end;
end;{par}

procedure fine;
begin
 writeln('Termine momentaneo');
end;{fine}

begin {main program}
 lista:=nil;
 co:=0;
 repeat
  clrscr;
  writeln('1)Inserimento auto');
  writeln('2)Partenza auto');
  writeln('3)Ricerca auto ');
  writeln('4)Stampa lista auto in garage');
  writeln('5)Fine');
  write('Introduci una scelta per il menu''-> ');
  readln(num);
  case num of
  1:begin
     if co=max then writeln('Attenzione posti esauriti')
     else
       begin
        co:=co+1;
        write('Inserimento auto per arrivo :');
        write('Inserirne il numero di targa :');readln(nt);
        push(nt,0,lista);
        pl:=max-co;
        writeln('Attenzione  il numero di posti liberi e'': ',pl);
      end;
    readln;
    end;
  2:begin
     par(lista);
     readln;
    end;
  3:begin
     write('Inserire la targa dell'' auto da ricercare: ');readln(nt);
     nodo:=search(nt,lista);
     writeln('movimenti macchina ',nodo^.count);
     readln;
    end;
  4:print(lista);
  5:fine;
  end;
 until num=5;
readln;
end.










