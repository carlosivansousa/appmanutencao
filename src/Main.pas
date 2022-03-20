unit Main;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Datasnap.DBClient;
type
  TfMain = class(TForm)
    btDatasetLoop: TButton;
    btThreads: TButton;
    btStreams: TButton;
    btExcecao: TButton;
    procedure btDatasetLoopClick(Sender: TObject);
    procedure btStreamsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btExcecaoClick(Sender: TObject);
    procedure btThreadsClick(Sender: TObject);
  private
  public
  end;
var
  fMain: TfMain;

implementation
uses
  DatasetLoop, ClienteServidor, Excecao,Threads;
{$R *.dfm}
procedure TfMain.btDatasetLoopClick(Sender: TObject);
begin
  if fDatasetLoop = nil then
     Application.CreateForm(TfDatasetLoop, fDatasetLoop);
  fDatasetLoop.show;

end;

Procedure TfMain.btStreamsClick(Sender: TObject);
begin
  if fClienteServidor = nil then
     Application.CreateForm(tfClienteServidor, fClienteServidor);
  fClienteServidor.show;

end;
Procedure TfMain.btThreadsClick(Sender: TObject);
begin

   if fThreads = nil then
      Application.CreateForm(tfThreads, fThreads);
   fThreads.show;

end;

Procedure TfMain.FormCreate(Sender: TObject);
begin
    fExcecao.CriaTempLog('0');
end;

Procedure TfMain.btExcecaoClick(Sender: TObject);
begin
   if fExcecao = nil then
      Application.CreateForm(tfExcecao, fExcecao);
   fExcecao.show;

end;


End.
