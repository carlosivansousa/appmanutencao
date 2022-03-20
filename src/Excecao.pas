unit Excecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Datasnap.DBClient,Db,
  Vcl.DBCtrls;

type
  TfExcecao = class(TForm)
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
        function SalvarLog(ADado: String): Boolean;
        function CriaTempLog(Tipo: string): Boolean;
  end;

var
  fExcecao: TfExcecao;
  cdsExcecao: TClientDataset;
  dsExcecao : TDataSource;

implementation

{$R *.dfm}

uses Main;



procedure TfExcecao.FormCreate(Sender: TObject);
begin
   DBMemo1.DataSource :=  dsExcecao;
   DBMemo1.DataField  := 'LogExcecao';
   DBMemo1.clear;

end;

function TfExcecao.SalvarLog(ADado: String): Boolean;
begin
    cdsExcecao.Append;
    cdsExcecao.FieldByName('LogExcecao').AsString := Adado;
    cdsExcecao.Post;
    Result := True;
end;


function TfExcecao.CriaTempLog(Tipo: String): Boolean;
var cdsExcecao : TClientDataSet;
      dsExcecao: TDataSource;
begin
  cdsExcecao := TClientDataSet.Create(nil);
  cdsExcecao.Close;
  cdsExcecao.FieldDefs.Clear;
  cdsExcecao.FieldDefs.add('LogExcecao',ftString,150);
  cdsExcecao.CreateDataSet;

  dsExcecao := TDataSource.Create(nil);
  dsExcecao.DataSet := cdsExcecao;
  Result := True;

end;



end.
