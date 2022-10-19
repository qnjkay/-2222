unit Cube;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

Type
  TCube = Class
    protected
      size_: byte; //размер квадрата
      row_, col_: byte; //текущее положение кубика в фигуре
      color_: TColor; //цвет квадрата
    public
      constructor Create(color: TColor; row, col: byte; size: byte);
      constructor Create(cube: TCube);
      procedure Draw(canvas: TCanvas; row, col: byte);
      function getRow: byte;
      function getCol: byte;
      function getSize: byte;
      function getColor: TColor;
      procedure setRow(row: byte);
      procedure setCol(col: byte);
      procedure setRowCol(row, col: byte);
  end;

implementation

function TCube.getColor: TColor;
begin
  getColor := color_;
end;

function TCube.getRow: Byte;
begin
  getRow := row_;
end;

function TCube.getSize: Byte;
begin
  getSize := size_;
end;

function TCube.getCol: Byte;
begin
  getCol := col_;
end;

procedure TCube.setRow(row: byte);
begin
  row_ := row;
end;

procedure TCube.setRowCol(row, col: byte);
begin
  row_ := row;
  col_ := col;
end;

procedure TCube.setCol(col: byte);
begin
  col_ := col;
end;

constructor TCube.Create(color: TColor; row, col: byte; size: byte);
begin
  size_ := size;
  color_ := color;
  row_ := row;
  col_ := col;
end;

constructor TCube.Create(cube: TCube);
begin
  size_ := cube.size_;
  color_ := cube.color_;
  row_ := cube.row_;
  col_ := cube.col_;
end;

procedure TCube.Draw(canvas: TCanvas; row, col: byte);
begin
  canvas.Brush.Color := color_;
  canvas.Rectangle(
                   (col + col_) * size_, (row - row_) * size_,
                   (col + col_ + 1) * size_, (row - row_ - 1) * size_);
end;

end.
