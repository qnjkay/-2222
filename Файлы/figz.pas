unit FigZ;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Cube, Figure;

Type
  TFigZ = Class(TFigure)
    public
      constructor Create(color: TColor; row, col: byte; size: byte);
  end;

implementation

constructor TFigZ.Create(color: TColor; row, col: byte; size: byte);
begin
  inherited Create(color, row, col, size);
  SetLength(cubes_, 2);
  {
      [][]
    [][]
  }
  SetLength(cubes_[0], 4);
  cubes_[0][0] := TCube.Create(color_, 0, 0, size_);
  cubes_[0][1] := TCube.Create(color_, 0, 1, size_);
  cubes_[0][2] := TCube.Create(color_, 1, 1, size_);
  cubes_[0][3] := TCube.Create(color_, 1, 2, size_);
  {
    []
    [][]
      []
  }
  SetLength(cubes_[1], 4);
  cubes_[1][0] := TCube.Create(color_, 0, 1, size_);
  cubes_[1][1] := TCube.Create(color_, 1, 0, size_);
  cubes_[1][2] := TCube.Create(color_, 1, 1, size_);
  cubes_[1][3] := TCube.Create(color_, 2, 0, size_);
end;

end.
