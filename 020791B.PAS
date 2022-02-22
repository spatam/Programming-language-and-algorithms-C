program espressione(input,output);
uses crt;
type
 punt=^node;
 node=record
  info:char;
  next:punt;
 end;
 tree=^node1;
 node1=record
  info:char;
  left:tree;
  right:tree;
 end;
 insiemi=set of char;
var
 num:integer;
 formula:string;
 root:tree;
 head:punt;
 operandi,operatori:insiemi;

procedure push(n:char;var head:punt);
var node:punt;
begin
 new(node);
 node^.info:=n;
 node^.next:=head;
 head:=node;
end;

procedure pop(var n:char;var head:punt);
var node:punt;
begin
 node:=head;
 n:=node^.info;
 head:=node^.next;
 dispose(node);
end;

procedure getnode(n:char;var root:tree);
var node:tree;
begin
 new(node);
 node^.info:=n;
 node^.left:=nil;
 node^.right:=nil;
 root:=node;
end;

procedure make_tree(var head:punt;var root:tree);
var n:char;
begin
 if head<>nil then
  begin
   pop(n,head);
   getnode(n,root);
   if n in operatori then
    begin
     make_tree(head,root^.right);
     make_tree(head,root^.left);
    end
  end;
end;

procedure inorder(root:tree);
begin
 if root<>nil then
  begin
   if root^.info in operatori then write('(');
   inorder(root^.left);
   write(root^.info);
   inorder(root^.right);
   if root^.info in operatori then write(')');
  end;
end;

procedure init(formula:string;var head:punt);
var i:integer;
begin
 i:=1;
 while formula[i]<>'.' do
  begin
   push(formula[i],head);
   i:=i+1;
  end;
end;

begin {main program}
 head:=nil;root:=nil;
 operandi:=['a'..'e'];
 operatori:=['+','*','-','/'];
 repeat
 clrscr;
 writeln('PROGRAMMA FORMULE POSTFISSE');
 writeln('***************************');
 writeln;
 writeln('1* Inserisci postfissa');
 writeln('2* Costruisci B.S.T. ');
 writeln('3* Forma infissa ');
 writeln('4* Fine ');
 writeln;
 write('Scegli il seguente men—  ->');readln(num);
 writeln;
  case num of
   1:begin
      write('Inserisci una formula che finisca con un punto:');readln(formula);
      init(formula,head);
      readln;
     end;
   2:begin
      writeln('Costruzione B.S.T. ........');
      make_tree(head,root);
      readln;
     end;
   3:begin
      write('Forma infissa:');
      inorder(root);
      readln;
     end;
   4:writeln('Termine momentaneo ........');
  end;
 until num=4;
readln;
end.