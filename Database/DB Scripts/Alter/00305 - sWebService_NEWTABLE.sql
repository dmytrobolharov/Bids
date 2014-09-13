-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 August 2010                                                                             */
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

IF NOT EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'sWebService')
BEGIN 
CREATE TABLE sWebService(
	WebServiceID uniqueidentifier ROWGUIDCOL NOT NULL,
	WebServiceName nvarchar(200) NOT NULL,
	WebServiceDefaultSchema nvarchar(200) NOT NULL,
	Active nvarchar(10) NULL,
	CUser nvarchar(50) NULL,
	CDate datetime NULL,
	MUser nvarchar(50) NULL,
	MDate datetime NULL,
 CONSTRAINT PK_sWebService PRIMARY KEY CLUSTERED 
(
	WebServiceID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]


EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sWebService', @level2type=N'COLUMN',@level2name=N'WebServiceID'

EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sWebService', @level2type=N'COLUMN',@level2name=N'WebServiceID'

EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sWebService', @level2type=N'COLUMN',@level2name=N'WebServiceID'

ALTER TABLE [dbo].[sWebService] ADD  CONSTRAINT [DF_sWebService_WebServiceID]  DEFAULT (newid()) FOR [WebServiceID]

ALTER TABLE [dbo].[sWebService] ADD  CONSTRAINT [DF_sWebService_Active]  DEFAULT ((0)) FOR [Active]
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '305', GetDate())
GO
