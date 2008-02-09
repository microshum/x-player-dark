unit WPTaskbarNotifier;

{
 Based on:
 CTaskbarNotifier C++ class
 By John O'Byrne - 05 July 2002

 Translated to Delphi component by Dennis Ivanoff. Feb 2005.
}

interface

uses
  Windows, Messages, Classes, Graphics, Controls;

const
     WM_TASKBARNOTIFIERCLICKED = WM_USER + 123;
     TN_TEXT_NORMAL	       = $0000;
     TN_TEXT_BOLD	       = $0001;
     TN_TEXT_ITALIC	       = $0002;
     TN_TEXT_UNDERLINE	       = $0004;
  
type
  ByteArr = Array of Byte;

  TWPTaskbarNotifyEngine = class(TCustomControl)
  protected
    m_myNormalFont: TFont;
    m_mySelectedFont: TFont;
    m_hCursor: TCursor;

    m_biSkinBackground: TBitmap;
    m_hSkinRegion: HRGN;
    m_rcText: TRect;
    m_nSkinWidth: Integer;
    m_nSkinHeight: Integer;

    m_strCaption: AnsiString;
    m_bMouseIsOver: Boolean;
    m_nAnimStatus: Integer;

    m_dwTimeToShow: Longint;
    m_dwTimeToLive: Longint;
    m_dwTimeToHide: Longint;
    m_dwDelayBetweenShowEvents: Longint;
    m_dwDelayBetweenHideEvents: Longint;

    m_nStartPosX: Integer;
    m_nStartPosY: Integer;
    m_nCurrentPosX: Integer;
    m_nCurrentPosY: Integer;
    m_nTaskbarPlacement: Integer;
    m_nIncrement: Integer;

    FOnClick: TNotifyEvent;

    procedure CreateParams(var Params: TCreateParams); override;

    function Get24BitPixels(pBitmap: HBITMAP; var wWidth: Word; var wHeight: Word): ByteArr;
    function GenerateRegion(hBitmap: HBITMAP; red: Byte; green: Byte; blue: Byte): HRGN;

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;    
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;

    procedure Paint; override;

    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;

    procedure Hide;    
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetTextRect(rcText: TRect);
   
    function SetSkin(ABitmap: TBitmap): Boolean;

    procedure Show(szCaption: AnsiString; ANormalFont, ASelectedFont: TFont; dwTimeToShow: Longint = 500; dwTimeToLive: Longint = 3000; dwTimeToHide: Longint = 500; nIncrement: Integer = 1; OnClick: TNotifyEvent = NIL);
  end;

  TWPTaskbarNotifier = class(TComponent)
  private
     Eng: TWPTaskbarNotifyEngine;
     sMessage: AnsiString;
     ANormalFont,
     ASelectedFont: TFont;

     dwTimeToShow,
     dwTimeToLive,
     dwTimeToHide: Longint;
     nIncrement: Integer;

     FOnClick: TNotifyEvent;

     ASkinBitmap: TBitmap;
     iRed,
     iGreen,
     iBlue: Smallint;

     ARect: TRect;
  public
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;

     procedure SetNormalFont(Value: TFont);
     procedure SetSelectedFont(Value: TFont);

     procedure SetSkin(Value: TBitmap);

     procedure Show;
  published
     property Message: AnsiString read sMessage write sMessage;

     property Skin: TBitmap read ASkinBitmap write SetSkin;

     property TextLeftPadding: Integer   read ARect.Left   write ARect.Left;
     property TextTopPadding: Integer    read ARect.Top    write ARect.Top;
     property TextRightPadding: Integer  read ARect.Right  write ARect.Right;
     property TextBottomPadding: Integer read ARect.Bottom write ARect.Bottom;

     property NormalFont: TFont   read ANormalFont   write SetNormalFont;
     property SelectedFont: TFont read ASelectedFont write SetSelectedFont;

     property TimeToShow: Longint read dwTimeToShow write dwTimeToShow;
     property TimeToLive: Longint read dwTimeToLive write dwTimeToLive;
     property TimeToHide: Longint read dwTimeToHide write dwTimeToHide;
     property Increment:  Integer read nIncrement   write nIncrement;

     property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

procedure Register;

implementation

uses Types

, dialogs

;

procedure Register;
begin
  RegisterComponents('Win32', [TWPTaskbarNotifier]);
end;

////////////////////////////////////////////////////////////////////////////////
const
     IDT_HIDDEN	        = 0;
     IDT_APPEARING	= 1;
     IDT_WAITING	= 2;
     IDT_DISAPPEARING	= 3;

     TASKBAR_ON_TOP	= 1;
     TASKBAR_ON_LEFT	= 2;
     TASKBAR_ON_RIGHT	= 3;
     TASKBAR_ON_BOTTOM	= 4;

constructor TWPTaskbarNotifyEngine.Create(AOwner: TComponent);
Begin
     inherited Create(AOwner);

     m_strCaption := '';

     m_bMouseIsOver := FALSE;
     m_hSkinRegion := 0;
     m_hCursor := 0;
     
     m_biSkinBackground := TBitmap.Create;
     m_nSkinHeight := 1;
     m_nSkinWidth := 1;

     m_dwTimeToShow := 0;
     m_dwTimeToLive := 0;
     m_dwTimeToHide := 0;
     m_dwDelayBetweenShowEvents := 0;
     m_dwDelayBetweenHideEvents := 0;
     m_nStartPosX := 0;
     m_nStartPosY := 0;
     m_nCurrentPosX := 0;
     m_nCurrentPosY := 0;
     m_nIncrement := 2;
     m_nTaskbarPlacement := 0;
     m_nAnimStatus := IDT_HIDDEN;
     m_rcText := Rect(0,0,0,0);

     m_myNormalFont := TFont.Create;
     m_mySelectedFont := TFont.Create;
End;

procedure TWPTaskbarNotifyEngine.CreateParams(var Params: TCreateParams);
Begin
      inherited CreateParams(Params);
      With Params Do Begin
           Style := WS_POPUP or WS_BORDER;
           WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
           If NewStyleControls
              Then ExStyle := WS_EX_TOOLWINDOW;
           AddBiDiModeExStyle(ExStyle);
           End;
End;

destructor TWPTaskbarNotifyEngine.Destroy;
Begin
     m_biSkinBackground.Free;
     m_myNormalFont.Free;
     m_mySelectedFont.Free;
     // No need to delete the HRGN, SetWindowRgn() owns it after being called
     inherited Destroy;
End;

function TWPTaskbarNotifyEngine.Get24BitPixels(pBitmap: HBITMAP; var wWidth: Word; var wHeight: Word): ByteArr;
Type
    LPBITMAPINFO = ^BITMAPINFO;
var
   bmpBmp: Bitmap;
   bmiInfo: BITMAPINFO;
   pbmiInfo: LPBITMAPINFO;
   
   wBmpWidth, wBmpHeight: Word;
   DC: HDC;
   iRes: Integer;
Begin
     GetObject(pBitmap, sizeof(bmpBmp), @bmpBmp);

     pbmiInfo := @bmpBmp;
     pbmiInfo := @bmpBmp;
     
     wBmpWidth := pbmiInfo.bmiHeader.biWidth;
     Dec(wBmpWidth, wBmpWidth MOD 4);

     wBmpHeight := pbmiInfo.bmiHeader.biHeight;

     wWidth := wBmpWidth;
     wHeight := wBmpHeight;

     SetLength(RESULT, wBmpWidth * wBmpHeight * 3);

     DC := GetWindowDC(0);

     bmiInfo.bmiHeader.biSize := sizeof(BITMAPINFOHEADER);
     bmiInfo.bmiHeader.biWidth := wBmpWidth;
     bmiInfo.bmiHeader.biHeight := -wBmpHeight;
     bmiInfo.bmiHeader.biPlanes := 1;
     bmiInfo.bmiHeader.biBitCount := 24;
     bmiInfo.bmiHeader.biCompression := BI_RGB;
     bmiInfo.bmiHeader.biSizeImage := wBmpWidth * wBmpHeight * 3;
     bmiInfo.bmiHeader.biXPelsPerMeter := 0;
     bmiInfo.bmiHeader.biYPelsPerMeter := 0;
     bmiInfo.bmiHeader.biClrUsed := 0;
     bmiInfo.bmiHeader.biClrImportant := 0;

     // get pixels from the original bitmap converted to 24bits
     iRes := GetDIBits(DC, pBitmap, 0, wBmpHeight, RESULT, bmiInfo, DIB_RGB_COLORS);

     // release the device context
     ReleaseDC(0, DC);

     // if failed, cancel the operation.
     If iRes = 0 Then
        SetLength(RESULT, 0);
End;

function TWPTaskbarNotifyEngine.GenerateRegion(hBitmap: HBITMAP; red: Byte; green: Byte; blue: Byte): HRGN;
var
   wBmpWidth, wBmpHeight: Word;
   p, x, y: Longint;
   TmpRgn: HRGN;
   pPixels: ByteArr;
   jRed, jGreen, jBlue: Byte;
Begin
     RESULT := 0;
     // 24bit pixels from the bitmap
     pPixels := Get24BitPixels(hBitmap, wBmpWidth, wBmpHeight);
     If pPixels <> NIL Then Begin
	// create our working region
	RESULT := CreateRectRgn(0, 0, wBmpWidth, wBmpHeight);
	If RESULT <> 0 Then Begin
	   p := 0;
	   For y:=0 To wBmpHeight-1 Do
               For x:=0 To wBmpWidth-1 Do Begin
                   jRed := pPixels[p+2];
                   jGreen := pPixels[p+1];
                   jBlue := pPixels[p+0];
                   If (jRed = red) AND (jGreen = green) AND (jBlue = blue) Then Begin
                      // remove transparent color from region
                      TmpRgn := CreateRectRgn(x,y,x+1,y+1);
                      CombineRgn(RESULT, RESULT, TmpRgn, RGN_XOR);
                      DeleteObject(TmpRgn);
                      End;
		// next pixel
                Inc(p, 3);
                End;
           End;

	// release pixels
        SetLength(pPixels, 0);
        End;
End;

procedure TWPTaskbarNotifyEngine.SetTextRect(rcText: TRect);
Begin
     m_rcText := rcText;
End;

function TWPTaskbarNotifyEngine.SetSkin(ABitmap: TBitmap): Boolean;
var
   red, green, blue: Smallint;
Begin
     m_biSkinBackground.Assign(ABitmap);

     m_nSkinWidth := m_biSkinBackground.Width;
     m_nSkinHeight := m_biSkinBackground.Height;
     m_rcText := Rect(0, 0, m_nSkinWidth, m_nSkinHeight);

     Red := GetRValue(m_biSkinBackground.TransparentColor);
     Green := GetGValue(m_biSkinBackground.TransparentColor);
     Blue := GetBValue(m_biSkinBackground.TransparentColor);

     If (red <> -1) AND (green <> -1) AND (blue <> -1) Then Begin
        // No need to delete the HRGN,  SetWindowRgn() owns it after being called
        m_hSkinRegion := GenerateRegion(m_biSkinBackground.Handle, red, green, blue);
        SetWindowRgn(Handle, m_hSkinRegion, TRUE);
        End;
     RESULT := TRUE;
End;

procedure TWPTaskbarNotifyEngine.Show(szCaption: AnsiString; ANormalFont, ASelectedFont: TFont; dwTimeToShow: Longint = 500; dwTimeToLive: Longint = 3000; dwTimeToHide: Longint = 500; nIncrement: Integer = 1; OnClick: TNotifyEvent = NIL);
var
   nDesktopHeight, nDesktopWidth, nScreenWidth, nScreenHeight: Longint;
   rcDesktop: TRect;
   bTaskbarOnRight, bTaskbarOnLeft, bTaskBarOnTop, bTaskbarOnBottom: Boolean;
Begin
     m_strCaption := szCaption;
     m_dwTimeToShow := dwTimeToShow;
     m_dwTimeToLive := dwTimeToLive;
     m_dwTimeToHide := dwTimeToHide;

     If ANormalFont <> NIL Then
        m_myNormalFont.Assign(ANormalFont);
     If ASelectedFont <> NIL Then
        m_mySelectedFont.Assign(ASelectedFont);

     FOnClick := OnClick;

     SystemParametersInfo(SPI_GETWORKAREA, 0, @rcDesktop, 0);
     
     nDesktopWidth := rcDesktop.right - rcDesktop.left;
     nDesktopHeight := rcDesktop.bottom - rcDesktop.top;
     nScreenWidth := GetSystemMetrics(SM_CXSCREEN);
     nScreenHeight := GetSystemMetrics(SM_CYSCREEN);

     bTaskbarOnRight := (nDesktopWidth < nScreenWidth) AND (rcDesktop.left = 0);
     bTaskbarOnLeft := (nDesktopWidth < nScreenWidth) AND (rcDesktop.left <> 0);
     bTaskBarOnTop := (nDesktopHeight<nScreenHeight) AND (rcDesktop.top <> 0);
     bTaskbarOnBottom := (nDesktopHeight<nScreenHeight) AND (rcDesktop.top = 0);

     Case m_nAnimStatus Of
     IDT_HIDDEN: Begin
          ShowWindow(Handle, SW_SHOW);
          If bTaskbarOnRight Then Begin
             m_dwDelayBetweenShowEvents := Round(m_dwTimeToShow/(m_nSkinWidth/m_nIncrement));
             m_dwDelayBetweenHideEvents := Round(m_dwTimeToHide/(m_nSkinWidth/m_nIncrement));
             m_nStartPosX := rcDesktop.right;
             m_nStartPosY := rcDesktop.bottom - m_nSkinHeight;
             m_nTaskbarPlacement := TASKBAR_ON_RIGHT;
             End
          Else If bTaskbarOnLeft Then Begin
             m_dwDelayBetweenShowEvents := Round(m_dwTimeToShow/(m_nSkinWidth/m_nIncrement));
             m_dwDelayBetweenHideEvents := Round(m_dwTimeToHide/(m_nSkinWidth/m_nIncrement));
             m_nStartPosX := rcDesktop.left - m_nSkinWidth;
             m_nStartPosY := rcDesktop.bottom - m_nSkinHeight;
             m_nTaskbarPlacement := TASKBAR_ON_LEFT;
             End
          Else If bTaskBarOnTop Then Begin
             m_dwDelayBetweenShowEvents := Round(m_dwTimeToShow/(m_nSkinHeight/m_nIncrement));
             m_dwDelayBetweenHideEvents := Round(m_dwTimeToHide/(m_nSkinHeight/m_nIncrement));
             m_nStartPosX := rcDesktop.right - m_nSkinWidth;
             m_nStartPosY := rcDesktop.top - m_nSkinHeight;
             m_nTaskbarPlacement := TASKBAR_ON_TOP;
             End
          Else Begin //if (bTaskbarOnBottom)
             // Taskbar is on the bottom or Invisible
             m_dwDelayBetweenShowEvents := Round(m_dwTimeToShow/(m_nSkinHeight/m_nIncrement));
             m_dwDelayBetweenHideEvents := Round(m_dwTimeToHide/(m_nSkinHeight/m_nIncrement));
             m_nStartPosX := rcDesktop.right - m_nSkinWidth;
             m_nStartPosY := rcDesktop.bottom;
             m_nTaskbarPlacement := TASKBAR_ON_BOTTOM;
             End;

          m_nCurrentPosX := m_nStartPosX;
          m_nCurrentPosY := m_nStartPosY;

          SetTimer(Handle, IDT_APPEARING, m_dwDelayBetweenShowEvents, NIL);
          End;
     IDT_WAITING: Begin
          Invalidate;
          KillTimer(Handle, IDT_WAITING);
          SetTimer(Handle, IDT_WAITING, m_dwTimeToLive, NIL);
          End;
     IDT_APPEARING:
          Invalidate;
     IDT_DISAPPEARING: Begin
          KillTimer(Handle, IDT_DISAPPEARING);
          SetTimer(Handle, IDT_WAITING, m_dwTimeToLive, NIL);
          If bTaskbarOnRight Then
             m_nCurrentPosX := rcDesktop.right - m_nSkinWidth
          Else If bTaskbarOnLeft Then
             m_nCurrentPosX := rcDesktop.left
          Else If bTaskBarOnTop Then
             m_nCurrentPosY := rcDesktop.top
          Else //if (bTaskbarOnBottom)
             m_nCurrentPosY := rcDesktop.bottom - m_nSkinHeight;

          SetWindowPos(Handle, 0, m_nCurrentPosX, m_nCurrentPosY, m_nSkinWidth, m_nSkinHeight, SWP_NOOWNERZORDER OR SWP_NOZORDER OR SWP_NOACTIVATE);
          Invalidate;
          End;
     End; // case end
End;

procedure TWPTaskbarNotifyEngine.Hide;
Begin
     Case m_nAnimStatus Of
     IDT_APPEARING:    KillTimer(Handle, IDT_APPEARING);
     IDT_WAITING:      KillTimer(Handle, IDT_WAITING);
     IDT_DISAPPEARING: KillTimer(Handle, IDT_DISAPPEARING);
     End;

     MoveWindow(Handle,  0, 0, 0, 0, FALSE);
     ShowWindow(Handle, SW_HIDE);
     m_nAnimStatus := IDT_HIDDEN;
End;

/////////////////////  M E S S A G E    M A P S  ///////////////////////////////
procedure TWPTaskbarNotifyEngine.MouseMove(Shift: TShiftState; X, Y: Integer);
var
   t_MouseEvent: tagTRACKMOUSEEVENT;
Begin
     t_MouseEvent.cbSize      := sizeof(tagTRACKMOUSEEVENT);
     t_MouseEvent.dwFlags     := TME_LEAVE OR TME_HOVER;
     t_MouseEvent.hwndTrack   := Handle;
     t_MouseEvent.dwHoverTime := 1;
     TrackMouseEvent(t_MouseEvent);

     inherited MouseMove(Shift, X, Y);
End;

procedure TWPTaskbarNotifyEngine.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
     inherited MouseUp(Button, Shift, X, Y);

     If Assigned(FOnClick) Then
        FOnClick(SELF.Owner);     
End;

procedure TWPTaskbarNotifyEngine.CMMouseEnter(var Message: TMessage);
Begin
     m_bMouseIsOver := TRUE;
     inherited;
     Invalidate;
End;

procedure TWPTaskbarNotifyEngine.CMMouseLeave(var Message: TMessage);
Begin
     m_bMouseIsOver := FALSE;
     inherited;
     Invalidate;
End;

procedure TWPTaskbarNotifyEngine.Paint;
var
   OldMode: Integer;
Begin
     inherited Paint;
     
     Canvas.Draw(0, 0, m_biSkinBackground);

     If m_bMouseIsOver Then 
        Canvas.Font := m_mySelectedFont
     Else
        Canvas.Font := m_myNormalFont;

     OldMode := SetBkMode(Canvas.Handle, TRANSPARENT);
     try
        DrawText(Canvas.Handle, PChar(m_strCaption), -1, m_rcText, DT_CENTER OR DT_VCENTER OR DT_WORDBREAK OR DT_END_ELLIPSIS);
     finally
        SetBkMode(Canvas.Handle, OldMode);
     end;
End;

procedure TWPTaskbarNotifyEngine.WMTimer(var Message: TWMTimer);
Begin
     Case Message.TimerID Of
     IDT_APPEARING: Begin
          m_nAnimStatus := IDT_APPEARING;
          Case m_nTaskbarPlacement Of
          TASKBAR_ON_BOTTOM:
               If m_nCurrentPosY > (m_nStartPosY-m_nSkinHeight) Then
                  Dec(m_nCurrentPosY, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_APPEARING);
                  SetTimer(Handle, IDT_WAITING, m_dwTimeToLive, NIL);
                  m_nAnimStatus := IDT_WAITING;
                  End;
          TASKBAR_ON_TOP:
               If (m_nCurrentPosY - m_nStartPosY) < m_nSkinHeight Then
                  Inc(m_nCurrentPosY, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_APPEARING);
                  SetTimer(Handle, IDT_WAITING, m_dwTimeToLive, NIL);
                  m_nAnimStatus := IDT_WAITING;
                  End;
          TASKBAR_ON_LEFT:
               If (m_nCurrentPosX - m_nStartPosX) < m_nSkinWidth Then
                  Inc(m_nCurrentPosX, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_APPEARING);
                  SetTimer(Handle, IDT_WAITING, m_dwTimeToLive, NIL);
                  m_nAnimStatus := IDT_WAITING;
                  End;
          TASKBAR_ON_RIGHT:
               If m_nCurrentPosX > (m_nStartPosX-m_nSkinWidth) Then
                  Dec(m_nCurrentPosX, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_APPEARING);
                  SetTimer(Handle, IDT_WAITING, m_dwTimeToLive, NIL);
                  m_nAnimStatus := IDT_WAITING;
                  End;
          End; // case end
          SetWindowPos(Handle, 0, m_nCurrentPosX, m_nCurrentPosY, m_nSkinWidth, m_nSkinHeight, SWP_NOOWNERZORDER OR SWP_NOZORDER OR SWP_NOACTIVATE);
          End;
     IDT_WAITING: Begin
          KillTimer(Handle, IDT_WAITING);
          SetTimer(Handle, IDT_DISAPPEARING, m_dwDelayBetweenHideEvents, NIL);
          End;
     IDT_DISAPPEARING: Begin
          m_nAnimStatus := IDT_DISAPPEARING;
          Case m_nTaskbarPlacement Of
          TASKBAR_ON_BOTTOM:
               If m_nCurrentPosY < m_nStartPosY Then
                  Inc(m_nCurrentPosY, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_DISAPPEARING);
                  Hide;
                  End;
          TASKBAR_ON_TOP:
               If m_nCurrentPosY > m_nStartPosY Then
                  Dec(m_nCurrentPosY, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_DISAPPEARING);
                  Hide;
                  End;
          TASKBAR_ON_LEFT:
               If m_nCurrentPosX > m_nStartPosX Then
                  Dec(m_nCurrentPosX, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_DISAPPEARING);
                  Hide;
                  End;
          TASKBAR_ON_RIGHT:
               If m_nCurrentPosX < m_nStartPosX Then
                  Inc(m_nCurrentPosX, m_nIncrement)
               Else Begin
                  KillTimer(Handle, IDT_DISAPPEARING);
                  Hide;
                  End;
          End; // case end
          SetWindowPos(Handle, 0, m_nCurrentPosX, m_nCurrentPosY, m_nSkinWidth, m_nSkinHeight, SWP_NOOWNERZORDER OR SWP_NOZORDER OR SWP_NOACTIVATE);
          End;
     End; // case end
     inherited;
End;

////////////////////////////////////////////////////////////////////////////////
constructor TWPTaskbarNotifier.Create(AOwner: TComponent);
Begin
     inherited Create(AOwner);

     Eng := TWPTaskbarNotifyEngine.Create(SELF);

     sMessage := 'Сообщение';

     ANormalFont := TFont.Create;
     ASelectedFont := TFont.Create;
     ASelectedFont.Style := ASelectedFont.Style + [fsUnderline];

     dwTimeToShow := 500;
     dwTimeToLive := 3000;
     dwTimeToHide := 500;
     nIncrement := 1;

     ASkinBitmap := TBitmap.Create;
     iRed := -1;
     iGreen := -1;
     iBlue := -1;
End;

destructor TWPTaskbarNotifier.Destroy;
Begin
     Eng.Free;
     ASkinBitmap.Free;
     ANormalFont.Free;
     ASelectedFont.Free;
     inherited Destroy;
End;

procedure TWPTaskbarNotifier.SetNormalFont(Value: TFont);
begin
     ANormalFont.Assign(Value);
end;

procedure TWPTaskbarNotifier.SetSelectedFont(Value: TFont);
begin
     ASelectedFont.Assign(Value);
end;

procedure TWPTaskbarNotifier.SetSkin(Value: TBitmap);
Begin
     ASkinBitmap.Assign(Value);     
End;

procedure TWPTaskbarNotifier.Show;
Begin
     If (Eng <> NIL) AND (NOT ASkinBitmap.Empty) Then Begin
        Eng.SetSkin(ASkinBitmap);
        Eng.SetTextRect(Rect(ARect.Left, ARect.Top, ASkinBitmap.Width - ARect.Right, ASkinBitmap.Height - ARect.Bottom));
        Eng.Show(sMessage, ANormalFont, ASelectedFont, dwTimeToShow, dwTimeToLive, dwTimeToHide, nIncrement, FOnClick);
        End;
End;

end.
