unit HaikuReviewMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.StrUtils, FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit;

const Vowels : TSysCharSet = ['a','e','i','o','u','y'];
      CorrectSyllableCount : array[0..2] of integer = (5,7,5);

type
  TfrmHaikuReviewMain = class(TForm)
    label1: TLabel;
    btnReviewHaiku: TButton;
    fldHaikuToReview: TEdit;
    moResults: TMemo;
    procedure btnReviewHaikuClick(Sender: TObject);
  private
    { Private declarations }
    function ReviewHaiku(inStr : string): string;
    function isVowel(inChar : char):boolean;
    function NumberOfLines(inStr : string): integer;
    function getLines(inStr : string): TStringlist;
    function getWords(inStr : string): TStringlist;
    function CountSyllables(Words : TStringList): integer;
  public
    { Public declarations }
  end;

var
  frmHaikuReviewMain: TfrmHaikuReviewMain;

implementation

{$R *.fmx}

function TfrmHaikuReviewMain.isVowel(inChar : char):boolean;
begin
  result := CharInSet(inChar,Vowels);
end;

function TfrmHaikuReviewMain.NumberOfLines(inStr : string): integer;
begin
  result := inStr.CountChar('/') + 1;
end;

function TfrmHaikuReviewMain.getLines(inStr : string): TStringlist;
var Splitted: TArray<String>;
    i : integer;
begin
  result := TStringlist.Create;
  Splitted := instr.Split(['/'],3);
  for i := Low(Splitted) to High(Splitted) do
    result.Add(Splitted[i]);
end;

function TfrmHaikuReviewMain.getWords(inStr: string): TStringlist;
var Splitted: TArray<String>;
    i : integer;
    NumWords : integer;
begin
  result := TStringlist.Create;
  NumWords := inStr.CountChar(' ') + 1;
  Splitted := instr.Split([' '],NumWords);
  for i := Low(Splitted) to High(Splitted) do
    result.Add(Splitted[i]);
end;

function TfrmHaikuReviewMain.CountSyllables(Words : TStringList): integer;
var i, j : integer;
    wrd : string;
    FoundVowel : boolean;
begin
  result := 0;
  for i := 0 to Words.Count - 1 do
  begin
    FoundVowel := false;
    wrd := Words[i];
    for j := 1 to wrd.Length do
    begin
      if charinset(wrd[j],Vowels) then
      begin
        if not FoundVowel then
          inc(result);
        FoundVowel := true;
      end
      else
        FoundVowel := false;
    end;
  end;
  Words.Clear;
  Words.Free;
  Words := nil;
end;

function TfrmHaikuReviewMain.ReviewHaiku(inStr : string): string;
var Words,
    Lines : TStringlist;
    LineNum : integer;
    Syllables : array[0..2] of integer;
    isProperHaiku : boolean;
begin
  result := inStr + ', ';
  isProperHaiku := true;
  fillchar(Syllables, sizeof(Syllables), #0);
  if NumberOfLines(inStr) = 3 then
  begin
    Lines := getLines(inStr.ToLower);
    for LineNum := 0 to Lines.Count - 1 do
    begin
      Words := getWords(Lines[LineNum]);
      Syllables[LineNum] := CountSyllables(Words);
    end;
    for LineNum := Low(Syllables) to High(Syllables) do
    begin
      isProperHaiku := isProperHaiku and (Syllables[LineNum] = CorrectSyllableCount[LineNum]);
      result := result + format('%d, ',[Syllables[LineNum]]);
    end;
    Lines.Free;
    result := result + ifthen(isProperHaiku,'Yes','No');
  end
  else
  begin
    result := result + 'No, incorrect line count'
  end;
end;

procedure TfrmHaikuReviewMain.btnReviewHaikuClick(Sender: TObject);
begin
  moResults.Lines.Add(ReviewHaiku(fldHaikuToReview.Text));
end;

end.
