procedure swap(var a,b:integer);
var x:integer;
begin
 x:=a;
 a:=b;
 b:=x;
end;

procedure bubble_sort(a:vettore;n:integer);
var i,j:integer;
begin
 for j:=n-1 downto 1 do
  for i:=1 to j do
   if a[i]^.info>a[i+1]^.info then swap(a[i]^.info,a[i+1]^.info);
end;