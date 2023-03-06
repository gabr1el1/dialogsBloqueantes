unit uData;

interface

uses
  System.SysUtils, System.Types,System.IOUtils, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.DialogService;

type
  TfrmData = class(TForm)
    edtData: TEdit;
    btnBack: TButton;
    memLog: TMemo;
    procedure edtDataKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnBackClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmData: TfrmData;
var modificado: boolean;
var CloseOk:boolean;
var wait:boolean;
var ruta: String;

implementation

{$R *.fmx}

uses uMain;

procedure TfrmData.btnBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmData.edtDataKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    // guardar el texto en el memo y limpiarlo
    memLog.Lines.Add(edtData.Text);
    edtData.Text := '';
    modificado:=True;
  end;
end;

procedure TfrmData.FormActivate(Sender: TObject);
begin
if(FileExists(ruta))then
  memLog.Lines.LoadFromFile(ruta);
  //ShowMessage('hola');

end;

procedure TfrmData.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if(modificado and not CloseOk) then
  begin
  CanClose:=False;
   TDialogService.MessageDialog('¿Desea guardar los cambios?' // mensaje del dialogo
      , TMsgDlgType.mtConfirmation // tipo de dialogo
      , [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbCancel] // botones
      , TMsgDlgBtn.mbNo // default button
      , 0 // help context
      ,  procedure(const AResult: TModalResult)
        begin
          case AResult of
            mrYES :
            begin
              memLog.Lines.SaveToFile(ruta);
              CloseOk:=True;
              Close;
              //ShowMessage('aqui');
            end;
            mrNo:
            begin
              CloseOk:=True;
              memLog.Lines.Clear;
              Close;
            end;
          end; // case
      end); // fn

  end;
  if modificado and CloseOk or
  not modificado and not CloseOk then
  begin
    CanClose:=True;
    CloseOk:=False;
    modificado:=False;
  end;
end;
procedure TfrmData.FormCreate(Sender: TObject);
begin
{$IFDEF MSWINDOWS}
ruta:= TPath.Combine('.\','data.txt');
{$ENDIF}
{$IFDEF ANDROID}
ruta:=TPath.Combine(TPath.GetTempPath,'data.txt');
{$ENDIF}
{$IFDEF IOS}
// IOS specific code here
ruta:=TPath.Combine(TPath.GetTempPath,'data.txt');
{$ENDIF}
{$IFDEF MACOS}
// OS X specific code here
ruta:= TPath.Combine('.\','data.txt');
{$ENDIF}
end;

end.
