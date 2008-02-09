{
  BASSWMA 2.2 Delphi API, copyright (c) 2002-2005 Ian Luck.
  Requires BASS 2.2 - available from www.un4seen.com

  See the BASSWMA.CHM file for more complete documentation
}

unit BassWMA;

interface

uses Windows, Bass;

const
  // Additional error codes returned by BASS_ErrorGetCode
  BASS_ERROR_WMA_LICENSE = 1000; // the file is protected
  BASS_ERROR_WMA_WM9     = 1001; // WM9 is required
  BASS_ERROR_WMA_DENIED  = 1002; // access denied (user/pass is invalid)
  BASS_ERROR_WMA_CODEC   = 1003; // no appropriate codec is installed
  BASS_ERROR_WMA_INDIVIDUAL = 1004; // individualization is needed

  // Additional config option
  BASS_CONFIG_WMA_VERIFY = $10100;

  // additional WMA sync type
  BASS_SYNC_WMA_CHANGE = 1001;

  // Additional flags for use with BASS_WMA_EncodeOpen/File/Network/Publish
  BASS_WMA_ENCODE_TAGS   = $10000; // set tags in the WMA encoding
  BASS_WMA_ENCODE_SCRIPT = $20000;
  // set script (mid-stream tags) in the WMA encoding

  // Additional flag for use with BASS_WMA_EncodeGetRates
  BASS_WMA_ENCODE_RATES_VBR = $10000; // get available VBR quality settings

  // WMENCODEPROC "type" values
  BASS_WMA_ENCODE_HEAD = 0;
  BASS_WMA_ENCODE_DATA = 1;
  BASS_WMA_ENCODE_DONE = 2;

  // BASS_CHANNELINFO type
  BASS_CTYPE_STREAM_WMA = $10300;

  // Additional BASS_StreamGetTags type
  BASS_TAG_WMA = 8; // WMA tags : array of null-terminated strings


type
  HWMENCODE = DWORD;    // WMA encoding handle

  CLIENTCONNECTPROC = procedure(handle: HWMENCODE; connect: BOOL;
    ip: PChar; user: DWORD); stdcall;
  {
    Client connection notification callback function.
    handle : The encoder
    connect: TRUE=client is connecting, FALSE=disconnecting
    ip     : The client's IP (xxx.xxx.xxx.xxx:port)
    user   : The 'user' parameter value given when calling BASS_EncodeSetNotify */
  }

  WMENCODEPROC = procedure(handle: HWMENCODE; dtype: DWORD; buffer: Pointer;
    length: DWORD; user: DWORD); stdcall;
  {
    Encoder callback function.
    handle : The encoder handle
    dtype  : The type of data, one of BASS_WMA_ENCODE_xxx values
    buffer : The encoded data
    length : Length of the data
    user   : The 'user' parameter value given when calling BASS_WMA_EncodeOpen
  }


const
  basswmadll = 'basswma.dll';

function BASS_WMA_StreamCreateFile(mem: BOOL; fl: pointer;
  offset, length, flags: DWORD): HSTREAM; stdcall; external basswmadll;
function BASS_WMA_StreamCreateFileUser(buffered: BOOL; flags: DWORD;
  proc: STREAMFILEPROC; user: DWORD): HSTREAM; stdcall; external basswmadll;
function BASS_WMA_GetIWMReader(handle: HSTREAM): Pointer; stdcall; external basswmadll;

function BASS_WMA_EncodeGetRates(freq, chans, flags: DWORD): Pointer;
  stdcall; external basswmadll;
function BASS_WMA_EncodeOpen(freq, chans, flags, bitrate: DWORD;
  proc: WMENCODEPROC; user: DWORD): HWMENCODE; stdcall; external basswmadll;
function BASS_WMA_EncodeOpenFile(freq, chans, flags, bitrate: DWORD;
  fname: PChar): HWMENCODE;
  stdcall; external basswmadll;
function BASS_WMA_EncodeOpenNetwork(freq, chans, flags, bitrate, port, clients: DWORD):
  HWMENCODE;
  stdcall; external basswmadll;
function BASS_WMA_EncodeOpenPublish(freq, chans, flags, bitrate: DWORD;
  url, user, pass: PChar): HWMENCODE; stdcall; external basswmadll;
function BASS_WMA_EncodeGetPort(handle: HWMENCODE): DWORD; stdcall; external basswmadll;
function BASS_WMA_EncodeSetNotify(handle: HWMENCODE; proc: CLIENTCONNECTPROC;
  user: DWORD): BOOL; stdcall; external basswmadll;
function BASS_WMA_EncodeGetClients(handle: HWMENCODE): DWORD; stdcall;
  external basswmadll;
function BASS_WMA_EncodeSetTag(handle: HWMENCODE; tag, Text: PChar): BOOL;
  stdcall; external basswmadll;
function BASS_WMA_EncodeWrite(handle: HWMENCODE; buffer: Pointer; length: DWORD): BOOL;
  stdcall; external basswmadll;
procedure BASS_WMA_EncodeClose(handle: HWMENCODE); stdcall; external basswmadll;


implementation

end.
