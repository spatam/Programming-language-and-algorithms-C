program verita1(input,output);
 uses crt;
 const
  max=20;
 type
  punt1=^node1;
  node1=record
   info:boolean;
   next:punt1;
  end;
  rec=record
   stringa:string;
   bo:boolean;
  end;
 vettore=array [1..max]  of rec;
 insiemi=set of char;
 car='a'..'z';
 var
  n,i,j,num:integer;
  ris:char;
  ch:car;
  lista:punt1;
  v:vettore;
  formula:string;
  bl,valore:boolean;
  operandi,operatori:insiemi;

procedure push(b:boolean;var head:punt1);
var node:punt1;
begin
 new(node);
 node^.info:=b;
 node^.next:=head;
 head:=node;
end;{push}

procedure pop(var b:boolean;var head:punt1);
var node:punt1;
begin
 node:=head;
 head:=node^.next;
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
                    else opero:=false
      end;
  'V':begin
       pop(a,lista);
       pop(b,lista);
       if (a or b) then opero:=true
                   else opero:=false
      end;
  '!':begin
       pop(a,lista);
       if (not a) then opero:=true
                  else opero:=false
      end;
  '>':begin
       pop(a,lista);
       pop(b,lista);
       if ((not a) and b) then opero:=false {<---perche' uso and e non or??}
                          else opero:=true
      end
 end
end;{opero}

procedure print(head:punt1);
var node:punt1;
    j:integer;
begin
 node:=head;
 j:=0;
 while node<>nil do
  begin
   j:=j+1;
   write('Valore di verita'' della ',j,' formula ',node^.info,' ');
   node:=node^.next;
   if node=nil then writeln('.') else write(',');
  end
end;{print}

procedure control(n:integer;var v:vettore);
var i:integer;      {questa procedura stampa un valore di verita solo se}
    flag:boolean;   {se tutte le formule hanno lo stesso valore,altrimenti}
                    {stampa le prime due che nella lista hanno valore diverso}
begin
  i:=1;
  flag:=false;
  while (i<n) and (not flag) do
   if (v[i].bo<>v[i+1].bo) then flag:=true
                           else i:=i+1;
   if flag then
   writeln('Le formule ',v[i].stringa,',',v[i+1].stringa,' hanno valori di verita'' differenti')
   else
   writeln('Tutte le formule hanno il medesimo valore di verita'' ',v[i].bo);
end;{control}

procedure fine;
begin
 writeln('Termine momentaneo');
end;{fine}

begin{main program}
 operatori:=['&','V','!','>'];
 operandi :=['a'..'z'];
 repeat
  clrscr;
  lista:=nil;
  writeln('1)Inserimento formula di verita'' ');
  writeln('2)Verifica e stampa valore di verita'' di tutte le formule');
  writeln('3)Fine');
  write('Inserire una scelta per il menu'': ');readln(num);
  case num of
   1:begin
      write('Quante formule inserire ? ');readln(n);
      for j:=1 to n do
       begin
        write('Inserisci la ',j,'ø formula postfissa che finisca con un punto ->');
        readln(formula);
        v[j].stringa:=formula;
        i:=0;
        while formula[i]<>'.' do
         begin
          i:=i+1;
          ch:=formula[i];
          if ch in operandi then
           begin
            write('Digita il valore di verita'' di ',ch,' (v/f)? ');
            readln(ris);
            if ris='v' then bl:=true
                       else bl:=false;
            v[j].bo:=bl;
            push(bl,lista);
           end
          else if ch in operatori then
           begin
            valore:=opero(ch);
            v[j].bo:=valore;
            push(valore,lista);
           end
         end;
        writeln('Il valore di verita'' della ',j,' formula e'' :',bl);
       end;
     readln;
     end;
   2:begin
      control(n,v);
      readln;
     end;
   3:fine;
  end;
 until num=3;
readln;
end.