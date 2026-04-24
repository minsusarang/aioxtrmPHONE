# Delphi 11.3 CTI WebSocket Sample

This is a first-pass Delphi 11.3 VCL conversion based on:

- `websocket/wsCapi.js`
- `websocket/wsApp.js`

## Included

- WebSocket URL input
- CTI server input
- Extension input
- Start connect button
- Stop connect button
- Inbound button
- Outbound button
- Dial button
- Answer button
- Hangup button
- Transfer button
- Dial number input
- Transfer number input
- ListBox log for sent/received messages and state changes
- JSON requests aligned with the JavaScript sample
  - `{"req":"login", ...}`
  - `{"req":"logout", ...}`
  - `{"req":"ping"}`
  - `{"req":"setMode", ...}`
  - `{"req":"dial", ...}`
  - `{"req":"answer" | "txAnswer", ...}`
  - `{"req":"hangup" | "reject" | "cancel" | "txCancel" | ...}`
  - `{"req":"transfer" | "reTransfer", ...}`

## Files

- `CtiWebSocketSample.dpr`
- `CtiWebSocketSample.dproj`
- `MainForm.pas`
- `MainForm.dfm`
- `build_win32_d11.cmd`

## SGC WebSockets notes

This sample targets `TsgcWebSocketClient`.

- Unit names can differ slightly by installed version.
- If your installed package generates different event signatures for `OnConnect`, `OnDisconnect`, `OnError`, or `OnMessage`, keep the same logic and only adjust the method declarations.
- The sample uses the standard client flow shown in the vendor examples: `Host`, `Port`, `URL`, `TLS`, `Active`, `WriteData`.

## Local build

Validated on this PC with Delphi 11.3 Win32 compiler and the installed SGC library path:

- `C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\rsvars.bat`
- `C:\Users\mspark\Documents\esegece\sgcWebSockets\LibD11\win32`

You can rebuild with:

```bat
build_win32_d11.cmd

The `.dproj` already includes this Win32 SGC search path, so the project can be opened and built directly in the Delphi IDE on this PC.

## Settings persistence

The application saves the last entered values next to the executable in:

- `CtiWebSocketSample.ini`
```

## Scope

This version covers connect, login, logout, ping, message logging, mode change, dial, answer, hangup, and transfer.

The current implementation tracks runtime fields returned by server messages such as:

- `mode`
- `state`
- `role`
- `uid`
- `achan`
- `cchan`
- `tchan`
- `cphone`
- `tphone`

These values are reused to build CTI requests in the same style as `wsCapi.js`.
