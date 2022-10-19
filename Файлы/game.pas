unit Game;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Cube, Figure, Cup;

Type
  TGame = Class
    private
      cup_: TCup;
      score_: Word;
    public
      constructor Create(cols: byte; rows: byte; size: byte);
      function Next(st: byte; canvas_m: TCanvas; canvas_s: TCanvas): boolean;
      function GetScore(): word;
  end;

implementation

function TGame.GetScore(): word;
begin
  GetScore := cup_.getClearLine * 10;
end;

constructor TGame.Create(cols: byte; rows: byte; size: byte);
begin
  cup_ := TCup.Create(cols, rows, size);
  score_ := 0;
end;

function TGame.Next(st: byte; canvas_m: TCanvas; canvas_s: TCanvas): boolean;
begin
  Next := cup_.Draw(st, canvas_m, canvas_s);
end;

end.
