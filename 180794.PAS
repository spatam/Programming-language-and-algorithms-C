program primo1(s,output);
uses crt;
type
 punt1=^nodo1;
 nodo1=record
  info:integer;
  next:punt1;
 end;
 punt2=^nodo2;
 nodo2=record
  info:punt1;
  next:punt2;
 end;
var
 k:integer;
 lista:punt1;
 headlist:punt2;
 s,m:text;
 r:char;

procedure print(head:punt1);forward;

procedure insertlist(head:punt1;var headlist:punt2);
var node:punt2;
begin
 new(node);
 node^.info:=head;
 node^.next:=headlist;
 headlist:=node
end;

procedure insert(num:integer;var head:punt1);
var node,prec,newnode:punt1;
begin
 new(newnode);
 newnode^.info:=num;
 if ((head=nil) or (num<head^.info)) then
  begin
   newnode^.next:=head;
   head:=newnode;
  end
 else
  begin
   prec:=head;
   node:=prec^.next;
   while ((node<>nil) and (num>node^.info)) do
    begin
     prec:=node;
     node:=node^.next;
    end;
   newnode^.next:=node;
   prec^.next:=newnode;
  end;
end;

procedure multiplo(p:integer;var head:punt1);
var num:integer;
begin
 head:=nil;
 reset(m);
 while(not eof(m)) do
  begin
   readln(m,num);
   if ((num mod p)=0) then insert(num,head)
  end;
end;

function primo(p:integer):boolean;
var i:integer;flag:boolean;
begin
 if p<=0 then primo:=false else
 if p=1 then primo:=true else
  begin
   flag:=false;
   i:=2;
   while((i<=(p/2)) and (not flag)) do
   if (p mod i)=0 then flag:=true
                    else i:=i+1;
   if flag then primo:=false
           else begin
                 writeln;
                 writeln(p,' e'' primo');
                 write('Lista crescente dei suoi multipli contenuti in S->');
                end
  end
end;

procedure ricorsione;
var num,p:integer;
    head:punt1;
begin
 assign(s,'dati');
 assign(m,'dati');
 reset(s);
 for p:=2 to k do
  begin
   if primo(p) then
    begin
     multiplo(p,head);
     print(head);
     insertlist(head,headlist)
    end
  end
end;

procedure print(head:punt1);
var node:punt1;
begin
 node:=head;
 while node<>nil do
  begin
   write(node^.info,' ');
   node:=node^.next
  end
end;

function merge(node1,node2:punt1):punt1;{procedura che date due liste }
var head:punt1;                         {ordinate le fonde 'merge' in una}
begin                                   {lista ordinata questa variante }
 head:=nil;                             {del merge usato nel merge_sort }
 while (node1<>nil) and (node2<>nil) do {non cancella le liste input   }
 if node1^.info<node2^.info then
  begin
   insert(node1^.info,head);
   node1:=node1^.next;
  end
 else
  begin
   insert(node2^.info,head);
   node2:=node2^.next
  end;
 while node1<>nil do
  begin
   insert(node1^.info,head);
   node1:=node1^.next;
  end;
 while node2<>nil do
  begin
   insert(node2^.info,head);
   node2:=node2^.next;
  end;
 merge:=head;
end;{merge}

function immersione:punt1;       {questa procedura serve }
var                              {per immergere un insieme}
 lista:punt1;                    {di liste in una unica}
 node:punt2;
begin
 lista:=nil;
 node:=headlist;
 while node<>nil do
  begin
   lista:=merge(node^.info,lista);
   node:=node^.next;
  end;
 immersione:=lista;
end;{immersione}

begin
 clrscr;
 headlist:=nil;
 write('Inserisci un intero: ');readln(k);
 ricorsione;
 lista:=immersione;
 writeln;
 write('Lista crescente ottenuta dalla immersione delle suddette liste -->');
 print(lista);
 readln(r);
end.