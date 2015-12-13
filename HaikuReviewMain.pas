unit HaikuReviewMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.StrUtils, System.math, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.Edit, FMX.Types;

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
    function getLines(inStr : string):TArray<String>;
    function getWords(inStr : string):TArray<String>;
    function CountSyllables(Words : TArray<String>): integer;
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
var wrkStr : string;
begin
  wrkStr := inStr.Trim;
  result := ifthen(wrkstr.EndsWith('/'),wrkStr.CountChar('/'),wrkStr.CountChar('/') + 1);
end;

function TfrmHaikuReviewMain.getLines(inStr : string):TArray<String>;
begin
  result := instr.Split(['/'],3);
end;

function TfrmHaikuReviewMain.getWords(inStr: string):TArray<String>;
var NumWords : integer;
begin
  NumWords := inStr.CountChar(' ') + 1;
  result := instr.Split([' '],NumWords);
end;

function TfrmHaikuReviewMain.CountSyllables(Words : TArray<String>): integer;
var word : string;
    letter : char;
    CountThisVowel : boolean;
begin
  result := 0;
  for word in Words do
  begin
    CountThisVowel := true;
    for letter in word do
    begin
      if CharInSet(letter,Vowels) then
      begin
        if CountThisVowel then
          inc(result);
        CountThisVowel := false;
      end
      else
        CountThisVowel := true;
    end;
  end;
end;

function TfrmHaikuReviewMain.ReviewHaiku(inStr : string): string;
var Lines : TArray<string>;
    line : string;
    LineNum : integer;
    Syllables : integer;
    isProperHaiku : boolean;
begin
  result := inStr + ', ';
  isProperHaiku := true;
  fillchar(Syllables, sizeof(Syllables), #0);
  if NumberOfLines(inStr) = 3 then
  begin
    Lines := getLines(inStr.ToLower);
    LineNum := 0;
    for line in Lines do
    begin
      Syllables := CountSyllables(getWords(line));
      isProperHaiku := isProperHaiku and (Syllables = CorrectSyllableCount[LineNum]);
      result := result + format('%d, ',[Syllables]);
      inc(LineNum);
    end;
    //finalize(Lines);
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
