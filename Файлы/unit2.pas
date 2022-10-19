unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Game;

type

  { TForm2 }

  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  gm: TGame;
implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Timer1.Enabled then
  begin
    case key of
      38: gm.Next(0, Image1.Canvas, Image2.Canvas);
      37: gm.Next(1, Image1.Canvas, Image2.Canvas);
      39: gm.Next(2, Image1.Canvas, Image2.Canvas);
      40: gm.Next(3, Image1.Canvas, Image2.Canvas);
    end;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  Image1.Parent.DoubleBuffered := True;
  gm := TGame.Create(9, 14, 20);
  if Self.Tag = 2 then
    Timer1.Interval := 400;
end;

procedure TForm2.Label2Click(Sender: TObject);
begin

end;

procedure TForm2.Panel1Click(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
end;

procedure TForm2.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TPanel).BevelInner := bvLowered;
end;

procedure TForm2.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TPanel).BevelInner := bvNone;
end;

procedure TForm2.Panel2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  if gm.Next(3, Image1.Canvas, Image2.Canvas) then
    Panel3.Caption := IntToStr(gm.GetScore())
  else
  begin
    Timer1.Enabled := false;
    ShowMessage('Игра окончена!');
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  ModalResult := mrClose;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

end.

