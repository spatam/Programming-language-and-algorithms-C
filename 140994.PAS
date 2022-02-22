program newcar(input,output);
uses crt;
type
 punt=^node;
 node=record
  nome:string;
  ore:integer;
  next:punt;
 end;
 punt1=^node1;
 node1=record
  nome:string;
  lista:punt;
  next:punt1;
 end;
var
 i,ore,num:integer;
 save:punt;
 nomed,nomes:string;
 headlist:punt1;

function search_sett(nomes:string;head1:punt1):punt1;
{ricerca in strutture dinamica}
var
 node:punt1;
 flag:boolean;
begin
 flag:=false;
 node:=head1;
 while (node<>nil) and (not flag) do
  begin
   if (node^.nome=nomes) then flag:=true
   else node:=node^.next;
  end;
 search_sett:=node;
end;{search_sett}

function search_dip(nomed:string;var head:punt):punt;
{ricerca in strutture dinamiche tipo puntatori}
var
 node:punt;
 flag:boolean;
begin
 flag:=false;
 node:=head;
 while (node<>nil) and (not flag) do
  begin
   if (node^.nome=nomed) then flag:=true
   else node:=node^.next
  end;
 search_dip:=node
end;{search_dip}

procedure push(n:string;o:integer;var head:punt);
{inserimento in stack}
var
node:punt;
begin
 new(node);
 node^.nome:=n;
 node^.ore:=o;
 node^.next:=head;
 head:=node;
end;{push}

procedure insert_dip(nomed:string;o:integer;var head:punt);
{inserimento ordinato dipendenti}
begin
 if head=nil then push(nomed,o,head)
 else if nomed[1]<head^.nome then push(nomed,o,head)
 else if nomed[1]>head^.nome then insert_dip(nomed,o,head^.next)
end;{insert_dip}

procedure push_sett(n:string;l:punt;var head:punt1);
{inserimento in stack}
var
node:punt1;
begin
 new(node);
 node^.nome:=n;
 node^.lista:=l;
 node^.next:=head;
 head:=node;
end;{push}

procedure init;
begin
 push_sett('vendite',nil,headlist);
 push_sett('assistenza',nil,headlist);
 push_sett('amministrazione',nil,headlist);
end;

procedure inse(nomes,nomed:string;ore:integer);
var
 sect:punt1;
 dip:punt;
begin
 sect:=search_sett(nomes,headlist);
 if sect=nil then writeln('settore inesistente')
 else
  begin
   dip:=search_dip(nomed,sect^.lista);
   if dip<>nil then
    begin
     writeln('Nominativo presente nel settore');
     dip^.ore:=dip^.ore+ore;
     writeln('Il monte ore di ',nomed,' aumentato del numero di ore ');
     writeln('dato in input adesso Š: ',dip^.ore);
    end
   else
    begin
     insert_dip(nomed,ore,sect^.lista);
     writeln('Il dipendente non esisteva ma Š stato inserito');
    end;
  end;
readln;
end;

procedure print(head:punt);
var
 node:punt;
begin
 node:=head;
 writeln('                    DIPENDENTE              ORE');
 while (node<>nil) do
  begin
   writeln('                   ',node^.nome,'            ',node^.ore);
   node:=node^.next;
  end;
end;{print}

procedure printlist(head:punt1);
var
 node:punt1;
begin
 node:=head;
 while (node<>nil) do
  begin
   writeln('Nome Settore: ',node^.nome);
   print(node^.lista);
   node:=node^.next;
  end;
end;{print}

function successivo(nomed,nomes:string):punt;
var
 dip:punt;
 flag:boolean;
 sect:punt1;
begin
 flag:=false;
 sect:=search_sett(nomes,headlist);
 if sect=nil then writeln('Settore non esistente')
 else
  begin
   dip:=search_dip(nomed,sect^.lista);
   if dip=nil then writeln('Dipendente non in organico nel settore')
   else flag:=true;
  end;
  if flag then successivo:=dip^.next {se voglio togliere i successivi }
                                     {dip^.next:=nil}
          else successivo:=nil;
 writeln('I nomi successivi ad ',nomed,' sono: ');
 print(dip^.next);
end;{successivo}

procedure insert_sett(save:punt;var head:punt1);
var
 ris:char;
begin
 writeln('Vuoi creare un nuovo settore comprendente');
 write('i nominativi successivi a quello dato in input? (s/n)');readln(ris);
 if ris='s' then
  begin
   write('Inserisci il nome del Nuovo settore -> ');readln(nomes);
   push_sett(nomes,save,head);
  end
 else writeln('Nessun nuovo settore creato !');
end;{insert_sett}

procedure fine;
begin
 writeln('Termine momentaneo');
end;{fine}

begin{main program}
 headlist:=nil;
 init;
 repeat
  clrscr;
  writeln('1 Inserimento dipendenti');
  writeln('2 Nuovo settore');
  writeln('3 Stampa organigramma');
  writeln('4 Fine');
  write('Inserisci una scelta per il menu ->');readln(num);
  case num of
   1:begin
      write('Inserirne il cognome ->');readln(nomed);
      write('Inserirne le ore lavorate settimanali -> ');readln(ore);
      write('Inserisci il settore ->');readln(nomes);
      inse(nomes,nomed,ore)
     end;
   2:begin
      write('Inserire un nominativo:');readln(nomed);
      write('Inserirne il settore: ');readln(nomes);
      save:=successivo(nomed,nomes);
      if save<>nil then insert_sett(save,headlist);
     readln;
     end;
   3:begin
      writeln('Stampa organigramma dipendenti settore per settore ->');
      printlist(headlist);
      readln;
     end;
   4:fine;
  end;
 until num=4;
readln;
end.



