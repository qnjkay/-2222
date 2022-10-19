unit Figure;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Cube;

Type
  TFigure = Class
    protected
      size_: byte; //размер кубика
      row_, col_: integer; //текущее положение фигуры в стакане
      cubes_: array of array of TCube; //фигура
      color_: TColor; //цвет фигуры
      form_: byte; //текущая форма фигуры
    public
      constructor Create(color: TColor; row, col: byte; size: byte);
      constructor Create(f: TFigure);
      procedure Draw(canvas: TCanvas);
      procedure Rotation();
      procedure Move(st: byte);
      function getRow: integer;
      function getCol: integer;
      function getForm: byte;
      function getNumCubes: byte;
      function getCube(num: byte): TCube;
      procedure setRowCol(row: byte; col: byte);
      procedure setRow(row: byte);
      procedure setCol(col: byte);
  end;

implementation

function TFigure.getNumCubes: byte;
begin
  getNumCubes := Length(cubes_[form_]);
end;

function TFigure.getCube(num: byte): TCube;
begin
  getCube := cubes_[form_][num];
end;

function TFigure.getRow: integer;
begin
  getRow := row_;
end;

function TFigure.getCol: integer;
begin
  getCol := col_;
end;

function TFigure.getForm: byte;
begin
  getForm := form_;
end;

procedure TFigure.setRowCol(row: byte; col: byte);
begin
  row_ := row;
  col_ := col;
end;

procedure TFigure.setRow(row: byte);
begin
  row_ := row;
end;

procedure TFigure.setCol(col: byte);
begin
  col_ := col;
end;

constructor TFigure.Create(color: TColor; row, col: byte; size: byte);
begin
  size_ := size;
  color_ := color;
  form_ := 0;
  row_ := row;
  col_ := col;
end;

constructor TFigure.Create(f: TFigure);
var i, j, n: byte;
begin
  size_ := f.size_;
  color_ := f.color_;
  form_ := f.form_;
  row_ := f.row_;
  col_ := f.col_;
  n := Length(f.cubes_);
  SetLength(cubes_, n);
  for i := 0 to n - 1 do
  begin
    SetLength(cubes_[i], Length(f.cubes_[i]));
    for j := 0 to  Length(f.cubes_[i]) - 1 do
      cubes_[i][j] := TCube.Create(f.cubes_[i][j].getColor,
      f.cubes_[i][j].getRow, f.cubes_[i][j].getCol, f.cubes_[i][j].getSize);
  end;
end;

procedure TFigure.Rotation();
begin
  form_ := form_ + 1;
  if form_ >= Length(cubes_) then form_ := 0;
end;

procedure TFigure.Move(st: byte);
var i: byte;
begin
  case st of
    0: Rotation;
    1: col_ := col_ - 1;
    2: col_ := col_ + 1;
    3: row_ := row_ + 1;
  end;
end;

procedure TFigure.Draw(canvas: TCanvas);
var i: byte;
begin
  canvas.Brush.Color := color_;
  for i := 0 to Length(cubes_[form_]) - 1 do
    cubes_[form_][i].Draw(canvas, row_, col_);
end;

end.
