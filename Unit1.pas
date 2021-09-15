unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SonStream, Bass, ShellAPI, XPMan;

type
  TForm1 = class(TForm)
    ScrollBar1: TScrollBar;
    VolumeSB: TScrollBar;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    NextTrackBtn: TButton;
    Button5: TButton;
    NameTrackLbl: TLabel;
    Timer1: TTimer;
    TimeLbl: TLabel;
    XPManifest1: TXPManifest;
    Button4: TButton;
    Button6: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure WMDropFiles (var Msg: TMessage); message wm_DropFiles;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure VolumeSBChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure NextTrackBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  MAX_SON = 2;

var
  Form1: TForm1;
  TabSon: array[1..MAX_SON] of TSonStream;
  PathFilesList: TStringList;
  PauseTrack: boolean;
  FullTime: string;

implementation

{$R *.dfm}

procedure ListboxRefresh;
var
  i: integer;
begin
  Form1.ListBox1.Clear;
  for i:=0 to PathFilesList.Count - 1 do
    Form1.ListBox1.Items.Add(ExtractFileName(PathFilesList.Strings[i]));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PathFilesList:=TStringList.Create;
  TabSon[1]:=TSonStream.Create;
  VolumeSB.Min:=TabSon[1].GetVolumeMin;
  VolumeSB.Max:=TabSon[1].GetVolumeMax;
  VolumeSB.Position:=TabSon[1].GetVolume;

  DragAcceptFiles(ListBox1.Handle, true);
  Application.Title:=Caption;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PathFilesList.Free;
  TabSon[1].Destroy;
end;

procedure TForm1.VolumeSBChange(Sender: TObject);
begin
  TabSon[1].SetVolume(VolumeSB.Position);
end;

procedure NamedPlay;
begin
  if Length(Form1.ListBox1.Items.Strings[Form1.ListBox1.ItemIndex])>40 then
    Form1.NameTrackLbl.Caption:=Copy(Form1.ListBox1.Items.Strings[Form1.ListBox1.ItemIndex], 1, 37) + '...'
  else
    Form1.NameTrackLbl.Caption:=Form1.ListBox1.Items.Strings[Form1.ListBox1.ItemIndex];
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if (Form1.ListBox1.Items.Count>0) and (Form1.ListBox1.ItemIndex<>0) then begin
    PauseTrack:=false;
    Form1.ListBox1.ItemIndex:=Form1.ListBox1.ItemIndex-1;
    TabSon[1].Charger(PathFilesList.Strings[Form1.ListBox1.ItemIndex]);
    Form1.Scrollbar1.Max:=TabSon[1].LongueurTotal;
    TabSon[1].Lire(True);
  end;
end;

procedure TForm1.NextTrackBtnClick(Sender: TObject);
begin
  if (Form1.ListBox1.Items.Count>0) then begin
    PauseTrack:=false;
    if Form1.ListBox1.Count = Form1.ListBox1.ItemIndex + 1 then
      Form1.ListBox1.ItemIndex:=0
    else
      Form1.ListBox1.ItemIndex:=Form1.ListBox1.ItemIndex + 1;
    TabSon[1].Charger(PathFilesList.Strings[Form1.ListBox1.ItemIndex]);
    Form1.Scrollbar1.Max:=TabSon[1].LongueurTotal;
    TabSon[1].Lire(True);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  TimeCount: string;
begin
  if (ListBox1.Count>0) then begin
    if TabSon[1].LongueurTotal=TabSon[1].PositionEnCours then NextTrackBtn.Click;;
    if TabSon[1].GetNom<>'' then begin
      ScrollBar1.Position:=TabSon[1].PositionEnCours;
      //Времени всего
      FullTime:=IntToStr(Trunc(TabSon[1].GetTempsTotal / 60))+':';
      if Round(TabSon[1].GetTempsTotal-Trunc(TabSon[1].GetTempsTotal / 60)*60) in [0..9] then
        FullTime:=FullTime+'0'+FloatToStr(Round(TabSon[1].GetTempsTotal-Trunc(TabSon[1].GetTempsTotal / 60)*60))
      else FullTime:=FullTime+FloatToStr(Round(TabSon[1].GetTempsTotal-Trunc(TabSon[1].GetTempsTotal / 60)*60));
      //Прошло времени
      TimeCount:=IntToStr(Trunc(TabSon[1].GetTempsEnCours / 60))+':';
      if Round(TabSon[1].GetTempsEnCours-Trunc(TabSon[1].GetTempsEnCours / 60)*60) in [0..9] then
        TimeCount:=TimeCount+'0'+FloatToStr(Round(TabSon[1].GetTempsEnCours-Trunc(TabSon[1].GetTempsEnCours / 60)*60))
      else TimeCount:=TimeCount+FloatToStr(Round(TabSon[1].GetTempsEnCours-Trunc(TabSon[1].GetTempsEnCours / 60)*60));
      TimeLbl.Caption:=TimeCount;
      NamedPlay;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  TabSon[1].Pause;
  TabSon[1].ChangerPosition(0);
  ScrollBar1.Position:=0;
  PauseTrack:=true;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then begin
    TabSon[1].Charger(PathFilesList.Strings[ListBox1.ItemIndex]);
    Scrollbar1.Max:=TabSon[1].LongueurTotal;
    TabSon[1].Lire(True);
    PauseTrack:=false;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ListBox1.count>0 then begin
    if PauseTrack=false then begin
      if ListBox1.ItemIndex=-1 then ListBox1.ItemIndex:=0;
      TabSon[1].Charger(PathFilesList.Strings[ListBox1.ItemIndex]);
      Scrollbar1.Max:=TabSon[1].LongueurTotal;
      TabSon[1].Lire(True);
    end else begin
      PauseTrack:=false;
      TabSon[1].Lire(False);
    end;
  end;
end;

procedure TForm1.WMDropFiles(var Msg: TMessage);
var
  i, Amount, Size, TmpIndex: integer;
  FileName: PChar;
begin
  TmpIndex:=ListBox1.ItemIndex;
  inherited;
  Amount := DragQueryFile(Msg.WParam, $FFFFFFFF, FileName, 255);
  for i:=0 to Amount - 1 do begin
    Size:=DragQueryFile(Msg.WParam, i, nil, 0) + 1;
    FileName:=StrAlloc(size);
    DragQueryFile(Msg.WParam, i, FileName, Size);
    if (Pos('.MP3',AnsiUpperCase(FileName)) > 0) or (Pos('.WAV',AnsiUpperCase(FileName)) > 0) then
      PathFilesList.Add(StrPas(FileName));
    StrDispose(FileName);
  end;
  DragFinish(Msg.WParam);
  ListboxRefresh;
  ListBox1.ItemIndex:=TmpIndex;
  if ListBox1.ItemIndex = -1 then ListBox1.ItemIndex:=0;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  NameTrackLbl.Caption:='Название';
  TimeLbl.Caption:='0:00';
  TabSon[1].Pause;
  TabSon[1].ChangerPosition(0);
  ScrollBar1.Position:=0;
  PauseTrack:=true;
  ListBox1.Clear;
  PathFilesList.Clear;
end;

procedure TForm1.ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  TabSon[1].ChangerPosition(ScrollBar1.Position);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TabSon[1].Pause;
  PauseTrack:=true;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  TmpIndex: integer;
begin
  if OpenDialog1.Execute then begin
    TmpIndex:=ListBox1.ItemIndex;
    PathFilesList.Add(OpenDialog1.FileName);
    ListboxRefresh;
    ListBox1.ItemIndex:=TmpIndex;
  end;
end;

end.
