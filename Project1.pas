program Project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,sysutils;

var

  input:ansistring;
  PlayersTurn: boolean;
  Coin: Longint;

  Board: array[0..8] of char = (' ',' ',' ',' ',' ',' ',' ',' ',' ');

procedure DisplayBoard(Board: array of char);
begin
 writeln('  |A|B|C|');
 writeln('  ------');
 write('1)|');write(Board[0]);write('|');write(Board[1]);write('|');write(Board[2]);writeln('|');
 writeln('  ------');
 write('2)|');write(Board[3]);write('|');write(Board[4]);write('|');write(Board[5]);writeln('|');
 writeln('  ------');
 write('3)|');write(Board[6]);write('|');write(Board[7]);write('|');write(Board[8]);writeln('|');


end;

procedure RecordMove();
var

ValidMove: boolean;

begin


 repeat
 ValidMove := true;
 writeln('Enter in a column row combination....example "A1" ');
 readln(input);
if(SameText('A1',input) and (Board[0]=' ')) then Board[0]:='X'
  else if(SameText('A2',input)and (Board[3]=' ')) then Board[3]:='X'
  else if(SameText('A3',input)and (Board[6]=' ')) then Board[6]:='X'
  else if(SameText('B1',input)and (Board[1]=' ')) then Board[1]:='X'
  else if(SameText('B2',input)and (Board[4]=' ')) then Board[4]:='X'
  else if(SameText('B3',input)and (Board[7]=' ')) then Board[7]:='X'
  else if(SameText('C1',input)and (Board[2]=' ')) then Board[2]:='X'
  else if(SameText('C2',input)and (Board[5]=' ')) then Board[5]:='X'
  else if(SameText('C3',input)and (Board[8]=' ')) then Board[8]:='X'
  else
    begin
    writeln('Invalid move');
    ValidMove := false
    end;
  until ValidMove = true;


end;

procedure RecordAI();
var
AIhadaturn: boolean;
AIchoice: Longint;
begin

repeat
AIchoice := Random(9);
AIhadaturn := true;
 if((Board[AIchoice]=' ')) then Board[AIchoice]:='O'
 else AIhadaturn := false;

 until AIhadaturn = true;


 writeln('AI turn over');

end;

function Referee(): boolean;
var
  RefResult,Player1Result,AIResult:boolean;
  i:integer;

begin
Player1Result:=false;
AIResult:=false;


if (board[0]='X') and (board[1]='X') and (board[2]='X') then Player1Result:=true;
if (board[3]='X') and (board[4]='X') and (board[5]='X') then Player1Result:=true;
if (board[6]='X') and (board[7]='X') and (board[8]='X') then Player1Result:=true;

if (board[0]='X') and (board[4]='X') and (board[8]='X') then Player1Result:=true;
if (board[2]='X') and (board[4]='X') and (board[6]='X') then Player1Result:=true;

if (board[0]='X') and (board[3]='X') and (board[6]='X') then Player1Result:=true;
if (board[1]='X') and (board[4]='X') and (board[7]='X') then Player1Result:=true;
if (board[2]='X') and (board[5]='X') and (board[8]='X') then Player1Result:=true;

if (board[0]='O') and (board[1]='O') and (board[2]='O') then AIResult:=true;
if (board[3]='O') and (board[4]='O') and (board[5]='O') then AIResult:=true;
if (board[6]='O') and (board[7]='O') and (board[8]='O') then AIResult:=true;

if (board[0]='O') and (board[4]='O') and (board[8]='O') then AIResult:=true;
if (board[2]='O') and (board[4]='O') and (board[6]='O') then AIResult:=true;

if (board[0]='O') and (board[3]='O') and (board[6]='O') then AIResult:=true;
if (board[1]='O') and (board[4]='O') and (board[7]='O') then AIResult:=true;
if (board[2]='O') and (board[5]='O') and (board[8]='O') then AIResult:=true ;

if  Player1Result=true  then
    begin
    writeln('Player 1 has one the match');
    RefResult := false;
    end
else if AIResult=true then
    begin
    writeln('AI wins the match');
    RefResult := false;
    end
else
    begin

    RefResult:=false;
     for i:=0 to 8 do
     begin
          if(Board[i]=' ') then
          begin
          RefResult:=true;
          end;

     end;



     if (RefResult = true) then writeln('Referee says there are more moves to be made');
     end;

     Referee:=RefResult;

end;




begin
  writeln('--Matts Os and Xs--');

  Randomize;
  Coin:=Random(2);

  writeln('Binary coin flipped: ',Coin);
  if(Coin=1) then
  begin
  writeln('Player 1 goes first');
  PlayersTurn := true;
  end
  else
  begin
   writeln('AI will go first');
   PlayersTurn:=false;
  end;






   DisplayBoard(Board);

repeat

if(PlayersTurn = true) then
   begin
   RecordMove();
   PlayersTurn := false;
   end
else
    begin
   RecordAI();
   PlayersTurn:=true;
    end;
  DisplayBoard(Board);
  until Referee()= false;




readln(input);


end.

