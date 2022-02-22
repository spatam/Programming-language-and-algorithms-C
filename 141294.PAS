program albero(input,output);

uses crt;

type
 tree=^node;
 node=record
  info:integer;
  left:tree;
  right:tree;
 end;

var
 root,nuovo:tree;

procedure getnode(x:integer;var root:tree);
var node:tree;
begin
 new(node);
 node^.info:=x;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;

procedure insert(x:integer;var root:tree);
begin
 if root=nil then getnode(x,root)
 else if x<root^.info then insert(x,root^.left)
 else if x>root^.info then insert(x,root^.right);
end;

procedure inorder(root:tree);
begin
 if root<>nil then
 begin
  inorder(root^.left);
  write(root^.info,',');
  inorder(root^.right);
 end
end;

procedure make_tree(var root:tree;var nuovo:tree);
begin
 if root<>nil then
 begin
  getnode(root^.info,nuovo);
  make_tree(root^.left,nuovo^.right);
  make_tree(root^.right,nuovo^.left);
 end
end;

procedure inser;
var i,n,num:integer;
begin
write('Quanti numeri ? ');readln(n);
for i:=1 to n do
 begin
  write('Numero:');
  readln(num);
  insert(num,root);
 end;
end;

begin {main program}
clrscr;
root:=nil;nuovo:=nil;
writeln('Inserire un insieme di numeri interi senza ripetizione -->');
inser;
write('Creato albero B.S.T. :');
inorder(root);
make_tree(root,nuovo);
writeln;
write('Creato albero B.S.T. nuovo :');
inorder(nuovo);
readln;
end.