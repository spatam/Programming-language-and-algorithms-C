program alberi(input,output);
type
 tree=^node1;
 node1=record
  info:char;
  left,right:tree;
 end;

var
 i,n,m:integer;
 c,car:char;
 rootA,rootB:tree;

procedure getnode(c:char;var root:tree);
var node:tree;
begin
 new(node);
 node^.info:=c;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;

procedure insert(c:char;var root:tree);
begin
 if root=nil then getnode(c,root)
 else if c<root^.info then insert(c,root^.left)
                      else insert(c,root^.right);
end;

procedure sostituisci(var root:tree;root1:tree);
begin
 if root1<>nil then
   begin
    getnode(root1^.info,root);
    sostituisci(root^.left,root1^.left);
    sostituisci(root^.right,root1^.right);
   end;
end;

procedure sostituisco(var root:tree);
begin
  writeln('Elemento Trovato');
  if (root^.left=nil) and (root^.right=nil) then
      sostituisci(root,rootB) { root:=rootB anzichä assegnare
                                l'albero lo ricopio}
  else writeln('Elemento con figli - IMPOSSIBILE SOSTITUZIONE ');
end;

procedure search(c:char;var root:tree);
begin
 if root<>nil then
   if c=root^.info then sostituisco(root)
    else if c<root^.info then search(c,root^.left)
                         else search(c,root^.right)
end;

procedure inorder(root:tree);
begin
 if root<>nil then
  begin
   inorder(root^.left);
   write(root^.info,' ');
   inorder(root^.right);
  end;
end;

procedure init(num:integer;var root:tree);
var i:integer;car:char;
begin
 for i:=1 to num do
  begin
   write('Etichetta:');readln(car);
   insert(car,root);
  end;
end;

begin {main program}
 rootA:=nil;rootB:=nil;
 writeln('PROGRAMMA ALBERI BINARI');
 writeln('***********************');
 write('Quante etichette vuoi inserire in A ? ');readln(n);
 init(n,rootA);
 write('Quante etichette vuoi inserire in B ? ');readln(m);
 init(m,rootB);
 writeln;
 write('Attraverso e stampo A :');inorder(rootA);
 writeln;
 write('Attraverso e stampo B :');inorder(rootB);
 writeln;writeln;
 write('Inserisci un carattere "x" generico:');readln(c);
 writeln;
 writeln('Sostituzione al posto di ',c,' in A dell''albero B :');
 search(c,rootA);
 writeln;
 write('Stampa del nuovo albero A : ');inorder(rootA);
 readln;
end.
readln;
end.





