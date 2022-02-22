program formule(input,output);

uses crt;

type
 punt=^node;
 node=record
  info:boolean;
  next:punt;
 end;

 insiemi=set of char;

var
 formula:string;
 operandi,operatori:insiemi;
 bol:boolean;
 lista:punt;

procedure push(b:boolean;var head:punt);
var node:punt;
begin
 new(node);
 node^.info:=b;
 node^.next:=head;
 head:=node;
end;

procedure pop(var b:boolean;var head:punt);
var node:punt;
begin
 node:=head;
 head:=node^.next;
 b:=node^.info;
 dispose(node);
end;

function opero(z:char):boolean;
var a,b:boolean;
begin
 case z of
  '&':begin
       pop(a,lista);
       pop(b,lista);
       if (a and b) then opero:=true
                    else opero:=false;
      end;
  'V':begin
       pop(a,lista);
       pop(b,lista);
       if (a or b) then opero:=true
                   else opero:=false;
      end;
  '!':begin
       pop(a,lista);
       if (not a) then opero:=true
                  else opero:=false;
      end;
  '>':begin
       pop(a,lista);
       pop(b,lista);
       if (not a) and b then opero:=false
                        else opero:=true;
      end;

 end;
end;

procedure init(formula:string;var head:punt);
var
 i:integer;
 a,car:char;
begin
 i:=0;
 head:=nil;
 while formula[i]<>'.' do
  begin
   i:=i+1;
   a:=formula[i];
   if a in operandi then
    begin
     write('Inserisci un valore booleano (v/f) di ',a,':');
     readln(car);
     if car='v' then bol:=true
                else if car='f' then bol:=false
                else writeln('Valore non valido');
     push(bol,head);
    end
   else
    if a in operatori then
     begin
      bol:=opero(a);
      push(bol,head);
     end;
  end;
 writeln('Il valore di verit… di ',formula,' Š ',bol);
end;

begin {main program}
clrscr;
 operandi:=['a'..'h'];
 operatori:=['&','V','!','>'];
 write('Inserisci una formula postfissa che finisca con un punto: ');
 readln(formula);
 init(formula,lista);
readln;
end.