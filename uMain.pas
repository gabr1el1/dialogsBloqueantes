unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TfrmMain = class(TForm)
    lblMain: TLabel;
    btnShowFrmDatos: TButton;
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnShowFrmDatosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses uData;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmMain.btnShowFrmDatosClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS OR MACOS}
  // Windows specific code here
  frmData.ShowModal;
  {$ELSE}
  //Android/iOS specific code here
  frmData.Show;
  {$ENDIF}
end;

end.
