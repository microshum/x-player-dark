{ *************************************************************************** }

 { Audio Tools Library                                                         }
 { Class TMPEGplus - for manipulating with Musepack file information           }

 { http://mac.sourceforge.net/atl/                                             }
 { e-mail: macteam@users.sourceforge.net                                       }

 { Copyright (c) 2000-2002 by Jurgen Faul                                      }
 { Copyright (c) 2003-2005 by The MAC Team                                     }

 { Version 1.9 (13 April 2004) by Gambit                                       }
 {   - Added Ratio property                                                    }

 { Version 1.81 (27 September 2003)                                            }
 {   - changed minimal allowed bitrate to '3' (e.g. encoded digital silence)   }

 { Version 1.8 (20 August 2003) by Madah                                       }
 {   - Will now read files with different samplerates correctly                }
 {   - Also changed GetProfileID() for this to work                            }
 {   - Added the ability to determine encoder used                             }

 { Version 1.7 (7 June 2003) by Gambit                                         }
 {   - --quality 0 to 10 detection (all profiles)                              }
 {   - Stream Version 7.1 detected and supported                               }

 { Version 1.6 (8 February 2002)                                               }
 {   - Fixed bug with property Corrupted                                       }

 { Version 1.2 (2 August 2001)                                                 }
 {   - Some class properties added/changed                                     }

 { Version 1.1 (26 July 2001)                                                  }
 {   - Fixed reading problem with "read only" files                            }

 { Version 1.0 (23 May 2001)                                                   }
 {   - Support for MPEGplus files (stream versions 4-7)                        }
 {   - Class TID3v1: reading & writing support for ID3v1 tags                  }
 {   - Class TID3v2: reading & writing support for ID3v2 tags                  }
 {   - Class TAPEtag: reading & writing support for APE tags                   }

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

unit MPEGplus;

interface

uses
  Classes, SysUtils, ID3v1, ID3v2, APEtag;

const
  { Used with ChannelModeID property }
  MPP_CM_STEREO = 1;                                  { Index for stereo mode }
  MPP_CM_JOINT_STEREO = 2;                      { Index for joint-stereo mode }

  { Channel mode names }
  MPP_MODE: array [0..2] of string = ('Unknown', 'Stereo', 'Joint Stereo');

  { Used with ProfileID property }
  MPP_PROFILE_QUALITY0  = 9;                           { '--quality 0' profile }
  MPP_PROFILE_QUALITY1  = 10;                           { '--quality 1' profile }
  MPP_PROFILE_TELEPHONE = 11;                            { 'Telephone' profile }
  MPP_PROFILE_THUMB     = 1;                             { 'Thumb' (poor) quality }
  MPP_PROFILE_RADIO     = 2;                           { 'Radio' (normal) quality }
  MPP_PROFILE_STANDARD  = 3;                       { 'Standard' (good) quality }
  MPP_PROFILE_XTREME    = 4;                      { 'Xtreme' (very good) quality }
  MPP_PROFILE_INSANE    = 5;                      { 'Insane' (excellent) quality }
  MPP_PROFILE_BRAINDEAD = 6;                { 'BrainDead' (excellent) quality }
  MPP_PROFILE_QUALITY9  = 7;               { '--quality 9' (excellent) quality }
  MPP_PROFILE_QUALITY10 = 8;             { '--quality 10' (excellent) quality }
  MPP_PROFILE_UNKNOWN   = 0;                                  { Unknown profile }
  MPP_PROFILE_EXPERIMENTAL = 12;
  { Profile names }
  MPP_PROFILE: array [0..12] of string =
    ('Unknown', 'Thumb', 'Radio', 'Standard', 'Xtreme', 'Insane', 'BrainDead',
    '--quality 9', '--quality 10', '--quality 0', '--quality 1',
    'Telephone', 'Experimental');

type
  { Class TMPEGplus }
  TMPEGplus = class (TObject)
  private
    { Private declarations }
    FValid:      boolean;
    FChannelModeID: byte;
    FFileSize:   integer;
    FFrameCount: integer;
    FSampleRate: integer;
    FBitRate:    word;
    FStreamVersion: byte;
    FProfileID:  byte;
    FID3v1:      TID3v1;
    FID3v2:      TID3v2;
    FAPEtag:     TAPEtag;
    FEncoder:    string;
    procedure FResetData;
    function FGetChannelMode: string;
    function FGetBitRate: word;
    function FGetProfile: string;
    function FGetDuration: double;
    function FIsCorrupted: boolean;
    function FGetRatio: double;
  public
    { Public declarations }
    constructor Create;                                     { Create object }
    destructor Destroy; override;                          { Destroy object }
    function ReadFromFile(const FileName: string): boolean;   { Load header }
    property Valid: boolean Read FValid;             { True if header valid }
    property ChannelModeID: byte Read FChannelModeID;   { Channel mode code }
    property ChannelMode: string Read FGetChannelMode;  { Channel mode name }
    property FileSize: integer Read FFileSize;          { File size (bytes) }
    property FrameCount: integer Read FFrameCount;       { Number of frames }
    property BitRate: word Read FGetBitRate;                     { Bit rate }
    property StreamVersion: byte Read FStreamVersion;      { Stream version }
    property SampleRate: integer Read FSampleRate;
    property ProfileID: byte Read FProfileID;                { Profile code }
    property Profile: string Read FGetProfile;               { Profile name }
    property ID3v1: TID3v1 Read FID3v1;                    { ID3v1 tag data }
    property ID3v2: TID3v2 Read FID3v2;                    { ID3v2 tag data }
    property APEtag: TAPEtag Read FAPEtag;                   { APE tag data }
    property Duration: double Read FGetDuration;       { Duration (seconds) }
    property Corrupted: boolean Read FIsCorrupted;     { True if file corrupted }
    property Encoder: string Read FEncoder;                  { Encoder used }
    property Ratio: double Read FGetRatio;             { Compression ratio (%) }
  end;

implementation

const
  { ID code for stream version 7 and 7.1 }
  STREAM_VERSION_7_ID  = 120279117;                   { 120279117 = 'MP+' + #7 }
  STREAM_VERSION_71_ID = 388714573;                 { 388714573 = 'MP+' + #23 }

type
  { File header data - for internal use }
  HeaderRecord = record
    ByteArray:    array [1..32] of byte;                    { Data as byte array }
    IntegerArray: array [1..8] of integer;                  { Data as integer array }
    FileSize:     integer;                                            { File size }
    ID3v2Size:    integer;                                  { ID3v2 tag size (bytes) }
  end;

{ ********************* Auxiliary functions & procedures ******************** }

function ReadHeader(const FileName: string; var Header: HeaderRecord): boolean;
var
  SourceFile:  file;
  Transferred: integer;
begin
  try
    Result := True;
    { Set read-access and open file }
    AssignFile(SourceFile, FileName);
    FileMode := 0;
    Reset(SourceFile, 1);
    Seek(SourceFile, Header.ID3v2Size);
    { Read header and get file size }
    BlockRead(SourceFile, Header, 32, Transferred);
    Header.FileSize := FileSize(SourceFile);
    CloseFile(SourceFile);
    { if transfer is not complete }
    if Transferred < 32 then
      Result := False
    else
      Move(Header.ByteArray, Header.IntegerArray, SizeOf(Header.ByteArray));
  except
    { Error }
    Result := False;
    end;
end;

{ --------------------------------------------------------------------------- }

function GetStreamVersion(const Header: HeaderRecord): byte;
begin
  { Get MPEGplus stream version }
  if Header.IntegerArray[1] = STREAM_VERSION_7_ID then
    Result := 7
  else
  if Header.IntegerArray[1] = STREAM_VERSION_71_ID then
    Result := 71
  else
    case (Header.ByteArray[2] mod 32) div 2 of
      3:
        Result := 4;
      7:
        Result := 5;
      11:
        Result := 6
      else
        Result := 0;
      end;
end;

{ --------------------------------------------------------------------------- }

function GetSampleRate(const Header: HeaderRecord): integer;
const
  mpp_samplerates: array[0..3] of integer = (44100, 48000, 37800, 32000);
begin
   (* get samplerate from header
      note: this is the same byte where profile is stored
   *)
  Result := mpp_samplerates[Header.ByteArray[11] and 3];
end;

function GetEncoder(const Header: HeaderRecord): string;
var
  EncoderID: integer;
begin
  EncoderID := Header.ByteArray[11 + 2 + 15];
  Result    := '';
  if EncoderID = 0 then

  else
    case (EncoderID mod 10) of
      0:
        Result := format('%u.%u Release', [EncoderID div 100,
          (EncoderID div 10) mod 10]);
      2, 4, 6, 8:
        Result := format('%u.%.2u Beta', [EncoderID div 100, EncoderID mod 100]);
      else
        Result := format('%u.%.2u --Alpha--', [EncoderID div 100, EncoderID mod 100]);
      end;
end;

{ --------------------------------------------------------------------------- }

function GetChannelModeID(const Header: HeaderRecord): byte;
begin
  if (GetStreamVersion(Header) = 7) or (GetStreamVersion(Header) = 71) then
    { Get channel mode for stream version 7 }
    if (Header.ByteArray[12] mod 128) < 64 then
      Result := MPP_CM_STEREO
    else
      Result := MPP_CM_JOINT_STEREO
  else
  { Get channel mode for stream version 4-6 }  if (Header.ByteArray[3] mod 128) = 0 then
    Result := MPP_CM_STEREO
  else
    Result := MPP_CM_JOINT_STEREO;
end;

{ --------------------------------------------------------------------------- }

function GetFrameCount(const Header: HeaderRecord): integer;
begin
  { Get frame count }
  case GetStreamVersion(Header) of
    4:
      Result := Header.IntegerArray[2] shr 16;
    5..71:
      Result := Header.IntegerArray[2];
    else
      Result := 0;
    end;
end;

{ --------------------------------------------------------------------------- }

function GetBitRate(const Header: HeaderRecord): word;
begin
  { Try to get bit rate }
  case GetStreamVersion(Header) of
    4, 5:
      Result := Header.IntegerArray[1] shr 23;
    else
      Result := 0;
    end;
end;

{ --------------------------------------------------------------------------- }

function GetProfileID(const Header: HeaderRecord): byte;
begin
  Result := MPP_PROFILE_UNKNOWN;
  { Get MPEGplus profile (exists for stream version 7 only) }
  if (GetStreamVersion(Header) = 7) or (GetStreamVersion(Header) = 71) then
    // ((and $F0) shr 4) is needed because samplerate is stored in the same byte!
    case ((Header.ByteArray[11] and $F0) shr 4) of
      1:
        Result := MPP_PROFILE_EXPERIMENTAL;
      5:
        Result := MPP_PROFILE_QUALITY0;
      6:
        Result := MPP_PROFILE_QUALITY1;
      7:
        Result := MPP_PROFILE_TELEPHONE;
      8:
        Result := MPP_PROFILE_THUMB;
      9:
        Result := MPP_PROFILE_RADIO;
      10:
        Result := MPP_PROFILE_STANDARD;
      11:
        Result := MPP_PROFILE_XTREME;
      12:
        Result := MPP_PROFILE_INSANE;
      13:
        Result := MPP_PROFILE_BRAINDEAD;
      14:
        Result := MPP_PROFILE_QUALITY9;
      15:
        Result := MPP_PROFILE_QUALITY10;
      end;
end;

{ ********************** Private functions & procedures ********************* }

procedure TMPEGplus.FResetData;
begin
  FValid      := False;
  FChannelModeID := 0;
  FFileSize   := 0;
  FFrameCount := 0;
  FBitRate    := 0;
  FStreamVersion := 0;
  FSampleRate := 0;
  FEncoder    := '';
  FProfileID  := MPP_PROFILE_UNKNOWN;
  FID3v1.ResetData;
  FID3v2.ResetData;
  FAPEtag.ResetData;
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetChannelMode: string;
begin
  Result := MPP_MODE[FChannelModeID];
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetBitRate: word;
var
  CompressedSize: integer;
begin
  Result := FBitRate;
  { Calculate bit rate if not given }
  CompressedSize := FFileSize - FID3v2.Size - FAPEtag.Size;
  if FID3v1.Exists then
    Dec(FFileSize, 128);
  if (Result = 0) and (FFrameCount > 0) then
    Result := Round(CompressedSize * 8 * (FSampleRate / 1000) / FFRameCount / 1152);
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetProfile: string;
begin
  Result := MPP_PROFILE[FProfileID];
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetDuration: double;
begin
  { Calculate duration time }
  if FSampleRate > 0 then
    Result := FFRameCount * 1152 / FSampleRate
  else
    Result := 0;
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FIsCorrupted: boolean;
begin
  { Check for file corruption }
  Result := (FValid) and ((FGetBitRate < 3) or (FGetBitRate > 480));
end;

{ ********************** Public functions & procedures ********************** }

constructor TMPEGplus.Create;
begin
  inherited;
  FID3v1  := TID3v1.Create;
  FID3v2  := TID3v2.Create;
  FAPEtag := TAPEtag.Create;
  FResetData;
end;

{ --------------------------------------------------------------------------- }

destructor TMPEGplus.Destroy;
begin
  FID3v1.Free;
  FID3v2.Free;
  FAPEtag.Free;
  inherited;
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.ReadFromFile(const FileName: string): boolean;
var
  Header: HeaderRecord;
begin
  { Reset data and load header from file to variable }
  FResetData;
  FillChar(Header, SizeOf(Header), 0);
  { At first try to load ID3v2 tag data, then header }
  if FID3v2.ReadFromFile(FileName) then
    Header.ID3v2Size := FID3v2.Size;
  Result := ReadHeader(FileName, Header);
  { Process data if loaded and file valid }
  if (Result) and (Header.FileSize > 0) and (GetStreamVersion(Header) > 0) then
    begin
    FValid      := True;
    { Fill properties with header data }
    FSampleRate := GetSampleRate(Header);
    FChannelModeID := GetChannelModeID(Header);
    FFileSize   := Header.FileSize;
    FFrameCount := GetFrameCount(Header);
    FBitRate    := GetBitRate(Header);
    FStreamVersion := GetStreamVersion(Header);
    FProfileID  := GetProfileID(Header);
    FEncoder    := GetEncoder(Header);
    FID3v1.ReadFromFile(FileName);
    FAPEtag.ReadFromFile(FileName);
    end;
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetRatio: double;
begin
  { Get compression ratio }
  if (FValid) and ((FChannelModeID = MPP_CM_STEREO) or
    (FChannelModeID = MPP_CM_JOINT_STEREO)) then
    Result := FFileSize / ((FFrameCount * 1152) * (2 * 16 / 8) + 44) * 100
  else
    Result := 0;
end;

{ --------------------------------------------------------------------------- }

end.
