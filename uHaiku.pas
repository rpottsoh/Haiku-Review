unit uHaiku;

interface

type
  IHaiku = interface(IInvokable)
  ['{72BA7A1E-4B4F-44C5-AD73-AB484E7894E6}']
    function GetResultStr: string;
    property ResultStr: string read GetResultStr;
  end;

  function HaikuReview(inStr: string): IHaiku;

implementation
uses System.SysUtils, System.StrUtils;

type
  THaiku = class(TInterfacedObject, IHaiku)
  private
    const
      fVowels: TSysCharSet = ['a','e','i','o','u','y'];
      fExpectedSyllableCount: array[0..2] of integer = (5,7,5);
    var
      fResultStr: string;
    function isVowel(inChar: char):boolean;
    function NumberOfLines(inStr: string): integer;
    function getLines(inStr: string):TArray<String>;
    function TheWordsIn(line: string):TArray<String>;
    function CountSyllables(Words: TArray<String>): integer;
    function GetResultStr: string;
  public
    constructor Review(inStr : string);
    property ResultStr: string read GetResultStr;
  end;

function HaikuReview(inStr: string): IHaiku;
begin
  result := THaiku.Review(inStr);
end;

function THaiku.isVowel(inChar : char):boolean;
begin
  result := CharInSet(inChar,fVowels);
end;

function THaiku.NumberOfLines(inStr : string): integer;
var wrkStr : string;
begin
  wrkStr := inStr.Trim;
  wrkStr := ifthen(wrkstr.EndsWith('/'),wrkStr.PadRight(1,' '),wrkStr);
  result := wrkStr.CountChar('/') + 1;
end;

function THaiku.getLines(inStr : string):TArray<String>;
begin
  result := instr.Split(['/']);
  if length(result) < 3 then
    SetLength(result,3);
end;

function THaiku.TheWordsIn(line: string):TArray<String>;
var NumWords : integer;
    wrkStr : string;
begin
  wrkStr := line.Trim;
  if wrkStr.IsEmpty then
    wrkStr := ' ';
  NumWords := wrkStr.CountChar(' ') + 1;
  result := wrkStr.Split([' '],NumWords);
end;

function THaiku.CountSyllables(Words : TArray<String>): integer;
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
      if isVowel(letter) then
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

constructor THaiku.Review(inStr : string);
var isProperHaiku : boolean;

    procedure CheckEachLine;
    var Lines : TArray<string>;
        line : string;
        LineNum : integer;
        Syllables : integer;
    begin
      isProperHaiku := true;
      Lines := getLines(inStr.ToLower);
      LineNum := 0;
      for line in Lines do
      begin
        Syllables := CountSyllables(TheWordsIn(line));
        isProperHaiku := isProperHaiku and (Syllables = fExpectedSyllableCount[LineNum]);
        fResultStr := fResultStr + format('%d, ',[Syllables]);
        inc(LineNum);
      end;
    end;

begin
  fResultStr := inStr + ', ';
  if NumberOfLines(inStr) = 3 then
  begin
    CheckEachLine;
    fResultStr := fResultStr + ifthen(isProperHaiku,'Yes','No');
  end
  else
    fResultStr := fResultStr + 'No, incorrect line count';
end;

function THaiku.GetResultStr: string;
begin
  result := fResultStr;
end;

end.
