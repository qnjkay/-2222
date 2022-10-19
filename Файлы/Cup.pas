unit Cup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Cube, Figure, FigI, FigT, FigL, FigZ, FigH;

Type
  TCup = Class
    private
      cols_: byte; //число кубиков по горизонтали
      rows_: byte; //число кубиков по вертикали
      size_: byte; //размер кубика
      cfig_: TFigure; //текущая фигура
      nfig_: TFigure; //следующая фигура
      cline_: word; //число удалённых рядов
      cubes_: array of array of TCube; //содержимое "стакана"
    public
      constructor Create(cols: byte; rows: byte; size: byte);
      function RandFigure(row, col: byte): TFigure;
      function Draw(st: byte; canvas_m: TCanvas; canvas_s: TCanvas): boolean;
      procedure ClearLine();
      function isMove(st: byte): integer;
      function getClearLine(): word;
  end;

implementation

function TCup.RandFigure(row, col: byte): TFigure;
var f: TFigure;
begin
  case Random(5) of
    0: f := TFigI.Create(clRed, row, col, size_);
    1: f := TFigT.Create(clBlue, row, col, size_);
    2: f := TFigL.Create(clYellow, row, col, size_);
    3: f := TFigZ.Create(clGreen, row, col, size_);
    4: f := TFigH.Create(clAqua, row, col, size_);
  end;
  RandFigure := f;
end;

constructor TCup.Create(cols: byte; rows: byte; size: byte);
var i, j: word;
begin
  Randomize;
  cols_ := cols;
  rows_ := rows;
  size_ := size;
  SetLength(cubes_, rows_, cols_);
  for i := 0 to rows_ - 1 do
    for j := 0 to cols_ - 1 do
    begin
      cubes_[i, j] := TCube.Create(clBlack, i, j, size_);
    end;
  cfig_ := RandFigure(0, cols_ div 2 - 1);
  nfig_ := RandFigure(2, 0);
  cline_:= 0;
end;

procedure TCup.ClearLine();
var i, j, k: integer;
begin
  i := rows_ - 1;
  while i >= 0 do
  begin
    j := 0;
    while (j < cols_) and (cubes_[i, j].GetColor <> clBlack) do
        j := j + 1;
    if j = cols_ then
    begin
      for k := i downto 1 do
        for j := 0 to cols_ - 1 do
          cubes_[k, j] := TCube.Create(cubes_[k - 1, j]);
      for j := 0 to cols_ - 1 do
        cubes_[0, j] := TCube.Create(clBlack, 0, j, size_);
      cline_:= cline_ + 1;
    end
    else
      i := i - 1;
  end;
end;

function TCup.getClearLine(): word;
begin
  getClearLine := cline_;
end;

function TCup.isMove(st: byte): integer;
var t: TFigure;
    i: byte;
    b, r, c: integer;
begin
  t := TFigure.Create(cfig_);
  t.Move(st);
  b := 1;
  i := 0;
  while (i < t.getNumCubes) and (b = 1) do
  begin
    c := t.getCol + t.getCube(i).getCol;
    r := abs(t.getRow - t.getCube(i).getRow);
    if (c < 0) or (c >= cols_) or (r >= rows_) then b := 0;
    if (b = 1) and (cubes_[r, c].getColor <> clBlack) then b := 0;
    i := i + 1;
  end;
  if ((b = 0) and (r < 2)) then b := -1;
  isMove := b;
end;

function TCup.Draw(st: byte; canvas_m: TCanvas; canvas_s: TCanvas): boolean;
var i, j, r, c: byte;
    b: integer;
begin
  b := isMove(st);
  if b >= 0 then
  begin
    if (st = 3) and (b = 0) then
    begin
      for i := 0 to cfig_.getNumCubes - 1 do
      begin
        r := abs(cfig_.getRow - cfig_.getCube(i).getRow);
        c :=  cfig_.getCol + cfig_.getCube(i).getCol;
        cubes_[r, c] := cfig_.getCube(i);
        cubes_[r, c].setRowCol(0, 0);
      end;
      ClearLine();
      cfig_ := nfig_;
      cfig_.setRowCol (0, cols_ div 2 - 1);
      nfig_ := RandFigure(2, 0);
    end
    else
    begin
      if b > 0 then
      begin
        cfig_.Move(st);
      end;
    end;
    canvas_s.Brush.Color := clBlack;
    canvas_s.FillRect(Rect(0, 0, canvas_s.Width, canvas_s.Height));
    canvas_m.Brush.Color := clBlack;
    canvas_m.FillRect(Rect(0, 0, canvas_m.Width, canvas_m.Height));
    nfig_.Draw(canvas_s);
    for i := 0 to rows_ - 1 do
      for j := 0 to cols_ - 1 do
        if cubes_[i, j].GetColor <> clBlack then
          cubes_[i, j].Draw(canvas_m, i + 1, j);
    cfig_.Draw(canvas_m);
    Draw := true;
  end
  else
    Draw := false;
end;

end.
