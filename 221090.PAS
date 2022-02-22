program aeroporto(input,output);

type
 punt=^node;
 node=record
  nome,ora,dest:string;
  lista_c,lista_n:string;
  posti_d,posti_p,pass_acc:integer;
  next:punt;
 end;

var
 lista,lista1,lista2,n1,n2:punt;
 num,i,q:integer;
 n,o,d,l,l1:string;
 pd,pp,pa:integer;
 car:char;

procedure push(n,o,d:string;pd,pp,pa:integer;var head:punt);
var
 newnode:punt;
 begin
  new(newnode);
  newnode^.nome    :=n;
  newnode^.ora     :=o;
  newnode^.dest    :=d;
  newnode^.posti_d :=pd;
  newnode^.posti_p :=pp;
  newnode^.pass_acc:=pa;
  newnode^.next    :=head;
  head:=newnode;
 end;{push}

procedure push1(l,l1:string;var head:punt);
var
 newnode:punt;
 begin
  new(newnode);
  newnode^.lista_c :=l;
  newnode^.lista_n :=l1;
  newnode^.next    :=head;
  head:=newnode;
 end;{push1}

procedure pop(var n,o,d:string;var pd,pp,pa:integer;var head:punt);
var
 node:punt;
 begin
  node:=head;
  head:=head^.next;
  n:=node^.nome;
  o:=node^.ora;
  d:=node^.dest;
  pd:=node^.posti_d;
  pp:=node^.posti_p;
  pa:=node^.pass_acc;
  dispose(node);
 end;{pop}

procedure pop1(var l,l1:string;var head:punt);
var
 node:punt;
 begin
  node:=head;
  head:=head^.next;
  l:=node^.lista_c;
  l1:=node^.lista_n;
  dispose(node);
 end;{pop1}

function search(n,o,d:string;pd,pp,pa:integer;head:punt):punt;
var
 node:punt;
 flag:boolean;
begin
 flag:=false;
 node:=head;
 if head=nil then writeln('Elementi non esistenti sulla lista')
 else while (node<>nil) and (not flag) do
 if (node^.nome=n) and (node^.ora=o) and (node^.dest=d)  and
  (node^.posti_d=pd) and (node^.posti_p=pp) and (node^.pass_acc=pa)
 then flag:=true
 else node:=node^.next;
 if flag then writeln('Elementi riscontrati sulla lista')
         else writeln('Elementi non riscontrati sulla lista');
 search:=n1;
end;{search}

function search1(l,l1:string;head:punt):punt;
var
 node:punt;
 flag:boolean;
begin
 flag:=false;
 node:=head;
 if head=nil then writeln('Elementi non esistenti sulla lista')
 else while (node<>nil) and (not flag) do
 if (node^.lista_c=l) and (node^.lista_n=l1) then flag:=true
 else node:=node^.next;
 if flag then writeln('Elementi riscontrati sulla lista')
         else writeln('Elementi non riscontrati sulla lista');
 search1:=n2;
end;{search1}

procedure print_voli(head:punt);
 begin
  writeln;
  while head<>nil do
   begin
    writeln('Nome del volo ->',head^.nome);
    writeln('Ora di part.  ->',head^.ora);
    writeln('Destinazione  ->',head^.dest);
    writeln('Posti disp.   ->',head^.posti_d);
    writeln('Posti pren.   ->',head^.posti_p);
    writeln('Passeggeri acc->',head^.pass_acc);
    head:=head^.next;
    if head=nil then writeln('.') else writeln(',');
   end;
  writeln;
 end;{print_voli}

procedure print_lista(head:punt);
 begin
  writeln;
  while head<>nil do
   begin
    writeln('Cognome ->',head^.lista_c);
    writeln('Nome    ->',head^.lista_n);
    head:=head^.next;
    if head=nil then writeln('.') else writeln(',');
   end;
  writeln;
 end;{print_lista}

procedure fine;
 begin
  writeln('Fine');
 end;{fine}

begin {main program}
 lista1:=nil;lista2:=nil;
 repeat
 writeln('Inserire la scelta del seguente menu'' ');
 writeln('1)Inserimento dati voli');
 writeln('2)Cancellazione ultimi dati inseriti');
 writeln('3)Ricerca dati voli');
 writeln('4)Stampa voli');
 writeln('5)Fine');
 writeln('********************************************* ');
 readln(num);
 case num of
  1:begin
     writeln('Inserimento dati volo');
     writeln('Nome volo :');readln(n);
     writeln('Ora di partenza :');readln(o);
     writeln('Posti disponibili :');readln(pd);
     writeln('Posti prenotati :');readln(pp);
     writeln('Passeggeri accettati :');readln(pa);
     writeln('Destinazione finale :');readln(d);
     push(n,o,d,pd,pp,pa,lista1);
     writeln('Vuoi inserire passeggeri in lista di attesa?');
     writeln('Digitare"s" per si "n" per no');readln(car);
     if car='s' then
      begin
       writeln('Quanti');readln(q);
       for i:=1 to q do
        begin
         writeln('Inserimento passeggeri in lista di attesa');
         writeln('Inseriscine il nome: ');readln(l1);
         writeln('Inseriscine il cognome: ');readln(l);
         push1(l,l1,lista2);
        end;
       writeln;
      end
     else writeln('Nessun elemento da inserire in lista di attesa');
    end;
  2:begin
     writeln('Cancellazione dell''ultimo volo ');
     pop(n,o,d,pd,pp,pa,lista1);
     writeln('Nome volo cancellato: ',n,'per ',d);
     writeln('Vuoi cancellare anche qualche passeggero inserito in lista?');
     writeln('Digitare"s" per si "n" per no');readln(car);
     if car='s' then
      begin
       writeln('Cancellazione dell''ultimo passeggero in lista ');
       pop1(l,l1,lista2);
       writeln('Dati passeggero cancellato : ',l,',',l1);
       writeln;
      end
     else writeln('Nessun elemento da cancellare in lista');
    end;
  3:begin
     writeln('Ricerca volo');
     writeln('Inserisci il nome del volo');
     readln(n);
     n1:=search(n,o,d,pd,pp,pa,lista1);
     writeln('Vuoi ricercare passeggeri in lista?');
     writeln('Digitare"s" per si "n" per no');readln(car);
     if car ='s' then
      begin
       writeln('Ricerca passeggero in lista');
       writeln('Inseriscine il cognome');readln(l);
       writeln('Inseriscine il nome');readln(l1);
       n2:=search1(l,l1,lista2);
       writeln;
      end
     else writeln('Nessun passeggero da ricercare');
    end;
  4:begin
     writeln('I voli inseriti sono: ');
     print_voli(lista1);
     writeln('I passeggeri in lista di attesa sono: ');
     print_lista(lista2);
    end;
  5:fine;
 end;
 until num=5;
readln;
end.