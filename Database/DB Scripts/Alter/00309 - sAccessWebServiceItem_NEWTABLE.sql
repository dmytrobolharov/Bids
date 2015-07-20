-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 August 2010                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'sAccessWebServiceItem') 
BEGIN
CREATE TABLE sAccessWebServiceItem(
	AccessWebServiceItemID uniqueidentifier NOT NULL,
	WebServiceID uniqueidentifier NOT NULL,
	WebServiceItemID uniqueidentifier NOT NULL,
	WebServiceItemSchema nvarchar(200) NOT NULL,
	AccessRoleID int NOT NULL,
	AccessView int NOT NULL,
	AccessCreate int NOT NULL,
	AccessModify int NOT NULL,
	AccessDelete int NOT NULL,
	AccessPrint int NOT NULL,
	WSClientID uniqueidentifier NOT NULL,
	CUser nvarchar(200) NULL,
	CDate datetime NULL,
	MUser nvarchar(200) NULL,
	MDate datetime NULL,
 CONSTRAINT [PK_sAccessWebServiceItem] PRIMARY KEY CLUSTERED 
(
	[AccessWebServiceItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE sAccessWebServiceItem ADD  CONSTRAINT [DF_sAccessWebServiceItem_AccessWebServiceItemID]  DEFAULT (newid()) FOR [AccessWebServiceItemID]

ALTER TABLE sAccessWebServiceItem ADD  CONSTRAINT [DF_sAccessWebServiceItem_AccessRoleID]  DEFAULT ((0)) FOR [AccessRoleID]

ALTER TABLE sAccessWebServiceItem ADD  CONSTRAINT [DF_sAccessWebServiceItem_AccessView]  DEFAULT ((0)) FOR [AccessView]

ALTER TABLE sAccessWebServiceItem ADD  CONSTRAINT [DF_sAccessWebServiceItem_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]

ALTER TABLE sAccessWebServiceItem ADD  CONSTRAINT [DF_sAccessWebServiceItem_AccessModify]  DEFAULT ((0)) FOR [AccessModify]

ALTER TABLE sAccessWebServiceItem ADD  CONSTRAINT [DF_sAccessWebServiceItem_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]

ALTER TABLE sAccessWebServiceItem ADD  CONSTRAINT [DF_sAccessWebServiceItem_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '309', GetDate())
GO
