function pop(var head:punt):punt;
var
x:punt;
begin
 x:=head;
 head:=head^.next;
 x^.next:=nil;
 pop:=x;
end;{pop}

procedure ins_coda(node:punt;var head,tail:punt);
begin
 if head=nil then
  begin
   head:=node;
   tail:=node;
  end
 else
  begin
   tail^.next:=node;
   tail:=node;
  end
end;{ins_coda}

function merge(node1,node2:punt):punt;
var head,tail,nodo:punt;
begin
  head:=nil;
  tail:=nil;
  while (node1<>nil) and (node2<>nil) do
  if (node1^.n<node2^.n) then
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end
  else
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  while (node1<>nil) do
   begin
    nodo:=pop(node1);
    ins_coda(nodo,head,tail);
   end;
  while (node2<>nil) do
   begin
    nodo:=pop(node2);
    ins_coda(nodo,head,tail);
   end;
  merge:=head;
end;{merge}

procedure spezza(c:integer;head:punt;var s1,s2:punt);
var i:integer;
begin
 s1:=head;
 if c>1 then for i:=1 to c-1 do head:=head^.next;
 s2:=head^.next;
 head^.next:=nil;
end;{spezza}

function merge_sort(s,x:integer;head:punt):punt;
var c:integer;
    s1,s2:punt;
begin
 if x<=1 then merge_sort:=head
 else
  begin
   c:=(x div 2);
   spezza(c,head,s1,s2);
   s1:=merge_sort(s,c,s1);
   s2:=merge_sort(s,x-c,s2);
   merge_sort:=merge(s1,s2);
  end;
end;{merge_sort}

