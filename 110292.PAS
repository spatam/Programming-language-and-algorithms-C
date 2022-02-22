program polinomi(input,output);
uses crt;
type
 punt=^node;
 node=record
  coef,esp:integer;
  next:punt;
 end;
var
 i,x,y,num:integer;
 head,n1,n2,lista,lista1,lista2,lista3,listas:punt;

procedure push(x,y:integer;var head:punt);
var newnode:punt;
begin
 new(newnode);
 newnode^.coef:=x;
 newnode^.esp:=y;
 newnode^.next:=head;
 head:=newnode;
end;{push}

procedure pop(var x,y:integer;var head:punt);
var node:punt;
begin
 node:=head;
 head:=head^.next;
 x:=node^.coef;
 y:=node^.esp;
 dispose(node);
end;{pop}

function search(x,y:integer;head:punt):punt;
var
 node:punt;
 flag:boolean;
begin
 flag:=false;
 node:=head;
 if head=nil then writeln('coppia coefficente-esponente non presente')
 else
 while (node<>nil) and (not flag) do
  if (node^.coef=x) and (node^.esp=y) then flag:=true
  else node:=node^.next;

 if flag then writeln('coppia trovata')
 else writeln('coppia non trovata');

 search:=node;
end;{search}

function search1(y:integer;head:punt):punt;
var
 node:punt;
 flag:boolean;
begin
 flag:=false;
 node:=head;
 while (node<>nil) and (not flag) do
  if (node^.esp=y) then flag:=true
                   else node:=node^.next;

 if flag then writeln('esponente trovato')
         else writeln('esponente non trovato');
 search1:=node;
end;{search1}

function per_polinomi(lista1,lista2:punt):punt;
var
 lista3,node1,node2,node3:punt;
begin
 lista3:=nil;
 node1:=lista1;
 while (node1<>nil) do
  begin
   node2:=lista2;
    while (node2<>nil) do
     begin
      y:=node1^.esp+node2^.esp;
      x:=node1^.coef*node2^.coef;
      node3:=search1(y,lista3);
      if node3<>nil then node3^.coef:=node3^.coef+x
                    else push(x,y,lista3);
{cercare y nella lista3 se esiste sommo solo i coeff alrimenti faccio la push}
      node2:=node2^.next;
     end;
   node1:=node1^.next;
  end;
 per_polinomi:=lista3;
end;{per_polinomi}

function duplica_lista(node2:punt):punt;
var listas:punt;
begin
 listas:=nil;
 while (node2<>nil) do
  begin
   push(node2^.coef,node2^.esp,listas);
   node2:=node2^.next;
  end;
 duplica_lista:=listas;
end;{duplica_lista}

function somma_polinomi(lista1,lista2:punt):punt;
var
 listas,node1,node2:punt;
begin
 node1:=lista1;{copia della testa anche se non necessaria perchä}
 node2:=lista2;              {passata come parametro valore}
 listas:=duplica_lista(node2);
 while (node1<>nil) do
  begin
   node2:=search1(node1^.esp,listas);
   if node2<>nil then node2^.coef:=node1^.coef+node2^.coef
   else push(node1^.coef,node1^.esp,listas);
   node1:=node1^.next;
  end;
 somma_polinomi:=listas;
end; {somma polinomi}

procedure print(h:punt);
begin
 writeln;
 while h<>nil do
  begin
   write(h^.coef,'X^',h^.esp,' ');
   h:=h^.next;
   if h=nil then writeln('.') else write('+');
  end;
  writeln;
end;{print}

procedure fine;
begin
 writeln('Interruzione momentanea del programma');
end;{fine}

begin {main program}
 clrscr;
 lista1:=nil;lista2:=nil;lista3:=nil;listas:=nil;
 repeat
 writeln('Inserire la scelta del seguente menu'' ');
 writeln('1)Inserimento 1 polinomio');
 writeln('2)Inserimento 2 polinomio');
 writeln('3)Cancellazione');
 writeln('4)Ricerca ');
 writeln('5)Stampa ');
 writeln('6)Somma dei polinomi ');
 writeln('7)Prodotto di polinomi');
 writeln('8)Fine');
 writeln('********************************************* ');
 readln(num);
 case num of
  1:begin
     writeln('Inserisci la coppia coefficente esponente del 1 polinomio prego');
     writeln('Coefficente :');readln(x);
     writeln('Esponente :');readln(y);
     push(x,y,lista1);
    end;
  2:begin
     writeln('Inserisci la coppia coefficente esponente del 2 polinomio prego');
     writeln('Coefficente :');readln(x);
     writeln('Esponente :');readln(y);
     push(x,y,lista2);
    end;
  3:begin
     writeln('Cancellazione dell''ultima copia coefficente-esponente ');
     writeln('inserita per il primo polinomio');
     pop(x,y,lista1);
     writeln('Coppia cancellata: (',x,',',y,')');
     writeln('Cancellazione dell''ultima coppia coefficente-esponente ');
     writeln('inserita per il secondo polinomio');
     pop(x,y,lista2);
     writeln('Coppia cancellata: (',x,',',y,')');
    end;
  4:begin
     writeln('Ricerca nel primo polinomio');
     writeln('Inserisci la coppia coefficente-esponente da ricercare');
     readln(x,y);
     n1:=search(x,y,lista1);
     writeln('Ricerca nel secondo polinomio');
     writeln('Inserisci la coppia coefficente-esponente da ricercare');
     readln(x,y);
     n1:=search(x,y,lista2);
    end;
  5:begin
     writeln('Le coppie di polinomi inserite sono:');
     print(lista1);
     print(lista2);
    end;
  6:begin
     writeln('La somma dei polinomi e'' data dalle coppie:------------>');
     listas:=somma_polinomi(lista1,lista2); {ANzICHä lista2 la copia listaS}
     print(listas);
    end;
  7:begin
     writeln('Il prodotto dei due polinomi ä dato dalle coppie:------->');
     lista3:=per_polinomi(lista1,lista2);
     print(lista3);
    end;
  8:fine;
  end;
 until num=8;
readln;
end.