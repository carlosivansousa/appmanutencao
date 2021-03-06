unit ClienteServidor;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Datasnap.DBClient, Data.DB,Excecao;
type
  TServidor = class
  private
    FPath: AnsiString;
  public
    constructor Create;
    //Tipo do par?metro n?o pode ser alterado
    function SalvarArquivos(AData: OleVariant): Boolean;
  end;
  TfClienteServidor = class(TForm)
    ProgressBar: TProgressBar;
    btEnviarSemErros: TButton;
    btEnviarComErros: TButton;
    btEnviarParalelo: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btEnviarSemErrosClick(Sender: TObject);
    procedure btEnviarComErrosClick(Sender: TObject);
  private
    FPath: AnsiString;
    FServidor: TServidor;
    function InitDataset: TClientDataset;
    procedure ApagaArquivos(Sender: TObject);
  public
  end;
var
  fClienteServidor: TfClienteServidor;
const
  QTD_ARQUIVOS_ENVIAR = 10;
implementation
uses
  IOUtils;
{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}
procedure TfClienteServidor.btEnviarComErrosClick(Sender: TObject);
var
  cds: TClientDataset;
  i: Integer;
begin
  cds := InitDataset;
  for i := 0 to QTD_ARQUIVOS_ENVIAR do
  begin
    cds.Append;
    TBlobField(cds.FieldByName('Arquivo')).LoadFromFile(String(FPath));
    cds.Post;
    {$REGION Simula??o de erro, n?o alterar}
    if i = (QTD_ARQUIVOS_ENVIAR/2) then
      FServidor.SalvarArquivos(NULL);
    {$ENDREGION}
  end;

  try
     FServidor.SalvarArquivos(cds.Data);
  finally
    ApagaArquivos(self);
  end;

  FServidor.Free;
end;

procedure TfClienteServidor.btEnviarSemErrosClick(Sender: TObject);
var
  cds: TClientDataset;
  i,incprog: Integer;
begin
  cds        := InitDataset;
  cdsExcecao := InitDataset; { controle da excecao }
  ProgressBar.Max:= QTD_ARQUIVOS_ENVIAR; incprog:=0;
  for i := 0 to QTD_ARQUIVOS_ENVIAR -1 do
  begin
      Try
         cds.Append;
         TBlobField(cds.FieldByName('Arquivo')).LoadFromFile(String(FPath));
         cds.Post;
      Except
         on E : Exception do
         begin
            fExcecao.SalvarLog('Houve uma excecao. Por favor verifique.');
            Showmessage('Um erro n?o tratado foi gerado!! Erro :' + E.Message + #13 + 'Classe: ' + E.ClassName  );
         end;
      end;
  end;
  inc(incprog);
  ProgressBar.Position := incprog;
  Application.ProcessMessages;

  ProgressBar.Position := 0;
  FServidor.SalvarArquivos(cds.Data);
  FServidor.Free;
end;


procedure TfClienteServidor.FormCreate(Sender: TObject);
begin
  inherited;
  FPath := AnsiString(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + 'pdf.pdf');
  FServidor := TServidor.Create;
end;
function TfClienteServidor.InitDataset: TClientDataset;
begin
  Result := TClientDataset.Create(nil);
  Result.FieldDefs.Add('Arquivo', ftBlob);
  Result.CreateDataSet;
end;
{ TServidor }
constructor TServidor.Create;
begin
  FPath := AnsiString(ExtractFilePath(ParamStr(0)) + 'Servidor\');
end;

function TServidor.SalvarArquivos(AData: OleVariant): Boolean;
var
  cds: TClientDataSet;
  FileName: string;
begin
  Result := False;

  try
      cds := TClientDataset.Create(nil);
      cds.Data := AData;
      {$REGION Simula??o de erro, n?o alterar}
      if cds.RecordCount = 0 then
        Exit;
      {$ENDREGION}
      cds.First;
      while not cds.Eof do
      begin
        FileName := String(FPath) + cds.RecNo.ToString + '.pdf';
        if TFile.Exists(FileName) then
          TFile.Delete(FileName);
        TBlobField(cds.FieldByName('Arquivo')).SaveToFile(FileName);
        cds.Next;
      end;
      Result := True;
  except
      on E : Exception do
      begin
         fExcecao.SalvarLog('Houve uma excecao. Por favor verifique.');
         Showmessage('Um erro n?o tratado foi gerado!! Erro :' + E.Message + #13 + 'Classe: ' + E.ClassName  );
         raise;
      end;

  end;
end;


procedure TfClienteServidor.ApagaArquivos(Sender: TObject);
var
  SR: TSearchRec;
  I: integer;
  GPath,vCaminho: string;
begin
    vCaminho := String(AnsiString(ExtractFilePath(ParamStr(0)) + 'Servidor\'));
    GPath := String(AnsiString(ExtractFilePath(ParamStr(0)) + 'Servidor\*.*'));
    I := FindFirst(GPath, faAnyFile, SR);
    while I = 0 do
    begin
        if (SR.Attr and faDirectory) <> faDirectory then
          if not DeleteFile(vCaminho + SR.Name) then
              ShowMessage('N?o foi poss?vel excluir '+ vCaminho + SR.Name);

        I := FindNext(SR);
    end;
end;

end.
