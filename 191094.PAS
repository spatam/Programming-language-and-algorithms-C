program verita(input,output);
 uses crt;
 type
  punt1=^node1;
  node1=record
   info:boolean;
   next:punt1;
  end;
 vettore=array [1..10]  of punt1;
 insiemi=set of char;
 car='a'..'z';
 var
  y,n,i,j,k,num:integer;
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
       pop(a,v[j]);
       pop(b,v[j]);
       if (a and b) then opero:=true
                    else opero:=false
      end;
  'V':begin
       pop(a,v[j]);
       pop(b,v[j]);
       if (a or b) then opero:=true
                   else opero:=false
      end;
  '!':begin
       pop(a,v[j]);
       if (not a) then opero:=true
                  else opero:=false
      end;
  '>':begin
       pop(a,v[j]);
       pop(b,v[j]);
       if ((not a) and b) then opero:=false {<---perche' uso and e non or??}
                          else opero:=true
      end
 end
end;{opero}

procedure print(head:punt1);
var node:punt1;
begin
 node:=head;
 while node<>nil do
  begin
   write(node^.info,' ');
   node:=node^.next;
   if node=nil then writeln('.') else write(',');
  end
end;{print}

procedure control(n:integer;var v:vettore);
var i:integer;      {questa procedura stampa un valore di verita solo se}
    flag:boolean;   {se tutte le formule hanno lo stesso valore,altrimenti}
                    {stampa le prime due che nella lista hanno valore diverso}
begin
  flag:=false;
  i:=1;
  while (i<n) and (not flag) do
   if v[i]^.info<>v[i+1]^.info then flag:=true
                               else i:=i+1;
   if flag then
   writeln('Le formule ',i,',',i+1,' hanno valori di verita'' differenti')
   else
   writeln('Tutte le formule hanno il medesimo valore di verita'' ',v[i]^.info);
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
  writeln('1)Inserimento formula di verita'' ');
  writeln('2)Stampa valore di verita'' della i-esima formula');
  writeln('3)Verifica e stampa valore di verita'' di tutte le formule');
  writeln('4)Fine');
  write('Inserire una scelta per il menu'': ');readln(num);
  case num of
   1:begin
      write('Quante formule inserire ? ');readln(n);
      for j:=1 to n do
       begin
        v[j]:=nil;
        write('Inserisci la ',j,'ø formula postfissa che finisca con un punto ->');
        readln(formula);
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
            push(bl,v[j]);
           end
          else if ch in operatori then
           begin
            valore:=opero(ch);
            push(valore,v[j]);
           end
         end;
       end;
     readln;
     end;
   2:begin
      for j:=1 to n do
       begin
        write('Stampa del valore di verita'' della ',j,' formula ->');
        print(v[j]);
       end;
      readln;
     end;
   3:begin
      control(n,v);
      readln;
     end;
   4:fine;
  end;
 until num=4;
readln;
end.