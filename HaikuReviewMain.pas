unit HaikuReviewMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit, FMX.Types;

type
  TfrmHaikuReviewMain = class(TForm)
    label1: TLabel;
    btnReviewHaiku: TButton;
    fldHaikuToReview: TEdit;
    moResults: TMemo;
    procedure btnReviewHaikuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHaikuReviewMain: TfrmHaikuReviewMain;

implementation
uses uHaiku;

{$R *.fmx}

procedure TfrmHaikuReviewMain.btnReviewHaikuClick(Sender: TObject);
begin
  moResults.Lines.Add(HaikuReview(fldHaikuToReview.Text).ResultStr);
end;

end.
