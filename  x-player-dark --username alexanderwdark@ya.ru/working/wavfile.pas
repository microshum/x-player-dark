{ *************************************************************************** }

 { Audio Tools Library                                                         }
 { Class TWAVfile - for manipulating with WAV files                            }

 { http://mac.sourceforge.net/atl/                                             }
 { e-mail: macteam@users.sourceforge.net                                       }

 { Copyright (c) 2000-2002 by Jurgen Faul                                      }
 { Copyright (c) 2003-2005 by The MAC Team                                     }

 { Version 1.5 (April 2005) by Gambit                                          }
 {   - updated to unicode file access                                          }

 { Version 1.44 (23 March 2005) by Gambit                                      }
 {   - multichannel support                                                    }

 { Version 1.43 (27 August 2004) by Gambit                                     }
 {   - added procedures: TrimFromEnd, TrimFromBeginning and FindSilence        }
 {   - removed WriteNewLength procedure (replaced with TrimFromEnd)            }
 {   - fixed some FormatSize/HeaderSize/SampleNumber related bugs              }

 { Version 1.32 (05 June 2004) by Gambit                                       }
 {   - WriteNewLength now properly truncates the file                          }

 { Version 1.31 (April 2004) by Gambit                                         }
 {   - Added Ratio property                                                    }

 { Version 1.3 (22 February 2004) by Gambit                                    }
 {   - SampleNumber is now read correctly                                      }
 {   - added procedure to change the duration (SampleNumber and FileSize)      }
 {     of the wav file (can be used for example to trim off the encoder        }
 {     padding from decoded mp3 files)                                         }

 { Version 1.2 (14 January 2002)                                               }
 {   - Fixed bug with calculating of duration                                  }
 {   - Some class properties added/changed                                     }

 { Version 1.1 (9 October 2001)                                                }
 {   - Fixed bug with WAV header detection                                     }

 { Version 1.0 (31 July 2001)                                                  }
 {   - Info: channel mode, sample rate, bits per sample, file size, duration   }

 { This library is free software; you can redistribute it and/or               }
 { modify it under the terms of the GNU Lesser General Public                  }
 { License as published by the Free Software Foundation; either                }
 { version 2.1 of the License, or (at your option) any later version.          }

 { This library is distributed in the hope that it will be useful,             }
 { but WITHOUT ANY WARRANTY; without even the implied warranty of              }
 { MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU           }
 { Lesser General Public License for more details.                             }

 { You should have received a copy of the GNU Lesser General Public            }
 { License along with this library; if not, write to the Free Software         }
 { Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   }

{ *************************************************************************** }


unit WAVfile;

interface

uses
  Classes, SysUtils;

const
  { Format type names }
  WAV_FORMAT_UNKNOWN = 'Unknown';
  WAV_FORMAT_PCM     = 'Windows PCM';
  WAV_FORMAT_ADPCM   = 'Microsoft ADPCM';
  WAV_FORMAT_ALAW    = 'A-LAW';
  WAV_FORMAT_MULAW   = 'MU-LAW';
  WAV_FORMAT_DVI_IMA_ADPCM = 'DVI/IMA ADPCM';
  WAV_FORMAT_MP3     = 'MPEG Layer III';

  { Channel mode names }
  WAV_MODE: array [0..3] of string = ('Unknown', 'Mono', 'Stereo', 'Multichannel');

type
  { Class TWAVfile }
  TWAVfile = class (TObject)
  private
    { Private declarations }
    FValid:      boolean;
    FFormatSize: cardinal;
    FFormatID:   word;
    FChannelNumber: byte;
    FSampleRate: cardinal;
    FBytesPerSecond: cardinal;
    FBlockAlign: word;
    FBitsPerSample: byte;
    FSampleNumber: cardinal;
    FHeaderSize: cardinal;
    FFileSize:   cardinal;
    FFileName:   WideString;
    FAmountTrimBegin: cardinal;
    FAmountTrimEnd: cardinal;
    FBitrate:    double;
    procedure FResetData;
    function FGetFormat: string;
    function FGetChannelMode: string;
    function FGetDuration: double;
    function FGetRatio: double;
  public
    { Public declarations }
    constructor Create;                                     { Create object }
    function ReadFromFile(const FileName: WideString): boolean;   { Load header }
    property Valid: boolean Read FValid;             { True if header valid }
    property FormatSize: cardinal Read FFormatSize;
    property FormatID: word Read FFormatID;               { Format type code }
    property Format: string Read FGetFormat;              { Format type name }
    property ChannelNumber: byte Read FChannelNumber;     { Number of channels }
    property ChannelMode: string Read FGetChannelMode;    { Channel mode name }
    property SampleRate: cardinal Read FSampleRate;       { Sample rate (hz) }
    property BytesPerSecond: cardinal Read FBytesPerSecond;  { Bytes/second }
    property BlockAlign: word Read FBlockAlign;           { Block alignment }
    property BitsPerSample: byte Read FBitsPerSample;         { Bits/sample }
    property HeaderSize: cardinal Read FHeaderSize;       { Header size (bytes) }
    property FileSize: cardinal Read FFileSize;           { File size (bytes) }
    property Duration: double Read FGetDuration;          { Duration (seconds) }
    property SampleNumber: cardinal Read FSampleNumber;
    procedure TrimFromBeginning(const Samples: cardinal);
    procedure TrimFromEnd(const Samples: cardinal);
    procedure FindSilence(const FromBeginning, FromEnd: boolean);
    property Ratio: double Read FGetRatio;          { Compression ratio (%) }
    property AmountTrimBegin: cardinal Read FAmountTrimBegin;
    property AmountTrimEnd: cardinal Read FAmountTrimEnd;
    property Bitrate: double Read FBitrate;
  end;

implementation

const
  DATA_CHUNK = 'data';                                        { Data chunk ID }

type
  { WAV file header data }
  WAVRecord = record
    { RIFF file header }
    RIFFHeader:    array [1..4] of char;                        { Must be "RIFF" }
    FileSize:      integer;                           { Must be "RealFileSize - 8" }
    WAVEHeader:    array [1..4] of char;                        { Must be "WAVE" }
    { Format information }
    FormatHeader:  array [1..4] of char;                      { Must be "fmt " }
    FormatSize:    cardinal;                                        { Format size }
    FormatID:      word;                                        { Format type code }
    ChannelNumber: word;                                 { Number of channels }
    SampleRate:    integer;                                   { Sample rate (hz) }
    BytesPerSecond: integer;                                   { Bytes/second }
    BlockAlign:    word;                                       { Block alignment }
    BitsPerSample: word;                                        { Bits/sample }
    DataHeader:    array [1..4] of char;                         { Can be "data" }
    SampleNumber:  cardinal;                     { Number of samples (optional) }
  end;

{ ********************* Auxiliary functions & procedures ******************** }

function ReadWAV(const FileName: WideString; var WAVData: WAVRecord): boolean;
var
  SourceFile: TFileStream;
begin
  try
    Result     := True;
    { Set read-access and open file }
    SourceFile := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    { Read header }
    SourceFile.Read(WAVData, 36);

    { Read number of samples }
    if SourceFile.Size > (WAVData.FormatSize + 24) then
      begin
      SourceFile.Seek(WAVData.FormatSize + 24, soFromBeginning);
      SourceFile.Read(WAVData.SampleNumber, 4);
      end;

    SourceFile.Free;
  except
    { Error }
    Result := False;
    end;
end;

{ --------------------------------------------------------------------------- }

function HeaderIsValid(const WAVData: WAVRecord): boolean;
begin
  Result := True;
  { Header validation }
  if WAVData.RIFFHeader <> 'RIFF' then
    Result := False;
  if WAVData.WAVEHeader <> 'WAVE' then
    Result := False;
  if WAVData.FormatHeader <> 'fmt ' then
    Result := False;
  if WAVData.ChannelNumber = 0 then
    Result := False;
end;

{ ********************** Private functions & procedures ********************* }

procedure TWAVfile.FResetData;
begin
  { Reset all data }
  FValid      := False;
  FFormatSize := 0;
  FFormatID   := 0;
  FChannelNumber := 0;
  FSampleRate := 0;
  FBytesPerSecond := 0;
  FBlockAlign := 0;
  FBitsPerSample := 0;
  FSampleNumber := 0;
  FHeaderSize := 0;
  FFileSize   := 0;
  FFileName   := '';
  FAmountTrimBegin := 0;
  FAmountTrimEnd := 0;
  FBitrate    := 0;
end;

{ --------------------------------------------------------------------------- }

function TWAVfile.FGetFormat: string;
begin
  { Get format type name }
  case FFormatID of
    1:
      Result := WAV_FORMAT_PCM;
    2:
      Result := WAV_FORMAT_ADPCM;
    6:
      Result := WAV_FORMAT_ALAW;
    7:
      Result := WAV_FORMAT_MULAW;
    17:
      Result := WAV_FORMAT_DVI_IMA_ADPCM;
    85:
      Result := WAV_FORMAT_MP3;
    else
      Result := '';
    end;
end;

{ --------------------------------------------------------------------------- }

function TWAVfile.FGetChannelMode: string;
begin
  { Get channel mode name }//multichannel
  if FChannelNumber > 2 then
    Result := WAV_MODE[3]
  else
    Result := WAV_MODE[FChannelNumber];
end;

{ --------------------------------------------------------------------------- }

function TWAVfile.FGetDuration: double;
begin
  { Get duration }
  Result := 0;
  if FValid then
    begin
    if (FSampleNumber = 0) and (FBytesPerSecond > 0) then
      Result := (FFileSize - FHeaderSize) / FBytesPerSecond;
    if (FSampleNumber > 0) and (FSampleRate > 0) then
      Result := FSampleNumber / FSampleRate;
    end;
end;

{ ********************** Public functions & procedures ********************** }

constructor TWAVfile.Create;
begin
  { Create object }
  inherited;
  FResetData;
end;

{ --------------------------------------------------------------------------- }

function TWAVfile.ReadFromFile(const FileName: WideString): boolean;
var
  WAVData: WAVRecord;
begin
  { Reset and load header data from file to variable }
  FResetData;
  FillChar(WAVData, SizeOf(WAVData), 0);
  Result := ReadWAV(FileName, WAVData);
  { Process data if loaded and header valid }
  if (Result) and (HeaderIsValid(WAVData)) then
    begin
    FValid      := True;
    { Fill properties with header data }
    FFormatSize := WAVData.FormatSize;
    FFormatID   := WAVData.FormatID;
    FChannelNumber := WAVData.ChannelNumber;
    FSampleRate := WAVData.SampleRate;
    FBytesPerSecond := WAVData.BytesPerSecond;
    FBlockAlign := WAVData.BlockAlign;
    FBitsPerSample := WAVData.BitsPerSample;
    FSampleNumber := WAVData.SampleNumber div FBlockAlign;
    if WAVData.DataHeader = DATA_CHUNK then
      FHeaderSize := 44
    else
      FHeaderSize := WAVData.FormatSize + 28;
    FFileSize := WAVData.FileSize + 8;
    if FHeaderSize > FFileSize then
      FHeaderSize := FFileSize;
    FFileName := FileName;
    FBitrate := FBytesPerSecond * 8 / 1000;
    end;
end;

{ --------------------------------------------------------------------------- }

function TWAVfile.FGetRatio: double;
begin
  { Get compression ratio }
  if FValid then
    if FSampleNumber = 0 then
      Result := FFileSize / ((FFileSize - FHeaderSize) / FBytesPerSecond *
        FSampleRate * (FChannelNumber * FBitsPerSample / 8) + 44) * 100
    else
      Result := FFileSize / (FSampleNumber * (FChannelNumber *
        FBitsPerSample / 8) + 44) * 100
  else
    Result := 0;
end;

{ --------------------------------------------------------------------------- }

procedure TWAVfile.TrimFromBeginning(const Samples: cardinal);
var
  SourceFile: TFileStream;
  NewData, NewSamples, EraseOldData, NewFormatSize: cardinal;
begin
  try
    // blah, blah... should be self explanatory what happens here...
    SourceFile := TFileStream.Create(FFileName, fmOpenReadWrite or fmShareDenyWrite);

    SourceFile.Seek(16, soFromBeginning);
    NewFormatSize := (Samples * FBlockAlign) + FFormatSize;
    SourceFile.Write(NewFormatSize, SizeOf(NewFormatSize));

    SourceFile.Seek(FHeaderSize - 8, soFromBeginning);
    EraseOldData := 0;
    SourceFile.Write(EraseOldData, SizeOf(EraseOldData));

    SourceFile.Seek(FHeaderSize + (Samples * FBlockAlign) - 8, soFromBeginning);
    NewData := 1635017060;   // 'data'
    SourceFile.Write(NewData, SizeOf(NewData));
    NewSamples := (FSampleNumber - Samples) * FBlockAlign;
    SourceFile.Write(NewSamples, SizeOf(NewSamples));

    FFormatSize   := NewFormatSize;
    FSampleNumber := FSampleNumber - Samples;
    FHeaderSize   := FFormatSize + 28;

    SourceFile.Free;
  except
    { Error }
    end;
end;

{ --------------------------------------------------------------------------- }

procedure TWAVfile.TrimFromEnd(const Samples: cardinal);
var
  SourceFile: TFileStream;
  NewSamples, NewSize: cardinal;
begin
  try
    SourceFile := TFileStream.Create(FFileName, fmOpenReadWrite or fmShareDenyWrite);

    SourceFile.Seek(4, soFromBeginning);

    NewSamples := (FSampleNumber - Samples) * FBlockAlign;
    NewSize    := NewSamples + FHeaderSize - 8;

    SourceFile.Write(NewSize, SizeOf(NewSize));

    SourceFile.Seek(FHeaderSize - 4, soFromBeginning);
    SourceFile.Write(NewSamples, SizeOf(NewSamples));

    SourceFile.Size := NewSamples + FHeaderSize;

    FSampleNumber := FSampleNumber - Samples;
    FFileSize     := NewSamples + FHeaderSize;

    SourceFile.Free;
  except
    { Error }
    end;
end;

{ --------------------------------------------------------------------------- }

procedure TWAVfile.FindSilence(const FromBeginning, FromEnd: boolean);
var
  SourceFile: TFileStream;
  ReadSample: integer;
  AmountBegin, AmountEnd: cardinal;
begin
  try
    SourceFile := TFileStream.Create(FFileName, fmOpenRead or fmShareDenyWrite);

    if FromBeginning then
      begin
      AmountBegin := 0;
      ReadSample  := 0;
      SourceFile.Seek(FHeaderSize, soFromBeginning);
      // this assumes 16bit stereo
      repeat
        SourceFile.Read(ReadSample, SizeOf(ReadSample));
        if ReadSample = 0 then
          Inc(AmountBegin);
      until (ReadSample <> 0) or (SourceFile.Position >= SourceFile.Size);
      FAmountTrimBegin := AmountBegin;
      end;

    if FromEnd then
      begin
      AmountEnd  := 0;
      ReadSample := 0;
      repeat
        // this assumes 16bit stereo
        SourceFile.Seek(FFileSize - ((AmountEnd + 1) * 4), soFromBeginning);
        SourceFile.Read(ReadSample, SizeOf(ReadSample));
        if ReadSample = 0 then
          Inc(AmountEnd);
      until ReadSample <> 0;
      FAmountTrimEnd := AmountEnd;
      end;

    SourceFile.Free;
  except
    { Error }
    end;
end;

{ --------------------------------------------------------------------------- }

end.
