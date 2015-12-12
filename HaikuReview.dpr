program HaikuReview;

uses
  FMX.Forms,
  HaikuReviewMain in 'HaikuReviewMain.pas' {frmHaikuReviewMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHaikuReviewMain, frmHaikuReviewMain);
  Application.Run;
end.
