unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Unit2, Unit3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Tag := Button1.Tag + 1;
  if Button1.Tag > 2 then Button1.Tag := 1;
  Button1.Caption := 'Сложность - ' + IntToStr(Button1.Tag);
end;

procedure TForm1.Button2Click(Sender: TObject);
var fm: TForm2;
begin
  fm := TForm2.Create(Self);
  Form1.Visible := False;
  fm.Tag := Button1.Tag;
  fm.ShowModal;
  if fm.ModalResult = mrClose then Form1.Close;
end;

procedure TForm1.Button3Click(Sender: TObject);
var fm: TForm3;
begin
  fm := TForm3.Create(Self);
  fm.ShowModal;
end;

end.

