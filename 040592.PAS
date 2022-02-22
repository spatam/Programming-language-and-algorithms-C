PROGRAM palindroma(Input,Output);

TYPE
 lettere= 'a'..'z';
 letterset= set of lettere;

VAR
 par,parola,parola1:string[25];{perche' parola1 devo metterle come variabili globali?}
 n:integer;
 flag:boolean;
 alfabeto:letterset;

FUNCTION count(parola:string):integer;
VAR
 i:integer;
BEGIN
 i:=1;
 while parola[i]<>' ' do i:=i+1;
 count:=i-1;
 writeln('La parola e'' lunga ',i-1);
END;{count}

PROCEDURE control(parola:string);
VAR
 i,j,n:integer;
 flag:boolean;

BEGIN
 n:=count(parola);
 i:=1;
 j:=n;
 flag:=false;
 while (i<=(n div 2)) and (not flag) do
  begin
   if parola[i]=parola[n] then flag:=true
   else i:=i+1;
        j:=j-1;
  end;
 if flag then writeln('La parola ',parola,' e'' palindroma')
 else         writeln('La parola ',parola,' non e'' palindroma');
END; {lenght}

FUNCTION copy(parola:string):string;
VAR
 i,j,n:integer;
 parola1:array[1..50] of char;

BEGIN
 j:=0;
 n:=count(parola);
 writeln('devo ripulire la stringa ',parola);
 for i:=1 to n do
  if parola[i] in ['a'..'z'] then
   begin
     j:=j+1;
    parola1[j]:=parola[i];
   end;
 copy:=parola1;
 writeln('La parola da esaminare e'' ',parola1);
END; {copy}

BEGIN {main program}
 writeln('***Questo programma verifica se una parola e'' palindroma***');
 writeln('Inserire la parola concludendo con un carattere di tipo eof prego');
 readln(parola);
 par:=copy(parola);
 writeln('la parola ripulita Š ',par);
 control(parola1);
readln;
END.{main program}