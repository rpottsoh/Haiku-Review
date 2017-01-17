program HaikuReview;

uses
  FMX.Forms,
  HaikuReviewMain in 'HaikuReviewMain.pas' {frmHaikuReviewMain},
  uHaiku in 'uHaiku.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHaikuReviewMain, frmHaikuReviewMain);
  Application.Run;
end.
