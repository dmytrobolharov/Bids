-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 May 2012                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
IF NOT EXISTS(SELECT SystemStringID FROM sSystemStrings WHERE DesignString=N'Material Request')
BEGIN
	INSERT [dbo].[sSystemStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Material Request',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT SystemStringID FROM sSystemStrings WHERE DesignString=N'Colors')
BEGIN
	INSERT [dbo].[sSystemStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Colors',GetDate(), N'administrator')	
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Supplier/Mill Ref. #')
BEGIN	
	INSERT [dbo].[sUserStrings] ([DesignString],  [CDate], [CUser]) VALUES (N'Supplier/Mill Ref. #',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString='Color Name')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Color Name',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Treatment')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Treatment',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Supplier Color Code')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Supplier Color Code',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Supplier Color Name')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Supplier Color Name',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Duty')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Duty',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Freight')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Freight',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Lead Time')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],  [CDate], [CUser]) VALUES (N'Lead Time',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Minimum')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Minimum',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Vendor Price')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],  [CDate], [CUser]) VALUES (N'Vendor Price',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Negot''d Price')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Negot''d Price',GetDate(), N'administrator')
END

IF NOT EXISTS(SELECT UserStringID FROM sUserStrings WHERE DesignString=N'Date Sent')
BEGIN
	INSERT [dbo].[sUserStrings] ([DesignString],[CDate], [CUser]) VALUES (N'Date Sent', GetDate(), N'administrator')
END	




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03482', GetDate())
	
GO


