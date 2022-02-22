program verita(input,output);

uses crt;

type
 punt=^node;
 node=record
  info:boolean;
  next:punt;
 end;
 vettore=array [1..10] of punt;
 insiemi=set of char;

var
 v:vettore;
 i,n,j:integer;
 formula:string;
 car:char;
 operandi,operatori:insiemi;
 bol,valore:boolean;

procedure push(bo:boolean;var head:punt);
var node:punt;
begin
 new(node);
 node^.info:=bo;
 node^.next:=head;
 head:=node;
end;

procedure pop(var bo:boolean;var head:punt);
var node:punt;
begin
 node:=head;
 head:=node^.next;
 bo:=node^.info;
 dispose(node);
end;

function opero(z:char):boolean;
var a,b:boolean;
begin
 case z of
  '&':begin
       pop(a,v[i]);{cancella il valore di a poi quando cerca di cancellare}
       pop(b,v[i]);{anche il secondo non lo trova poichŠ ne ho inserito uno}
       if (a and b) then opero:=true
                    else opero:=false;
      end;
  'V':begin
       pop(a,v[i]);
       pop(b,v[i]);
       if (a or b) then opero:=true
                   else opero:=false;
      end;
   '>':begin
        pop(a,v[i]);
        pop(b,v[i]);
        if ((not a) and b) then opero:=false
                           else opero:=true;
       end;
   '!':begin
        pop(a,v[i]);
        if (not a) then opero:=true
                   else opero:=false;
       end;
 end;
end;

procedure print(head:punt);
var node:punt;
    i:integer;
begin
 node:=head;
 i:=0;
 while node<>nil do
  begin
   i:=i+1;
   write('Valore di verita'' della ',i,' formula ',node^.info,' ');
   node:=node^.next;
   if node=nil then writeln('.') else write(',');
  end
end;{print}

function verifica(n:integer;var v:vettore):boolean;
var
 i:integer;
 flag:boolean;
begin
 i:=1;
 flag:=false;
 while (i<n) and (not flag) do
  if (v[i]^.info<>v[i+1]^.info) then flag:=true
                                else i:=i+1;
if not flag then writeln('Tutte le formule hanno lo stesso valore di verit…:',v[i]^.info)
else writeln('La ',i,'ø e la ',i+1,'ø formula hanno valori di verit… differenti');
verifica:=flag;
end;

procedure init(formula:string;var valore:boolean);
begin
 while formula[j]<>'.' do
  begin
   j:=j+1;
   if formula[j] in operandi then
    begin
     write('Valore di verit… di ',formula[j],': (v/f) ? ');readln(car);
     if car='v' then bol:=true
                else bol:=false;
     push(bol,v[i]);
    end
   else if formula[j] in operatori then
    begin
     valore:=opero(formula[j]);
     push(valore,v[i]);
    end
  end;
end;

begin {main program}
clrscr;
operandi:=['a'..'z'];
operatori:=['&','V','>','!'];
write('Quante formule ? ');readln(n);
for i:=1 to n do
 begin
  j:=0;
  v[i]:=nil;
  writeln('Inserire una formula proposizionale che finisca con un punto ');
  write(i,'ø Formula:');readln(formula);
  init(formula,valore);
 end;
verifica(n,v);
readln;
end.