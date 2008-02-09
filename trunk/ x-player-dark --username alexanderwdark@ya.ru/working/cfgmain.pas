unit cfgmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cfg, ExtCtrls;

type
  TForm1 = class(TForm)
    opt: TComboBox;
    mem: TMemo;
    theval: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure Button2Click(Sender: TObject);
    procedure optSelect(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var cfg:TCFG; it:TStringList;
begin
button1.Enabled:=false;
theval.Clear;
mem.Clear;
cfg:=tcfg.Create(extractfilepath(application.ExeName)+'options.ini');
it:=TStringList.Create;
cfg.ImportNames(it);
opt.Items.Assign(it);
it.Free;
cfg.Free;
end;

procedure TForm1.optSelect(Sender: TObject);
var cfg:TCFg;
begin
theval.Clear;
mem.Clear;
if opt.ItemIndex=-1 then exit;
button1.Enabled:=opt.ItemIndex<>-1;
cfg:=tcfg.Create(extractfilepath(application.ExeName)+'options.ini');
theval.Text:=cfg.ReadString(opt.Items[opt.itemindex],'');
cfg.Free;
cfg:=tcfg.Create(extractfilepath(application.ExeName)+'options.darkcfg');
mem.Text:=cfg.ReadString(opt.Items[opt.itemindex],'');
if mem.Text='' then mem.Text:=format('Описания для настройки %s не имеется',[opt.Items[opt.itemindex]]);
cfg.Free;
end;
procedure TForm1.FormActivate(Sender: TObject);
begin
button2.Click;
onactivate:=nil;
end;

procedure TForm1.Button1Click(Sender: TObject);
var cfg:TCFg;
begin
if opt.ItemIndex=-1 then
begin
showmessage('Для начала следует выбрать опцию.');
exit;
end;
cfg:=tcfg.Create(extractfilepath(application.ExeName)+'options.ini');
cfg.WriteString(opt.Items[opt.itemindex],theval.Text);
cfg.Free;
end;

end.
