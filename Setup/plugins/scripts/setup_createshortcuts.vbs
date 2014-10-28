Sub Include(file)
  Dim fso, f

  Set fso = CreateObject("Scripting.FileSystemObject")
  Set f = fso.OpenTextFile(file & ".vbs", 1)

  str = f.ReadAll
  f.Close

  ExecuteGlobal str
End Sub

Include("environ")

Set oShell = CreateObject("WScript.Shell")
Set oFSO = CreateObject("Scripting.FileSystemObject")

sServer = dict("PLM.AppServer.ServerName")
sWSID = dict("PLM.AppServer.SiteID")
 
sLogEntry = "setup_createshortcuts.vbs " & sServer & " " & sWSID
Set oLog = oFSO.OpenTextFile("cli.log", 8, True)
oLog.WriteLine(sLogEntry)
oLog.Close
Set oFSO = Nothing
Set oLog = Nothing
 
sAllUsersDesktopPath = oShell.SpecialFolders("AllUsersDesktop") 
sWinSysDir = oShell.ExpandEnvironmentStrings("%SystemRoot%\System32") 
sCurrDir = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName("..")

Set oShortCut = oShell.CreateShortcut(sAllUsersDesktopPath & "\plmOn" & sWSID & ".lnk")
oShortCut.TargetPath = "http://" & sServer & "/plmOn" & sWSID  
oShortCut.Description = "Yunique plmOn"
oShortCut.IconLocation = sCurrDir & "\images\Yunique_Icon_v6.ico"
oShortCut.Save 
Set oShortCut = Nothing

Set oShortCut1 = oShell.CreateShortcut(sAllUsersDesktopPath & "\YuniqueBI" & sWSID & ".lnk")
oShortCut1.TargetPath = "http://" & sServer & "/YuniqueBI" & sWSID  
oShortCut1.Description = "Yunique Business Intelligence"
oShortCut1.IconLocation = sCurrDir & "\images\Yunique_Icon_v6.ico"
oShortCut1.Save 
Set oShortCut1 = Nothing

Set oShortCut1 = oShell.CreateShortcut(sAllUsersDesktopPath & "\YuniqueToolkit" & sWSID & ".lnk")
oShortCut1.TargetPath = "http://" & sServer & "/YuniqueToolkit" & sWSID  
oShortCut1.Description = "Yunique Toolkit"
oShortCut1.IconLocation = sCurrDir & "\images\Yunique_Icon_v6.ico"
oShortCut1.Save 
Set oShortCut1 = Nothing

Set oShortCut2 = oShell.CreateShortcut(sAllUsersDesktopPath & "\srmOn" & sWSID & ".lnk")
oShortCut2.TargetPath = "http://" & sServer & "/srmOn" & sWSID  
oShortCut2.Description = "Yunique srmOn"
oShortCut2.IconLocation = sCurrDir & "\images\Yunique_Icon_v6.ico"
oShortCut2.Save 
Set oShortCut2 = Nothing

Set pFSO = CreateObject("Scripting.FileSystemObject")
If Not pFSO.FileExists(sAllUsersDesktopPath & "\plmOn" & sWSID & ".lnk") Then     
   
   WScript.Quit(1)   
   
End If 
Set pFSO = Nothing