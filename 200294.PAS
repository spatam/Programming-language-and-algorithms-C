Program testo1(s,output);
uses CRT;
type
 stringa=array[1..50] of char;

 punt=^node;
 node=record
  info:stringa;
  next:punt
 end;

var
 testo:punt;
 p,p1:string;
 ris:char;
 occ,i,num:integer;

procedure ins_coda(x:stringa;var head,tail:punt);
var nodo:punt;
begin
 new(nodo);
 nodo^.info:=x;
 nodo^.next:=nil;
 if head=nil then
  begin
   head:=nodo;
   tail:=nodo;
  end
 else
  begin
   tail^.next:=nodo;
   tail:=nodo;
  end
end;{ins_coda}

function uguali(a:string;b:stringa):boolean;
var flag:boolean;
    i:integer;
begin
 flag:=true;
 i:=1;
 while (a[i]<>'.') and (flag) do
  if a[i]<>b[i] then flag:=false
  else i:=i+1;
 uguali:=flag;
end;{uguali}

function search(p:string;testo:punt):integer;
var i:integer;
begin
 i:=0;
 while (testo<>nil) do
  begin
   if uguali(p,testo^.info) then i:=i+1;
   testo:=testo^.next
  end;
  search:=i
end;{search}

procedure copia(a:string;var b:stringa);
var i:integer;
begin
 i:=1;
 while a[i]<>'.' do
   begin
    b[i]:=a[i];
    i:=i+1;
   end;
 b[i]:='.'
end;{copia}

procedure assimila_testo(var testo:punt);
var i:integer;
    s:text;
    car:char;
    parola:stringa;
    finetesto:punt;
begin
 finetesto:=nil;testo:=nil;
 assign(s,'dati.dat');
 reset(s);
 i:=0;
 while (not eof(s)) do
  begin
   read(s,car);
   if car in ['a'..'z'] then
    begin
     i:=i+1;
     parola[i]:=car
    end
   else
    if i<>0 then
     begin
      parola[i+1]:='.';
      ins_coda(parola,testo,finetesto);
      i:=0;
     end;
   end;
end;{assimila_testo}

procedure sostituzione(p,p1:string;testo:punt);
begin
 while (testo<>nil) do
  begin
   if uguali(p,testo^.info) then copia(p1,testo^.info);
   testo:=testo^.next
  end;
end;{sostituzione}

procedure scrivi(a:stringa);
var i:integer;
begin
 i:=1;
 while a[i]<>'.' do
  begin
   write(a[i]);
   i:=i+1;
  end;
 write(' ');
end;

procedure print_testo(head:punt);
var node:punt;
begin
 node:=head;
 while (node<>nil) do
  begin
   scrivi(node^.info);
   node:=node^.next;
  end;
writeln;
end;{print_testo}

procedure fine;
begin
 writeln('Termine momentaneo programma');
end;{fine}

begin{main program}
 assimila_testo(testo);
 repeat
 clrscr;
 writeln('1 Inserimento parola da ricercare nel testo');
 writeln('2 Stampa testo');
 writeln('3 Sostituzione parola nel testo');
 writeln('4 Fine');
 writeln;
 write('Inserire una scelta per il menu'' ');readln(num);
 writeln;
 case num of
  1:begin
     write('Inserisci la parola da ricercare che finisca con un punto ->');
     readln(p);
     occ:=search(p,testo);
     writeln('Le occorenze di ',p,' sono ',occ);
     readln;
    end;
  2:begin
     print_testo(testo);
     readln;
    end;
  3:begin
     write('Vuoi sostituire la parola selezionata? (s/n)');readln(ris);
     if ris='s' then
      begin
       write('Digita la parola che finisca con un punto ');
       write('con cui sostituire ',p,' ->');readln(p1);
       sostituzione(p,p1,testo);
       { write(s);  }
      end
     else writeln('Nessuna sostituzione effettuata');
     readln;
    end;
  4:fine;
 end;
 until num=4;
 readln;
end.