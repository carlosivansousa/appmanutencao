unit Threads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,System.Threading;

type
  TfThreads = class(TForm)
    EdNumThread: TEdit;
    MemTherad: TMemo;
    btExecuta: TButton;
    edTempo: TEdit;
    ProgressBar: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure btExecutaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Iteracao1;
    procedure Iteracao2;
  end;

var
  fThreads: TfThreads;
  FimThread :integer;

implementation

{$R *.dfm}

procedure TfThreads.Button1Click(Sender: TObject);
begin
  exit;
end;

procedure TfThreads.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

   if FimThread = 0 then
   begin
     ShowMessage('Por favor, espere o t?rmino do processo');
     CanClose := False;
   end
   else
      CanClose := True;

end;

procedure TfThreads.FormCreate(Sender: TObject);
begin
   FimThread := 1;
end;

procedure TfThreads.Iteracao1;
var i,incprog,id: Integer;

begin
    Randomize;
    MemTherad.lines.add('1540 ? Iniciando processamento');
    id := 1540;
    for i:= 0 to 100 do
    begin
       id := id+i;
       MemTherad.lines.add(intToStr(id)+ ' Processamento');
       incprog := i;
       ProgressBar.Position := incprog;
       Sleep(Random(StrToInt(edTempo.text)));
    end;
   MemTherad.lines.add(intToStr(id)+ ' Processamento Finalizado');
end;


procedure TfThreads.Iteracao2;
var i,incprog,id: Integer;
begin
    Randomize;
    MemTherad.lines.add('1541 ? Iniciando processamento');
    id := 1541;
    for i:= 0 to 100 do
    begin
        id := id+i;
        MemTherad.lines.add(intToStr(id)+ ' Processamento');
        incprog := i;
        ProgressBar.Position := incprog;
        Sleep(Random(StrToInt(edTempo.text)));
    end;
   MemTherad.lines.add(intToStr(id)+ ' Processamento Finalizado');
end;


procedure TfThreads.btExecutaClick(Sender: TObject);
var
  Tasks: array [0..2] of ITask;
  Inicio: TDateTime;
  Fim: TDateTime;
begin
    FimThread := 0;
    MemTherad.clear;
    Inicio := Now;

    ProgressBar.Min := 0;
    ProgressBar.Max:= 100 * StrToInt(EdNumThread.text);

    Tasks[0] := TTask.Create(Iteracao1);
    Tasks[0].Start;

    Tasks[1] := TTask.Create(Iteracao2);
    Tasks[1].Start;

    TTask.WaitForAll(Tasks);
    Fim := Now;
    ShowMessage(Format('Consultas realizadas em %s segundos.', [FormatDateTime('ss', Fim - Inicio)]));
    FimThread := 1;

end;

end.

