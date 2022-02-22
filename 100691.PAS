program postfix(input,output);
uses crt;
type
 punt=^node;
 node=record
  info:boolean;
  next:punt;
 end;
 car= 'a'..'h';
 insiemi=set of char;
var
 ris:char;
 ch:car;
 head,lista:punt;
 formula:string;
 operandi,operatori:insiemi;
 bl,valore:boolean;
 num,i:integer;

procedure push(b:boolean;var h:punt);  {inserimento in testa in uno stack}
var newnode:punt;
 begin
  new(newnode);
  newnode^.info:=b;
  newnode^.next:=h;
  h:=newnode;
 end;{push}
procedure pop(var b:boolean;var h:punt); {cancellamento in testa in uno stack}
var node:punt;
 begin
  node:=h;
  h:=h^.next;
  b:=node^.info;
  dispose(node);
 end;{pop}
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
       if a then opero:=false
            else opero:=true;
      end;
  '>':begin
       pop(a,lista);
       pop(b,lista);
       if (not(a) and (b)) then  opero:=false
                           else  opero:=true;
      end;
  end;
 end;{opero}

procedure fine;
 begin
  writeln('Termine momentaneo del'' utilizzo del programma');
 end;

begin {main program}
 lista:=nil;
 operatori:=['&','V','>','!'];
 operandi:=['a'..'h'];
 repeat
  clrscr;
  writeln('Inserire una scelta per il seguente menu'' ');
  writeln('1)Inserimento');
  writeln('2)Fine');
  readln(num);
  case num of
  1:begin
     writeln('Scrivi una formula postfissa che finisca con un punto');
     readln(formula);
     i:=0;
     while formula[i]<>'.' do
      begin
       i:=i+1;
       ch:=formula[i];
       if ch in operandi then
        begin
         writeln('Scrivi il valore di verita''di ',ch,' (v/f)?');
         readln(ris);
         if ris='v' then bl:=true
                    else bl:=false;
         push(bl,lista);
        end
       else if ch in operatori then
        begin
         valore:=opero(ch);
         push(valore,lista);
        end
      end;
     pop(bl,lista);
     writeln;
     writeln('Il valore di verita'' della formula e'' :',bl);
    end;
    2:fine;
  end;
 until num=2;
readln;
end.