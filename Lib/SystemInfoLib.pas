unit SystemInfoLib;

interface
uses
  Windows, Classes,
  UtilLib;

const
  MAX_DISK_CNT = 26;

type
  TByteUnitType = (buByte, buKByte, buMByte, buGByte);
  TRateUnitType = (ruInt3, ruInt3Dec1, ruInt3Dec2, ruInt3Dec3);

  { CPU Information Type }
  _SYSTEM_INFORMATION_CLASS = (
          SystemBasicInformation,
          SystemProcessorInformation,
          SystemPerformanceInformation,
          SystemTimeOfDayInformation,
          SystemNotImplemented1,
          SystemProcessesAndThreadsInformation,
          SystemCallCounts,
          SystemConfigurationInformation,
          SystemProcessorTimes,
          SystemGlobalFlag,
          SystemNotImplemented2,
          SystemModuleInformation,
          SystemLockInformation,
          SystemNotImplemented3,
          SystemNotImplemented4,
          SystemNotImplemented5,
          SystemHandleInformation,
          SystemObjectInformation,
          SystemPagefileInformation,
          SystemInstructionEmulationCounts,
          SystemInvalidInfoClass1,
          SystemCacheInformation,
          SystemPoolTagInformation,
          SystemProcessorStatistics,
          SystemDpcInformation,
          SystemNotImplemented6,
          SystemLoadImage,
          SystemUnloadImage,
          SystemTimeAdjustment,
          SystemNotImplemented7,
          SystemNotImplemented8,
          SystemNotImplemented9,
          SystemCrashDumpInformation,
          SystemExceptionInformation,
          SystemCrashDumpStateInformation,
          SystemKernelDebuggerInformation,
          SystemContextSwitchInformation,
          SystemRegistryQuotaInformation,
          SystemLoadAndCallImage,
          SystemPrioritySeparation,
          SystemNotImplemented10,
          SystemNotImplemented11,
          SystemInvalidInfoClass2,
          SystemInvalidInfoClass3,
          SystemTimeZoneInformation,
          SystemLookasideInformation,
          SystemSetTimeSlipEvent,
          SystemCreateSession,
          SystemDeleteSession,
          SystemInvalidInfoClass4,
          SystemRangeStartInformation,
          SystemVerifierInformation,
          SystemAddVerifier,
          SystemSessionProcessesInformation);
     SYSTEM_INFORMATION_CLASS = _SYSTEM_INFORMATION_CLASS;

     TNativeQuerySystemInformation = function(
          SystemInformationClass: SYSTEM_INFORMATION_CLASS;
          SystemInformation: Pointer;
          SystemInformationLength: ULONG;
          ReturnLength: PULONG
          ): ULONG; stdcall;
/////////////////////
     _SYSTEM_PROCESSOR_TIMES = packed record
          IdleTime,
          KernelTime,
          UserTime,
          DpcTime,
          InterruptTime: int64;
          InterruptCount: ULONG;
     end;
     SYSTEM_PROCESSOR_TIMES = _SYSTEM_PROCESSOR_TIMES;
     PSYSTEM_PROCESSOR_TIMES = ^_SYSTEM_PROCESSOR_TIMES;
  { ------------------------------------------------------------------ }   

  TMemoryItem = set of (miAvailPhys, miMemoryLoad,
                        miAvailVirtual, miUseVirtualRate,
                        miAvailPageFile, miUsePageFileRate);
  TMemoryInfoChangeEvent = procedure (AChangeItem: TMemoryItem) of Object;
  TMemoryInfoStatistics  = procedure (AStartDateTime, AEndDateTime: TDateTime;
                                      AMemoryLoad, AUseVirtualRate, AUsePageFileRate: Real) of Object;
  TMemoryInfo = class(TObject)
  private
    { Interface Information Variable }
    FTotalPhys      : DWORD;
    FAvailPhys      : DWORD;
    FUsePhys       : DWORD;
    FMemoryLoad     : Real;
    FTotalVirtual   : DWORD;
    FAvailVirtual   : DWORD;
    FUseVirtual    : DWORD;
    FUseVirtualRate : Real;
    FTotalPageFile  : DWORD;
    FAvailPageFile  : DWORD;
    FUsePageFile   : DWORD;
    FUsePageFileRate: Real;

    FCollectDateTime: TDateTime;
    { .................................................................................. }

    { 시간별 통계 관련 Variable } //Statistics
    FStatisticsCount: Integer;

    FSumMemoryLoad: Double;
    FAveMemoryLoad: Real;
    FSumUseVirtualRate: Double;
    FAveUseVirtualRate: Real;
    FSumUsePageFileRate: Double;
    FAveUsePageFileRate: Real;

    FStatisticsStartDT: TDateTime;
    FStatisticsEndDT: TDateTime;
    { .................................................................................. }

    { Event Variable }
    FOnMemoryInfoChange: TMemoryInfoChangeEvent;
    FOnMemoryInfoStatistics: TMemoryInfoStatistics;
    { .................................................................................. }

    procedure ClearStatisticsValue;
    function CalcStatistics: Boolean;

    function IsEqualHour: Boolean;
  protected
    destructor Destroy;
  public
    constructor Create;

    function CollectMemoryInfo: Boolean;
    //OnChangeEvent를 발생시킨다.
    procedure NotifyChange(MemoryItem: TMemoryItem = []);
    function GetCollectDateTime: String;

    property TotalPhys      : DWORD read FTotalPhys       write FTotalPhys;
    property AvailPhys      : DWORD read FAvailPhys       write FAvailPhys;
    property UsePhys       : DWORD read FUsePhys        write FUsePhys;
    property MemoryLoad     : Real  read FMemoryLoad      write FMemoryLoad;
    property TotalVirtual   : DWORD read FTotalVirtual    write FTotalVirtual;
    property AvailVirtual   : DWORD read FAvailVirtual    write FAvailVirtual;
    property UseVirtual    : DWORD read FUseVirtual     write FUseVirtual;
    property UseVirtualRate : Real  read FUseVirtualRate  write FUseVirtualRate;
    property TotalPageFile  : DWORD read FTotalPageFile   write FTotalPageFile;
    property AvailPageFile  : DWORD read FAvailPageFile   write FAvailPageFile;
    property UsePageFile  : DWORD read FUsePageFile   write FUsePageFile;
    property UsePageFileRate: Real  read FUsePageFileRate write FUsePageFileRate;

    property CollectDateTime: TDateTime read FCollectDateTime write FCollectDateTime;

    property OnMemoryInfoChange: TMemoryInfoChangeEvent read FOnMemoryInfoChange write FOnMemoryInfoChange;
    property OnMemoryInfoStatistics: TMemoryInfoStatistics read FOnMemoryInfoStatistics write FOnMemoryInfoStatistics;
  end;

  TCPUItem = set of (ciUseRate);
  TCPUInfoChangeEvent = procedure (AChangeItem: TCPUItem) of Object;
  TCPUInfoStatistics  = procedure (AStartDateTime, AEndDateTime: TDateTime; AUseRate: Real) of Object;

  TCPUInfo = class(TObject)
  private
    { Interface Information Variable }
    FName      : String;
    FVandorName: String;
    FVandorID  : String;
    FSpeed     : Double;
    FUseRate   : Real;

    FCollectDateTime: TDateTime;
    { .................................................................................. }

    { 시간별 통계 관련 Variable } //Statistics
    FStatisticsCount: Integer;

    FSumUseRate: Double;
    FAveUseRate: Real;

    FStatisticsStartDT: TDateTime;
    FStatisticsEndDT: TDateTime;
    { .................................................................................. }

    { 정보 수집에 필요한 자료 }
    FCpuCurrValue: Int64;
    FCpuLastValue: Int64;
    FCpuCurrTime : DWORD;
    FCpuLastTime : DWORD;

    FCpuSize: DWORD;
    FPNtSystemProcessTime: PSYSTEM_PROCESSOR_TIMES;
    zwQuerySystemInformation: TNativeQuerySystemInformation;
    { .................................................................................. }

    { Event Variable }
    FOnCPUInfoChange: TCPUInfoChangeEvent;
    FOnCPUInfoStatistics: TCPUInfoStatistics;
    { .................................................................................. }

    procedure ClearStatisticsValue; 
    function CalcStatistics: Boolean;

    function IsEqualHour: Boolean;

    function IsNtOS: Boolean;
    function GetSystemProcessTime: SYSTEM_PROCESSOR_TIMES;

    { Get CPU Information function }
    function GetVandorName: String;
    function GetVandorID: String;
    function GetCpuSpeed: Double;
    function GetCpuUseRate: Integer;
    function InitNtCpuData: Boolean;
    function GetNtCpuData: Int64;
    function Init9xPerfData(AObjCounter: String): Boolean;
    function Get9xPerfData(AObjCounter: String): Integer;
    { .................................................................................. }
  protected
    destructor Destroy;
  public
    constructor Create;

    function CollectCPUInfo: Boolean;
    //OnChangeEvent를 발생시킨다.
    procedure NotifyChange(CPUItem: TCPUItem = []);

    function GetCollectDateTime: String;

    property Name      : String read FName       write FName;
    property VandorName: String read FVandorName write FVandorName;
    property VandorID  : String read FVandorID   write FVandorID;
    property Speed     : Double read FSpeed      write FSpeed;
    property UseRate   : Real   read FUseRate    write FUseRate;

    property CollectDateTime: TDateTime read FCollectDateTime write FCollectDateTime;
    
    property OnCPUInfoChange: TCPUInfoChangeEvent read FOnCPUInfoChange write FOnCPUInfoChange;
    property OnCPUInfoStatistics: TCPUInfoStatistics read FOnCPUInfoStatistics write FOnCPUInfoStatistics;
  end;

  TDiskItem = set of (diUseSize, diFreeSize, diUseRate, diUsableDay);
  TDiskInfoChangeEvent = procedure (ADiskIndex: WORD; AChangeItem: TDiskItem) of Object;
  TDiskInfoStatistics  = procedure (ADiskIndex: WORD) of Object;

  TDiskInfo = class(TObject)
  private
    { Interface Information Variable }
    FIndex         : WORD;
    FName          : String;
    FDiskType      : WORD;
    FDiskTypeName  : String;
    FDiskKindName  : String;
    FVolumnName    : String;
    FVolumnSerial  : String;
    FFileSystemName: String;
    FSize          : DWORD;
    FUseSize       : DWORD;
    FFreeSize      : DWORD;
    FUseRate       : Real;
    FBusyRate      : Real;

    FCollectDateTime: TDateTime;
    { .................................................................................. }

    { 시간별 통계 관련 Variable } //Statistics
    FStatisticsCount: Integer;

    FBaseUseSize: DWORD;   //통계 시작 시점의 디스크 크기
    FIncUseSize: Integer;  //시간별 디스크 증가 Size 작아 질경우 마이너스값. 단위 MegaByte

    FSumUseRate: Double;
    FAveUseRate: Real;

    FStatisticsStartDT: TDateTime;
    FStatisticsEndDT: TDateTime;
    { .................................................................................. }

    { Event Variable }
    FOnDiskInfoChange: TDiskInfoChangeEvent;
    FOnDiskInfoStatistics: TDiskInfoStatistics;
    { .................................................................................. }

    procedure ClearStatisticsValue;
    function CalcStatistics: Boolean;

    function IsEqualHour: Boolean;

    procedure GetDiskType;
    procedure GetDiskAdditionInfo;
  protected
    destructor Destroy;
  public
    constructor Create(ADiskName: String; AIndex: Integer);

    function GetDiskSize: Boolean;
    //OnChangeEvent를 발생시킨다.
    procedure NotifyChange(DiskItem: TDiskItem = []);

    function GetCollectDateTime: String;

    property Index         : WORD   read FIndex          write FIndex;
    property Name          : String read FName           write FName;
    property DiskType      : WORD   read FDiskType       write FDiskType;
    property DiskTypeName  : String read FDiskTypeName   write FDiskTypeName;
    property DiskKindName  : String read FDiskKindName   write FDiskKindName;
    property VolumnName    : String read FVolumnName     write FVolumnName;
    property VolumnSerial  : String read FVolumnSerial   write FVolumnSerial;
    property FileSystemName: String read FFileSystemName write FFileSystemName;
    property Size          : DWORD  read FSize           write FSize;
    property UseSize       : DWORD  read FUseSize        write FUseSize;
    property FreeSize      : DWORD  read FFreeSize       write FFreeSize;
    property UseRate       : Real   read FUseRate        write FUseRate;
    property BusyRate      : Real   read FBusyRate       write FBusyRate;

    property IncUseSize    : Integer read FIncUseSize    write FIncUseSize;

    property CollectDateTime: TDateTime read FCollectDateTime write FCollectDateTime;
    property StatisticsStartDT: TDateTime read FStatisticsStartDT write FStatisticsStartDT;
    property StatisticsEndDT: TDateTime read FStatisticsEndDT write FStatisticsEndDT;

    property OnDiskInfoChange: TDiskInfoChangeEvent read FOnDiskInfoChange write FOnDiskInfoChange;
    property OnDiskInfoStatistics: TDiskInfoStatistics read FOnDiskInfoStatistics write FOnDiskInfoStatistics;
  end;

  TSystemDiskInfo = class(TObject)
  private
    FDiskList: TList;

    function GetDiskCount: Word;
    function GetDiskInfo(Index: WORD): TDiskInfo;
    procedure PutDiskInfo(Index: WORD; const Value: TDiskInfo);

    { Get Disk Information function }
    function GetDiskDrive: Integer;
    procedure SetDiskInfoChange(const Value: TDiskInfoChangeEvent);
    procedure SetDiskInfoStatistics(const Value: TDiskInfoStatistics);
    { .................................................................................. }
  protected
    destructor Destroy;
  public
    constructor Create;

    function CollectDiskInfo: Boolean;
    //OnChangeEvent를 발생시킨다.
    procedure NotifyChange;

    procedure ClearDisks;
    function AddDisk(ADiskInfo: TDiskInfo): Integer;

    { Disk Handle property }
    property DiskItems[Index: WORD]: TDiskInfo read GetDiskInfo write PutDiskInfo;
    property DiskCount: WORD read GetDiskCount;
    { .................................................................................. }

    { Event property }
    property OnDiskInfoChange: TDiskInfoChangeEvent write SetDiskInfoChange;
    property OnDiskInfoStatistics: TDiskInfoStatistics write SetDiskInfoStatistics;
    { .................................................................................. }
  end;

  TDatabaseItem = set of (dbiDiskUseSize, dbiDiskUseRate, dbiConnectCount);
  TDatabaseInfoChangeEvent = procedure (AChangeItem: TDatabaseItem) of Object;
  TDatabaseInfoStatistics  = procedure (AStartDateTime, AEndDateTime: TDateTime;
                                        AIncUseSize: Integer; AAveConnectCount: WORD) of Object;

  TDatabaseInfo = class(TObject)
  private
    FName        : String;
    FInstallDrive: String;
    FDiskUseSize : DWORD;
    FDiskUseRate : WORD;
    FConnectCount: WORD;

    FCollectDateTime: TDateTime;
    
    { 시간별 통계 관련 Variable } //Statistics
    FStatisticsCount: Integer;

    FBaseUseSize: DWORD;   //통계 시작 시점의 디스크 크기
    FIncUseSize: Integer;  //시간별 디스크 증가 Size 작아 질경우 마이너스값. 단위 MegaByte

    FSumConnectCount: DWORD;
    FAveConnectCount: WORD;

    FStatisticsStartDT: TDateTime;
    FStatisticsEndDT: TDateTime;
    { .................................................................................. }

    { Event Variable }
    FOnDatabaseInfoChange: TDatabaseInfoChangeEvent;
    FOnDatabaseInfoStatistics: TDatabaseInfoStatistics;
    { .................................................................................. }

    procedure ClearStatisticsValue;
    function CalcStatistics: Boolean;

    function IsEqualHour: Boolean;

    { Get Database Information function }
    function GetDiskUseSize: DWORD;
    function GetConnectCount: WORD;
    { .................................................................................. }
  protected
    destructor Destroy;
  public
    constructor Create;
    
    function CollectDatabaseInfo: Boolean;
    //OnChangeEvent를 발생시킨다.
    procedure NotifyChange(DatabaseItem: TDatabaseItem = []);

    function GetCollectDateTime: String;

    property Name        : String read FName         write FName;
    property InstallDrive: String read FInstallDrive write FInstallDrive;
    property DiskUseSize : DWORD  read FDiskUseSize  write FDiskUseSize;
    property DiskUseRate : WORD   read FDiskUseRate  write FDiskUseRate;
    property ConnectCount: WORD   read FConnectCount write FConnectCount;
    
    property CollectDateTime: TDateTime read FCollectDateTime write FCollectDateTime;

    property OnDatabaseInfoChange: TDatabaseInfoChangeEvent read FOnDatabaseInfoChange write FOnDatabaseInfoChange;
    property OnDatabaseInfoStatistics: TDatabaseInfoStatistics read FOnDatabaseInfoStatistics write FOnDatabaseInfoStatistics;
  end;

  TSystemItem = set of (siMemory, siCPU, siDisk, siDatabase);

  TSystemConfigInfo = class(TObject)
  private
    { System Information Object }
    FMemoryInfo    : TMemoryInfo;
    FCPUInfo       : TCPUInfo;
    FSystemDiskInfo: TSystemDiskInfo;
    FDatabaseInfo  : TDatabaseInfo;
    { .................................................................................... }

    FCollectItem: TSystemItem;
  protected
    destructor Destroy;
  public
    constructor Create;

    procedure CollectSystemConfigInfo;

    property CollectItem: TSystemItem read FCollectItem write FCollectItem;

    property MemoryInfo    : TMemoryInfo     read FMemoryInfo     write FMemoryInfo;
    property CPUInfo       : TCPUInfo        read FCPUInfo        write FCPUInfo;
    property SystemDiskInfo: TSystemDiskInfo read FSystemDiskInfo write FSystemDiskInfo;
    property DatabaseInfo  : TDatabaseInfo   read FDatabaseInfo   write FDatabaseInfo;
  end;

var
  SystemConfigInfo: TSystemConfigInfo;

implementation
uses
  Math,
  SysUtils,
  DateStr,
  DataBaseFile,
  DebugLib;

//Type에 대응대는 2진수값
function ByteUnit(AByteUnit: TByteUnitType): Double;
begin
  case AByteUnit of
    buByte  : Result := 1;
    buKByte : Result := Power(2,10);
    buMByte : Result := Power(2,20);
    buGByte : Result := Power(2,30);
  else
    Result := 1;
  end;
end;

{ TMemoryInfo }

function TMemoryInfo.CalcStatistics: Boolean;
begin
  if FStatisticsCount = 0 then FStatisticsStartDT := FCollectDateTime;
  FStatisticsEndDT := FCollectDateTime;

  Inc(FStatisticsCount);

  FSumMemoryLoad := FSumMemoryLoad + FMemoryLoad;
  FAveMemoryLoad := Round(FSumMemoryLoad / FStatisticsCount * 100) / 100;

  FSumUseVirtualRate := FSumUseVirtualRate + FUseVirtualRate;
  FAveUseVirtualRate := Round(FSumUseVirtualRate / FStatisticsCount * 100) / 100;

  FSumUsePageFileRate := FSumUsePageFileRate + FUsePageFileRate;
  FAveUsePageFileRate := Round(FSumUsePageFileRate / FStatisticsCount * 100) / 100;
end;

procedure TMemoryInfo.ClearStatisticsValue;
begin
  FStatisticsCount := 0;
  FAveMemoryLoad := 0;
  FAveUseVirtualRate := 0;
  FAveUsePageFileRate := 0;
  FSumMemoryLoad := 0;
  FSumUseVirtualRate := 0;
  FSumUsePageFileRate := 0;

  FStatisticsStartDT := Now();
  FStatisticsEndDT := Now();
end;

function TMemoryInfo.CollectMemoryInfo: Boolean;
var
  MemStatus: TMemoryStatus;
  MemChangeItem: TMemoryItem;
  dwTemp: DWORD;
  dTemp: Double;
begin
  Result := False;
  MemChangeItem := [];

  try
    MemStatus.dwLength := SizeOf(MemStatus);
    GlobalMemoryStatus(MemStatus);
    FTotalPhys := Round((MemStatus.dwTotalPhys / ByteUnit(buMByte)) * 100) div 100;

    dwTemp := Round((MemStatus.dwAvailPhys / ByteUnit(buMByte)) * 100) div 100;
    if dwTemp <> FAvailPhys then MemChangeItem := MemChangeItem + [miAvailPhys];
    FAvailPhys := dwTemp;

    FUsePhys := FTotalPhys - FAvailPhys;

    dwTemp := MemStatus.dwMemoryLoad; //메모리 사용율
    if dwTemp <> FMemoryLoad then MemChangeItem := MemChangeItem + [miMemoryLoad];
    FMemoryLoad := dwTemp;

    FTotalVirtual := Round((MemStatus.dwTotalVirtual / ByteUnit(buMByte)) * 100) div 100;

    dwTemp := Round((MemStatus.dwAvailVirtual / ByteUnit(buMByte)) * 100) div 100;
    if dwTemp <> FAvailVirtual then MemChangeItem := MemChangeItem + [miAvailVirtual];
    FAvailVirtual := dwTemp;

    FUseVirtual := FTotalVirtual - FAvailVirtual;

    if (FTotalVirtual - FAvailVirtual) <> 0 then
      dTemp := Round(((FTotalVirtual - FAvailVirtual) * 100) / FTotalVirtual * 100) / 100
    else
      dTemp := 0.00;
    if dTemp <> FUseVirtualRate then MemChangeItem := MemChangeItem + [miUseVirtualRate];
    FUseVirtualRate := dTemp;

    FTotalPageFile   := Round((MemStatus.dwTotalPageFile / ByteUnit(buMByte)) * 100) div 100;

    dwTemp := Round((MemStatus.dwAvailPageFile / ByteUnit(buMByte)) * 100) div 100;
    if dwTemp <> FAvailPageFile then MemChangeItem := MemChangeItem + [miAvailPageFile];
    FAvailPageFile := dwTemp;

    FUsePageFile := FTotalPageFile - FAvailPageFile;

    if (FTotalPageFile - FAvailPageFile) <> 0 then
      dTemp := Round(((FTotalPageFile - FAvailPageFile) * 100) / FTotalPageFile * 100) / 100
    else
      dTemp := 0;
    if dTemp <> FUsePageFileRate then MemChangeItem := MemChangeItem + [miUsePageFileRate];
    FUsePageFileRate := dTemp;

    FCollectDateTime := Now();

    //항목변경 이벤트 발생
    if MemChangeItem <> [] then NotifyChange(MemChangeItem);

    if IsEqualHour() then
      CalcStatistics() //통계 시작시간과 현재 수집시간대가 같으면 통계를 계산한다.
    else
    begin
      if Assigned(FOnMemoryInfoStatistics) then //이벤트가 걸려 있으면 이벤트 발생
        FOnMemoryInfoStatistics(FStatisticsStartDT, FStatisticsEndDT,
                                FAveMemoryLoad, FAveUseVirtualRate, FAveUsePageFileRate);
      //통계를 초기화 한다.
      ClearStatisticsValue;
    end;

    Result := True;
  except
    on E:Exception do
    begin
      Debug.Write(9, 'CollectMemoryInfo Exception Msg=' + E.Message);
    end;
  end;
end;

constructor TMemoryInfo.Create;
begin
  ClearStatisticsValue;

//  CollectMemoryInfo();
end;

destructor TMemoryInfo.Destroy;
begin
  //
end;

function TMemoryInfo.GetCollectDateTime: String;
begin
  Result := FormatDateTime('YYYYMMDDHHNNSS', FCollectDateTime);
end;

function TMemoryInfo.IsEqualHour: Boolean;
begin
  Result := FormatDateTime('YYYYMMDDHH', FStatisticsStartDT) = FormatDateTime('YYYYMMDDHH', FCollectDateTime); 
end;

procedure TMemoryInfo.NotifyChange(MemoryItem: TMemoryItem);
begin
  //항목변경 이벤트 발생
  if Assigned(FOnMemoryInfoChange) then
    FOnMemoryInfoChange(MemoryItem);
end;

{ TCPUInfo }

function TCPUInfo.CalcStatistics: Boolean;
begin
  if FStatisticsCount = 0 then FStatisticsStartDT := FCollectDateTime;
  FStatisticsEndDT := FCollectDateTime;

  Inc(FStatisticsCount);

  FSumUseRate := FSumUseRate + FUseRate;
  FAveUseRate := Round(FSumUseRate * 100 / FStatisticsCount) div 100;
end;

procedure TCPUInfo.ClearStatisticsValue;
begin
  FStatisticsCount := 0;
  FAveUseRate := 0;
  FSumUseRate := 0;

  FStatisticsStartDT := Now();
  FStatisticsEndDT := Now();
end;

function TCPUInfo.CollectCPUInfo: Boolean;
var
  CPUChangeItem: TCPUItem;
  dTemp: Double;
  wTemp: WORD;
begin
  Result := False;

  try
    CPUChangeItem := [];

    FSpeed := GetCpuSpeed();

    wTemp := GetCpuUseRate();
    if wTemp <> FUseRate then CPUChangeItem := CPUChangeItem + [ciUseRate];
    FUseRate := wTemp;
    FCollectDateTime := Now();

    //항목변경 이벤트 발생
    if CPUChangeItem <> [] then NotifyChange(CPUChangeItem);
    if IsEqualHour() then
      CalcStatistics() //통계 시작시간과 현재 수집시간대가 같으면 통계를 계산한다.
    else
    begin
      if Assigned(FOnCPUInfoStatistics) then //이벤트가 걸려 있으면 이벤트 발생
        FOnCPUInfoStatistics(FStatisticsStartDT, FStatisticsEndDT, FAveUseRate);
      //통계를 초기화 한다.
      ClearStatisticsValue;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Debug.Write(9, 'CollectCPUInfo Exception Msg=' + E.Message);
    end;
  end;
end;

constructor TCPUInfo.Create;
begin
  FName := 'CPU';

  FVandorName := GetVandorName();
  FVandorID   := GetVandorID();

  ClearStatisticsValue;
//  CollectCPUInfo();
end;

destructor TCPUInfo.Destroy;
begin
  //
end;

function TCPUInfo.Get9xPerfData(AObjCounter: String): Integer;
var
  dwReturn, dwType, dwCbData: DWORD;
  hOpen: HKEY;
  Buffer: DWORD;
begin
  Result := -1;

  dwReturn := RegOpenKeyEx(HKEY_DYN_DATA, 'PerfStats\StatData', 0, KEY_READ, hOpen);
  if dwReturn = ERROR_SUCCESS then
  begin
    dwCbData := SizeOf(DWORD);
    try
      dwReturn := RegQueryValueEx(hOpen, PChar(AObjCounter) ,nil, @dwType, PBYTE(@Buffer), @dwCbData);
      if dwReturn = ERROR_SUCCESS then Result := Buffer;
    finally
      RegCloseKey(hOpen);
    end;
  end;
end;

function TCPUInfo.GetCollectDateTime: String;
begin
  Result := FormatDateTime('YYYYMMDDHHNNSS', FCollectDateTime);
end;

function TCPUInfo.GetCpuSpeed: Double;
const
  DELAY_TIME = 500;
var
  dwTimerHi, dwTimerLo: DWord;
  iPriorityClass, iPriority: Integer;
begin
  iPriorityClass := GetPriorityClass(GetCurrentProcess);
  iPriority := GetThreadPriority(GetCurrentThread);
  SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);

  asm
    DW 310Fh
    MOV dwTimerLo, EAX
    MOV dwTimerHi, EDX
  end;

//  WaitForSingleObject(Self.Handle, 1);
//  Sleep(DELAY_TIME);
  
  asm
    DW 310Fh
    SUB EAX, dwTimerLo
    SBB EDX, dwTimerHi
    MOV dwTimerLo, EAX
    MOV dwTimerHi, EDX
  end;
  
  SetThreadPriority(GetCurrentThread, iPriority);
  SetPriorityClass(GetCurrentProcess, iPriorityClass);
  Result := dwTimerLo / (1000.0 * DELAY_TIME);
end;

function TCPUInfo.GetCpuUseRate: Integer;
const
  TIMER_100N = 10000000;
  TIMER_1S   = 1000;
var
  NTDLL_DLL: THandle;
begin
  Result := -1;

  if IsNtOS() then
  begin
    NTDLL_DLL := GetModuleHandle('NTDLL.DLL');
    @ZwQuerySystemInformation := GetProcAddress(NTDLL_DLL,'ZwQuerySystemInformation');

    InitNTCPUData;

    FCpuLastValue := FCpuCurrValue;
    FCpuLastTime  := FCpuCurrTime;

    FCpuCurrValue := GetNtCpuData();
    FCpuCurrTime := GetTickCount();

    Result := Round( (TIMER_100N - (FCpuCurrValue - FCpuLastValue) /
                     ((FCpuCurrTime - FCpuLastTime) / TIMER_1S)) / TIMER_100N * 100);
  end
  else
  begin
    Init9xPerfData('KERNEL\CPUUsage');
    Result := Get9xPerfData('KERNEL\CPUUsage');
  end;
end;

function TCPUInfo.GetNtCpuData: Int64;
begin
  Result := GetSystemProcessTime().IdleTime;
end;

function TCPUInfo.GetSystemProcessTime: SYSTEM_PROCESSOR_TIMES;
var
  SystemProcessTime: SYSTEM_PROCESSOR_TIMES;
begin
  zwQuerySystemInformation(SystemProcessorTimes, @SystemProcessTime, FCpuSize, nil);
  Result := SystemProcessTime;
end;

function TCPUInfo.GetVandorID: String;
var
  acVendorID: array [0..47] of Char;
begin
  asm
    PUSH	EAX
    PUSH	EBP
    PUSH	EBX
    PUSH	ECX
    PUSH	EDI
    PUSH	EDX
    PUSH	ESI

    MOV	EAX, $80000002
    DW	$A20F

    MOV	DWORD PTR [acVendorID     ], EAX
    MOV	DWORD PTR [acVendorID + 04], EBX
    MOV	DWORD PTR [acVendorID + 08], ECX
    MOV	DWORD PTR [acVendorID + 12], EDX

    MOV	EAX, $80000003
    DW	$A20F

    MOV	DWORD PTR [acVendorID + 16], EAX
    MOV	DWORD PTR [acVendorID + 20], EBX
    MOV	DWORD PTR [acVendorID + 24], ECX
    MOV	DWORD PTR [acVendorID + 28], EDX

    MOV	EAX, $80000004
    DW	$A20F

    MOV	DWORD PTR [acVendorID + 32], EAX
    MOV	DWORD PTR [acVendorID + 36], EBX
    MOV	DWORD PTR [acVendorID + 40], ECX
    MOV	DWORD PTR [acVendorID + 44], EDX

    POP	ESI
    POP	EDX
    POP	EDI
    POP	ECX
    POP	EBX
    POP	EBP
    POP	EAX
  end;

  Result := Trim(acVendorID);
end;

function TCPUInfo.GetVandorName: String;
var
  acVendorName: array [0..11] of Char;
begin
  asm
    PUSH	EAX
    PUSH	EBP
    PUSH	EBX
    PUSH	ECX
    PUSH	EDI
    PUSH	EDX
    PUSH	ESI

    MOV	EAX, 0
    DB	0FH
    DB	0A2H

    MOV	DWORD PTR [acVendorName    ], EBX
    MOV	DWORD PTR [acVendorName + 4], EDX
    MOV	DWORD PTR [acVendorName + 8], ECX

    POP	ESI
    POP	EDX
    POP	EDI
    POP	ECX
    POP	EBX
    POP	EBP
    POP	EAX
  end;

  Result := Trim(acVendorName);
end;

function TCPUInfo.Init9xPerfData(AObjCounter: String): Boolean;
var
  dwReturn, dwType, dwCbData: DWORD;
  hOpen: HKEY;
  pB: PByte;
begin
  Result := False;

  dwReturn := RegOpenKeyEx(HKEY_DYN_DATA, 'PerfStats\StartStat', 0, KEY_READ, hOpen);
  if dwReturn = ERROR_SUCCESS then
  begin
    try
      dwReturn := RegQueryValueEx(hOpen, PChar(AObjCounter), nil, @dwType, nil, @dwCbData);
      if dwReturn = ERROR_SUCCESS then
      begin
        pB := AllocMem(dwCbData);
        dwReturn := RegQueryValueEx(hOpen, PChar(AObjCounter), nil, @dwType, pB, @dwCbData);
        FreeMem(pB);
        Result := dwReturn = ERROR_SUCCESS;
      end;
    finally
      RegCloseKey(hOpen);
    end;
  end;  
end;

function TCPUInfo.InitNtCpuData: Boolean;
var
  ulReturn: ULONG;
  dwCount: DWORD;
begin
  dwCount := 0;
  FPNtSystemProcessTime := AllocMem(SizeOf(SYSTEM_PROCESSOR_TIMES));
  ulReturn := ZwQuerySystemInformation(SystemProcessorTimes, FPNtSystemProcessTime, SizeOf(SYSTEM_PROCESSOR_TIMES), nil);
  while ulReturn = $C0000004 do
  begin
    Inc(dwCount);
    ReallocMem(FPNtSystemProcessTime, dwCount * SizeOf(FPNtSystemProcessTime^));
    ulReturn := ZwQuerySystemInformation(SystemProcessorTimes, FPNtSystemProcessTime, dwCount * SizeOf(SYSTEM_PROCESSOR_TIMES), nil);
  end;
  FCpuSize := dwCount * SizeOf(FPNtSystemProcessTime^);
  Result := ulReturn = $00000000;
end;

function TCPUInfo.IsEqualHour: Boolean;
begin
  Result := FormatDateTime('YYYYMMDDHH', FStatisticsStartDT) = FormatDateTime('YYYYMMDDHH', FCollectDateTime); 
end;

function TCPUInfo.IsNtOS: Boolean;
var
  OS :TOSVersionInfo;
begin
  Result := False;

  ZeroMemory(@OS,SizeOf(OS));
  OS.dwOSVersionInfoSize := SizeOf(OS);
  GetVersionEx(OS);
  Result := OS.dwPlatformId = VER_PLATFORM_WIN32_NT;
end;

procedure TCPUInfo.NotifyChange(CPUItem: TCPUItem);
begin
  if Assigned(FOnCPUInfoChange) then
    FOnCPUInfoChange(CPUItem);
end;

{ TDiskInfo }

function TDiskInfo.CalcStatistics: Boolean;
begin
  Debug.Write(1, '[TDiskInfo.CalcStatistics]');
  
  if FStatisticsCount = 0 then
  begin
    FStatisticsStartDT := FCollectDateTime;
    FBaseUseSize := FUseSize;
  end;
  FStatisticsEndDT := FCollectDateTime;
  FIncUseSize := FUseSize - FBaseUseSize;

  Inc(FStatisticsCount);

  FSumUseRate := FSumUseRate + FUseRate;
  FAveUseRate := Round(FSumUseRate * 100 / FStatisticsCount) div 100;

  Debug.Write(1, Format('%d Disk (%d)UseRate=%f, Sum=%f, Ave=%f, IncSize=%d',
                       [FIndex, FStatisticsCount, FUseRate, FSumUseRate, FAveUseRate, FIncUseSize]) );
end;

procedure TDiskInfo.ClearStatisticsValue;
begin
  FStatisticsCount := 0;

  FBaseUseSize := 0;
  FIncUseSize := 0;

  FSumUseRate := 0;
  FAveUseRate := 0;

  FStatisticsStartDT := Now();
  FStatisticsEndDT := Now();
end;

constructor TDiskInfo.Create(ADiskName: String; AIndex: Integer);
begin
  FName := ADiskName;
  FIndex := AIndex;

  //CD-ROM이 0으로 잡히기 때문에 Change를 Catch할 수 없다. 그래서 Default를 1로 주자
  FSize     := 1;
  FUseSize  := 1;
  FFreeSize := 1;
  FUseRate  := 1;
  FBusyRate := 1;

  GetDiskType();
  GetDiskAdditionInfo();

  ClearStatisticsValue;
//  GetDiskSize();
end;

destructor TDiskInfo.Destroy;
begin
  //
end;

function TDiskInfo.GetCollectDateTime: String;
begin
  Result := FormatDateTime('YYYYMMDDHHNNSS', FCollectDateTime);
end;

procedure TDiskInfo.GetDiskAdditionInfo;
var
  lpRootPathName           : PChar;
  lpVolumeNameBuffer       : PChar;
  nVolumeNameSize          : DWORD;
  lpVolumeSerialNumber     : DWORD;
  lpMaximumComponentLength : DWORD;
  lpFileSystemFlags        : DWORD;
  lpFileSystemNameBuffer   : PChar;
  nFileSystemNameSize      : DWORD;
begin
  try
    GetMem( lpVolumeNameBuffer, MAX_PATH + 1 );
    GetMem( lpFileSystemNameBuffer, MAX_PATH + 1 );

    nVolumeNameSize := MAX_PATH + 1;
    nFileSystemNameSize := MAX_PATH + 1;

    lpRootPathName := PChar( FName + '\' );
    if Windows.GetVolumeInformation( lpRootPathName,
                                     lpVolumeNameBuffer,
                                     nVolumeNameSize,
                                     @lpVolumeSerialNumber,
                                     lpMaximumComponentLength,
                                     lpFileSystemFlags,
                                     lpFileSystemNameBuffer,
                                     nFileSystemNameSize ) then
    begin
      FVolumnName     := lpVolumeNameBuffer;
      FVolumnSerial   := IntToHex(HiWord(lpVolumeSerialNumber), 4) + '-' +
                         IntToHex(LoWord(lpVolumeSerialNumber), 4);
      FFileSystemName := lpFileSystemNameBuffer;
    end;
  finally
    FreeMem( lpVolumeNameBuffer );
    FreeMem( lpFileSystemNameBuffer );
  end;
end;

function TDiskInfo.GetDiskSize: Boolean;
var
  iFreeBytes,
  iNumOfBytes,
  iTotalFreeBytes: Int64;
  pcDiskName: PChar;
  dwTemp: DWORD;
  dTemp: Double;
  DiskChangeItem: TDiskItem;
begin
  Result := False;

  try
    DiskChangeItem := [];
    iFreeBytes := 0;
    iNumOfBytes := 0;
    iTotalFreeBytes := 0;

    pcDiskName := PChar(FName + '\');

    if not GetDiskFreeSpaceEx(pcDiskName, iFreeBytes, iNumOfBytes, @iTotalFreeBytes) then
    begin
      Debug.Write(9, 'GetDiskFreeSpaceEx Fail!! DiskName=' + pcDiskName);
      FSize := 0;
      FUseSize := 0;
      FFreeSize := 0;
      FUseRate := 0;
      FCollectDateTime := Now();
      Exit;
    end;

    //총 디스크 공간을 계산
    FSize := Round((iNumOfBytes / ByteUnit(buMByte)) * 100) div 100;

    //사용공간을 계산
    dwTemp := Round(((iNumOfBytes - iTotalFreeBytes) / ByteUnit(buMByte)) * 100) div 100;
    if dwTemp <> FUseSize then DiskChangeItem := DiskChangeItem + [diUseSize];
    FUseSize := dwTemp;

    //디스크의 여유공간 계산
    dwTemp := Round((iTotalFreeBytes / ByteUnit(buMByte)) * 100) div 100;
    if dwTemp <> FFreeSize then DiskChangeItem := DiskChangeItem + [diFreeSize];
    FFreeSize := dwTemp;

    if FUseSize <> 0 then
      dTemp := Round((FUseSize * 100) / FSize * 100) / 100
    else
      dTemp := 0;
    if dTemp <> FUseRate then DiskChangeItem := DiskChangeItem + [diUseRate];
    FUseRate := dTemp;

    FCollectDateTime := Now();
    
    //항목변경 이벤트 발생
    if DiskChangeItem <> [] then NotifyChange(DiskChangeItem);

    if IsEqualHour() then
      CalcStatistics() //통계 시작시간과 현재 수집시간대가 같으면 통계를 계산한다.
    else
    begin
      if Assigned(FOnDiskInfoStatistics) then //이벤트가 걸려 있으면 이벤트 발생
        FOnDiskInfoStatistics(Index);

      //통계를 초기화 한다.
      ClearStatisticsValue;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Debug.Write(9, 'GetDiskSize Exception Msg=' + E.Message);
    end;
  end;
end;

procedure TDiskInfo.GetDiskType;
begin
  FDiskType := GetDriveType( PChar(FName + '\') );

  Debug.Write(1, 'DriveName=' + FName + '\');

  case FDiskType of
    DRIVE_UNKNOWN     : FDiskTypeName := 'DRIVE_UNKNOWN';
    DRIVE_NO_ROOT_DIR : FDiskTypeName := 'DRIVE_NO_ROOT_DIR';
    DRIVE_REMOVABLE   : FDiskTypeName := 'DRIVE_REMOVABLE';
    DRIVE_FIXED       : FDiskTypeName := 'DRIVE_FIXED';
    DRIVE_REMOTE      : FDiskTypeName := 'DRIVE_REMOTE';
    DRIVE_CDROM       : FDiskTypeName := 'DRIVE_CDROM';
    DRIVE_RAMDISK     : FDiskTypeName := 'DRIVE_RAMDISK';
  end;
end;

function TDiskInfo.IsEqualHour: Boolean;
begin
  Result := FormatDateTime('YYYYMMDDHH', FStatisticsStartDT) = FormatDateTime('YYYYMMDDHH', FCollectDateTime); 
//  Result := FormatDateTime('YYYYMMDDHHNN', FStatisticsStartDT) = FormatDateTime('YYYYMMDDHHNN', FCollectDateTime);
end;

procedure TDiskInfo.NotifyChange(DiskItem: TDiskItem);
begin
  if Assigned(FOnDiskInfoChange) then
    FOnDiskInfoChange(FIndex, DiskItem);
end;

{ TSystemDiskInfo }

function TSystemDiskInfo.AddDisk(ADiskInfo: TDiskInfo): Integer;
begin
  Result := FDiskList.Add(ADiskInfo);
end;

procedure TSystemDiskInfo.ClearDisks;
var
  iIndex: Integer;
begin
  for iIndex := 0 to FDiskList.Count - 1 do
    if Assigned(DiskItems[iIndex]) then DiskItems[iIndex].Free;
     
  FDiskList.Clear;
end;

function TSystemDiskInfo.CollectDiskInfo: Boolean;
var
  iIndex: Integer;
begin
  Result := False;

  try
    for iIndex := 0 to FDiskList.Count - 1 do
    begin
      DiskItems[iIndex].GetDiskSize();
      Sleep(1);
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Debug.Write(9, 'CollectDiskInfo Exception Msg=' + E.Message);
    end;
  end;
end;

constructor TSystemDiskInfo.Create;
begin
  FDiskList := TList.Create;

  GetDiskDrive();
end;

destructor TSystemDiskInfo.Destroy;
begin
  if Assigned(FDiskList) then
  begin
    ClearDisks;
    FreeAndNil(FDiskList);
  end;
end;

function TSystemDiskInfo.GetDiskCount: Word;
begin
  Result := FDiskList.Count;
end;

function TSystemDiskInfo.GetDiskDrive: Integer;
var
  DiskInfo: TDiskInfo;
  pcDirveBuffer, pcTempBuffer: PChar;
  dwBytesNeeded: DWORD;
begin
  Result := 0;

  //DiskList Clear
  ClearDisks;

  dwBytesNeeded := GetLogicaldriveStrings(0 , nil);
  pcDirveBuffer := StrAlloc(dwBytesNeeded + 1);

  try
    GetLogicaldriveStrings(dwBytesNeeded, pcDirveBuffer);
    pcTempBuffer := pcDirveBuffer;
    //'c:\ null d:\ null e:\'
    if Assigned(pcTempBuffer) then
      while pcTempBuffer^ <> #0 do
      begin
        if UpperCase(pcTempBuffer) <> 'A:\' then
        begin
          DiskInfo := TDiskInfo.Create(Copy(pcTempBuffer, 1, 2), Result);

          FDiskList.Add(DiskInfo);

          Inc(Result);
        end;
        pcTempBuffer:= StrEnd(pcTempBuffer) + 1;
      end;
  finally
    StrDispose(pcDirveBuffer);
  end;
end;

function TSystemDiskInfo.GetDiskInfo(Index: WORD): TDiskInfo;
begin
  Result := TDiskInfo(FDiskList.Items[Index]);
end;

procedure TSystemDiskInfo.NotifyChange;
var
  iIndex: Integer;
begin
  for iIndex := 0 to FDiskList.Count - 1 do
    DiskItems[iIndex].NotifyChange();
end;

procedure TSystemDiskInfo.PutDiskInfo(Index: WORD; const Value: TDiskInfo);
begin
  FDiskList.Items[Index] := Value;
end;

procedure TSystemDiskInfo.SetDiskInfoChange(const Value: TDiskInfoChangeEvent);
var
  iIndex: Integer;
begin
  for iIndex := 0 to DiskCount - 1 do
    DiskItems[iIndex].OnDiskInfoChange := Value;
end;

procedure TSystemDiskInfo.SetDiskInfoStatistics(const Value: TDiskInfoStatistics);
var
  iIndex: Integer;
begin
  for iIndex := 0 to DiskCount - 1 do
    DiskItems[iIndex].OnDiskInfoStatistics := Value;
end;

{ TDatabaseInfo }

function TDatabaseInfo.CalcStatistics: Boolean;
begin
  if FStatisticsCount = 0 then
  begin
    FStatisticsStartDT := FCollectDateTime;
    FBaseUseSize := FDiskUseSize;
  end;
  FStatisticsEndDT := FCollectDateTime;
  FIncUseSize := FDiskUseSize - FBaseUseSize;

  Inc(FStatisticsCount);

  FSumConnectCount := FSumConnectCount + FConnectCount;
  FAveConnectCount := Round(FSumConnectCount * 100 / FStatisticsCount) div 100;
  Debug.Write(1, Format('Database (%d)ConnectCount=%d, Sum=%d, Ave=%d, IncSize=%d',
                       [FStatisticsCount, FConnectCount, FSumConnectCount, FAveConnectCount, FIncUseSize]) );
end;

procedure TDatabaseInfo.ClearStatisticsValue;
begin
  FStatisticsCount := 0;

  FBaseUseSize := 0;
  FIncUseSize := 0;

  FSumConnectCount := 0;
  FAveConnectCount := 0;

  FStatisticsStartDT := Now();
  FStatisticsEndDT := Now();
end;

function TDatabaseInfo.CollectDatabaseInfo: Boolean;
var
  DatabaseChangeItem: TDatabaseItem;
  dwTemp: DWORD;
begin
  Result := False;

  try
    DatabaseChangeItem := [];

    dwTemp := GetDiskUseSize();
    if dwTemp <> FDiskUseSize then DatabaseChangeItem := DatabaseChangeItem + [dbiDiskUseSize];
    FDiskUseSize := dwTemp;

    dwTemp := GetConnectCount();
    if dwTemp <> FConnectCount then DatabaseChangeItem := DatabaseChangeItem + [dbiConnectCount];
    FConnectCount := dwTemp;

    FCollectDateTime := Now();

    //항목변경 이벤트 발생
    if DatabaseChangeItem <> [] then NotifyChange;

    if IsEqualHour() then
      CalcStatistics() //통계 시작시간과 현재 수집시간대가 같으면 통계를 계산한다.
    else
    begin
      if Assigned(FOnDatabaseInfoStatistics) then //이벤트가 걸려 있으면 이벤트 발생
        FOnDatabaseInfoStatistics(FStatisticsStartDT, FStatisticsEndDT, FIncUseSize, FAveConnectCount);
      //통계를 초기화 한다.
      ClearStatisticsValue;
    end;

    Result := True;
  except
    on E: Exception do
    begin
      Debug.Write(9, 'CollectDatabaseInfo Exception Msg=' + E.Message);
    end;
  end;
end;

constructor TDatabaseInfo.Create;
begin
  ClearStatisticsValue();
  CollectDatabaseInfo();
end;

destructor TDatabaseInfo.Destroy;
begin
  //
end;

function TDatabaseInfo.GetCollectDateTime: String;
begin
  Result := FormatDateTime('YYYYMMDDHHNNSS', FCollectDateTime);
end;

function TDatabaseInfo.GetConnectCount: WORD;
var
  sSQL: String;
  slResponse: TStringList;
  saResponse: TStringArray;
begin
  Result := 0;

  sSQL := 'SELECT COUNT(A.DBID) AS CONN_CNT '
        + 'FROM MASTER..SYSDATABASES A, MASTER..SYSPROCESSES B '
        + 'WHERE A.NAME = ' + QuotedStr(FName) + ' '
        +   'AND A.DBID = B.DBID';

  slResponse := TStringList.Create;
  try
    if not DBFile.ExecSql(slResponse, sSQL, stSelect, False, 0, True, 1000) then Exit;

    GetField(slResponse[0], TAB, saResponse, 5);
    if saResponse[1] <> '0000' then Exit;

    GetField(slResponse[2], TAB, saResponse, 5);
    if saResponse[0] = '' then Exit;

    Result := StrToIntDef(saResponse[0], 0);
  finally
    FreeAndNil(slResponse);
  end;
end;

function TDatabaseInfo.GetDiskUseSize: DWORD;
var
  sSQL: String;
  slResponse: TStringList;
  saResponse: TStringArray;
begin
  sSQL := 'SELECT CEILING(SIZE * 8 / 1024.0) AS DB_SIZE '
        + 'FROM ' + FName + '..SYSFILES '
        + 'WHERE NAME = ' + QuotedStr(FName + '_DATA');

  try
    slResponse := TStringList.Create;

    if not DBFile.ExecSql(slResponse, sSQL, stSelect, False, 0, True, 1000) then Exit;

    GetField(slResponse[0], TAB, saResponse);
    if saResponse[1] <> '0000' then Exit;

    GetField(slResponse[2], TAB, saResponse);

    Result := StrToIntDef(saResponse[0], 0);
  finally
    if Assigned(slResponse) then FreeAndNil(slResponse);
  end;
end;

{ TSystemInfo }

procedure TSystemConfigInfo.CollectSystemConfigInfo;
begin
  if siMemory   in FCollectItem then FMemoryInfo.CollectMemoryInfo;
  if siCPU      in FCollectItem then FCPUInfo.CollectCPUInfo;
  if siDisk     in FCollectItem then FSystemDiskInfo.CollectDiskInfo;
  if siDatabase in FCollectItem then FDatabaseInfo.CollectDatabaseInfo;
end;

constructor TSystemConfigInfo.Create;
begin
  FMemoryInfo    := TMemoryInfo.Create;
  FCPUInfo       := TCPUInfo.Create;
  FSystemDiskInfo:= TSystemDiskInfo.Create;
  FDatabaseInfo  := TDatabaseInfo.Create;
end;

destructor TSystemConfigInfo.Destroy;
begin
  if Assigned(FMemoryInfo)     then FreeAndNil(FMemoryInfo);
  if Assigned(FCPUInfo)        then FreeAndNil(FCPUInfo);
  if Assigned(FSystemDiskInfo) then FreeAndNil(FSystemDiskInfo);
  if Assigned(FDatabaseInfo)   then FreeAndNil(FDatabaseInfo);
end;

function TDatabaseInfo.IsEqualHour: Boolean;
begin
  Result := FormatDateTime('YYYYMMDDHH', FStatisticsStartDT) = FormatDateTime('YYYYMMDDHH', FCollectDateTime); 
end;

procedure TDatabaseInfo.NotifyChange(DatabaseItem: TDatabaseItem);
begin
  if Assigned(FOnDatabaseInfoChange) then
    FOnDatabaseInfoChange(DatabaseItem);
end;

{ Initialization and cleanup }

procedure InitLibrary;
begin
  SystemConfigInfo := TSystemConfigInfo.Create;
end;

procedure DoneLibrary;
begin
  FreeAndNil(SystemConfigInfo);
end;

initialization
  InitLibrary;

finalization
  DoneLibrary;

end.
