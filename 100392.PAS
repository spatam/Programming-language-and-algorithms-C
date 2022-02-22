program insiemi1(input,output);
uses crt;
type
 punt=^node;
 node=record
  info:integer;
  left,right:punt;
 end;
var
 tree_a,tree_b,tree:punt;
 tree_dif,tree_uni,tree_int:punt;
 a,b,i,num,num1:integer;
 ris:char;

procedure insert(n:integer;var root:punt);
 procedure getnode(n:integer;var root:punt);
 var node:punt;
 begin
  new(node);
  node^.info:=n;
  node^.left:=nil;
  node^.right:=nil;
  root:=node;
 end;{getnode}
begin
 if root=nil then getnode(n,root)
 else if n<root^.info then insert(n,root^.left)
 else if n>root^.info then insert(n,root^.right)
end;{insert}

function search(n:integer;head:punt):boolean;
var flag:boolean;
begin
 if head=nil then flag:=false
 else if n=head^.info then flag:=true
 else if n<head^.info then flag:=search(n,head^.left)
 else flag:=search(n,head^.right);
 search:=flag;
end;{search}

procedure inorder(head:punt);
begin
 if head<>nil then
  begin
   inorder(head^.left);
   write(head^.info,',');
   inorder(head^.right);
  end
end;{inorder}

procedure intersezione(tree_a,tree_b:punt);
begin
 if tree_a<>nil then
  begin
   if search(tree_a^.info,tree_b) then insert(tree_a^.info,tree_int);
   intersezione(tree_a^.left,tree_b);
   intersezione(tree_a^.right,tree_b);
  end;
end;{intersezione}

procedure differenza(tree_a,tree_b:punt);
begin
 if tree_a<>nil then
  begin
   if not search(tree_a^.info,tree_b) then insert(tree_a^.info,tree_dif);
   differenza(tree_a^.left,tree_b);
   differenza(tree_a^.right,tree_b);
  end;
end;{differenza}

procedure copy_tree(var tree:punt);
begin
 if tree<>nil then
  begin
   insert(tree^.info,tree_uni);
   copy_tree(tree^.left);
   copy_tree(tree^.right);
  end;
end;{copy_tree}

procedure unione(var tree_a,tree_b:punt);
begin
 copy_tree(tree_a);
 copy_tree(tree_b);
end;{unione}

begin{main program}
 clrscr;
 tree:=nil;tree_a:=nil;tree_b:=nil;tree_uni:=nil;tree_dif:=nil;tree_int:=nil;
 writeln('Inserire l''insieme A di numeri');
 write('Quanti numeri? ');readln(a);
 for i:=1 to a do
  begin
   write('Numero ');readln(num);
   insert(num,tree_a);
  end;
 writeln('Inserire l''insieme B di numeri');
 write('Quanti numeri? ');readln(b);
 for i:=1 to b do
  begin
   write('Numero ');readln(num1);
   insert(num1,tree_b);
  end;
 write('Inorder di A: ');inorder(tree_a);
 writeln;
 write('Inorder di B: ');inorder(tree_b);
 writeln;
 intersezione(tree_a,tree_b);
 write('intersezione ->');inorder(tree_int);
 writeln;
 differenza(tree_a,tree_b);
 write('differenza A/B  ->');inorder(tree_dif);
 writeln;
 tree_dif:=nil;
 differenza(tree_b,tree_a);
 write('differenza B/A  ->');inorder(tree_dif);
 writeln;
 unione(tree_a,tree_b);
 write('unione       ->');inorder(tree_uni);
 writeln;
readln;
end.