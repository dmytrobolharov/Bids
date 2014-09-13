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


IF NOT EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'sAccessWebService')
BEGIN 
CREATE TABLE sAccessWebService(
	AccessWebServiceID uniqueidentifier NOT NULL,
	WebServiceID uniqueidentifier NOT NULL,
	WebServiceSchema nvarchar(200) NOT NULL,
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
 CONSTRAINT [PK_sAccessWebService] PRIMARY KEY CLUSTERED 
(
	[AccessWebServiceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE sAccessWebService ADD  CONSTRAINT [DF_sAccessWebService_AccessWebServiceID]  DEFAULT (newid()) FOR [AccessWebServiceID]

ALTER TABLE sAccessWebService ADD  CONSTRAINT [DF_sAccessWebService_AccessRoleID]  DEFAULT ((0)) FOR [AccessRoleID]

ALTER TABLE sAccessWebService ADD  CONSTRAINT [DF_sAccessWebService_AccessView]  DEFAULT ((0)) FOR [AccessView]

ALTER TABLE sAccessWebService ADD  CONSTRAINT [DF_sAccessWebService_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]

ALTER TABLE sAccessWebService ADD  CONSTRAINT [DF_sAccessWebService_AccessModify]  DEFAULT ((0)) FOR [AccessModify]

ALTER TABLE sAccessWebService ADD  CONSTRAINT [DF_sAccessWebService_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]

ALTER TABLE sAccessWebService ADD  CONSTRAINT [DF_sAccessWebService_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '308', GetDate())
GO
