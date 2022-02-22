Program villaggio(Input,Output);

TYPE

stato=(adulto,bambino);

passatempi=record
 sport:string;
 hobbies:string;
 divertimenti:string;
end;

individuo=record
 nome:string;
 cognome:string;
 eta:integer;
 case st:stato of
  bambino:(sesso_b:char;eta_b:integer);
  adulto:(sesso:char;passatempo:passatempi);
end;

parenti=record
 tipopar:string;
 dati:individuo;
end;

v_par=array [1..5] of parenti;

famiglia=record
 capo:individuo;
 componenti:v_par;
 num_comp:integer;
 passatempo:passatempi;
end;

v=array [1..5] of famiglia;

VAR
 i,j,n1,n2,num:integer;
 fam:v;
 par:v_par;
 passa:passatempi;

PROCEDURE insert_pass(i,j:integer);
VAR
 car:char;
BEGIN
 i:=1;
 j:=1;
 if fam[i].componenti[j].dati.eta>=18 then
  begin
   fam[i].componenti[j].dati.st:=adulto;
   writeln('Ha qualche passatempo come sport,divertimenti,hobbies?');
   writeln('Digitare "s" per si "n" per no');
   readln(car);
   if car='s' then
    begin
     writeln('Quale sport pratica?');
     readln(fam[i].passatempo.sport);
     writeln('Quale divertimento in particolare?');
     readln(fam[i].passatempo.divertimenti);
     writeln('Quale hobbies?');
     readln(fam[i].passatempo.hobbies);
    end
   else writeln('Nessun passatempo');
  end
 else fam[i].componenti[j].dati.st:=bambino;
END;

PROCEDURE insert_dati1(i,j:integer);
BEGIN
 i:=1;
 j:=1;
 with fam[i].componenti[j].dati do
 begin
  writeln('Inserire il nome del parente:');
  readln(nome);
  writeln('Inserirne il cognome:');
  readln(cognome);
  writeln('Inserirne l''eta''');
  readln(eta);
  writeln('Inserirne il sesso "m" per maschio ed "f" per femmina:');
  readln(sesso);
 end;
END;{insert_dati}

PROCEDURE component(var n2:integer);
VAR
 i,j:integer;
 car:char;
BEGIN
 writeln('Esistono altri componenti del nucleo familiare?');
 writeln('Digitare "s" per si "n" per no:');
 readln(car);
 if car='s' then
  begin
   writeln('Quanti? :');
   readln(n2);
   for j:=1 to n2 do
    begin
     writeln('Inserire il tipo di parentela del ',j,' componente:');
     readln(fam[i].componenti[j].tipopar);
     insert_dati1(i,j);
     insert_pass(i,j);
    end;
   fam[i].num_comp:=n2;
   end
 else
 fam[i].num_comp:=0;
 writeln('Nessun altro componente dichiarato');
END;{componenti}

PROCEDURE insert(var n1,n2:integer);
VAR
 n,i,j:integer;
 car:char;
BEGIN
 i:=0;
 repeat
  i:=i+1;
  writeln('********************************************************');
  writeln('******** Inserire il nome del ',i,'ø capofamiglia ******');
  writeln('* Digitare stop per finire la procedura di inserimento *');
  writeln('********************************************************');
  fam[i].capo.st:=adulto;
  with fam[i].capo do
  begin
   readln(nome);
   if fam[i].capo.nome<>'stop' then
    begin
     writeln('Inserirne il cognome:');
     readln(cognome);
     writeln('Inserirne l''eta'':');
     readln(eta);
     writeln('Inserirne il sesso "m" per maschio ed "f" per femmina:');
     readln(sesso);
     component(n2);
    end;
  end;
 until fam[i].capo.nome='stop';
 n1:=i-1;
END;

PROCEDURE stampa(var n1,n2:integer);
VAR      {come faccio ad importare in una procedura }
         {i valori delle variabili di  altre procedure?(n1,n2,i,j)}
i,j:integer;
BEGIN
 writeln('Stampa degli archivi');
 j:=0;
 for i:=1 to n1 do
  begin
   j:=j+1;
   writeln('Nome e cognome dell'' ',i,' capofamiglia ');
   writeln('Nome:',fam[i].capo.nome,' Cognome:',fam[i].capo.cognome);
   writeln('Nome degli altri componenti del nucleo familiare');
   if n1<>0 then
    begin
     writeln('Tipo parentela con il capofamiglia:',fam[i].componenti[j].tipopar);
     writeln('Nome:',fam[i].componenti[j].dati.nome)
    end
   else writeln('Nessun altro componente dichiarato');
   if fam[i].componenti[j].dati.st=adulto then
    begin
     writeln('Sesso e passatempi preferiti di ogni adulto della famiglia');
     writeln('Sesso:',fam[i].componenti[j].dati.sesso);
     with fam[i].passatempo do
      begin
       writeln('Sport:',sport);
       writeln('Divertimenti preferiti:',divertimenti);
       writeln('Hobbies:',hobbies);
      end;
    end;
   if fam[i].componenti[j].dati.st=bambino then
    begin
     writeln('Sesso ed eta'' per ogni bambimo della famiglia');
     writeln('Sesso:',fam[i].componenti[j].dati.sesso_b);
     writeln('Eta'':',fam[i].componenti[j].dati.eta_b);
    end;
 end;
END;{stampa}

PROCEDURE fine;
BEGIN
 writeln('Termine momentaneo dell'' utilizzo del programma');
END; {fine}

BEGIN{***MAIN PROGRAM***}
 repeat
  begin
   writeln('--------------------------');
   writeln('***Inserire una scelta****');
   writeln('*fra quelle sottoelencate*');
   writeln('1) Inserimento -----------');
   writeln('2) Stampa      -----------');
   writeln('3) Fine        -----------');
   writeln('--------------------------');
   readln(num);
   case num of
    1:insert(n1,n2);
    2:stampa(n1,n2);
    3:fine;
   end;
  end;
 until num=3;

readln;
END.