unit DebugLib;

interface

type
  TDebugLogger = class
  public
    procedure Start(ALevel: Integer; const AFileName: string);
  end;

var
  Debug: TDebugLogger;

implementation

procedure TDebugLogger.Start(ALevel: Integer; const AFileName: string);
begin
end;

initialization
  Debug := TDebugLogger.Create;

finalization
  Debug.Free;

end.
