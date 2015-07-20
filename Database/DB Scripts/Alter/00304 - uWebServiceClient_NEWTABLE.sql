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

IF NOT EXISTS (SELECT * from INFORMATION_SCHEMA.tables where table_name = N'uWebServiceClient') 
BEGIN
CREATE TABLE uWebServiceClient(
	WSClientID uniqueidentifier ROWGUIDCOL NOT NULL,
	WSClientName nvarchar(200) NOT NULL,
	Address1 nvarchar(200) NULL,
	Address2 nvarchar(200) NULL,
	City nvarchar(100) NULL,
	State nvarchar(50) NULL,
	PostalCode nvarchar(50) NULL,
	Country nvarchar(100) NULL,
	PhoneNumber nvarchar(50) NULL,
	FaxNumber nvarchar(50) NULL,
	Username nvarchar(25) NULL,
	Password nvarchar(25) NULL,
	ContactName1 nvarchar(200) NULL,
	ContactTitle1 nvarchar(100) NULL,
	ContactEmail1 nvarchar(200) NULL,
	ContactName2 nvarchar(200) NULL,
	ContactTitle2 nvarchar(100) NULL,
	ContactEmail2 nvarchar(200) NULL,
	ContactName3 nvarchar(200) NULL,
	ContactTitle3 nvarchar(100) NULL,
	ContactEmail3 nvarchar(200) NULL,
	ContactName4 nvarchar(200) NULL,
	ContactTitle4 nvarchar(100) NULL,
	ContactEmail4 nvarchar(200) NULL,
	Active nvarchar(10) NULL,
	CUser nvarchar(50) NULL,
	CDate datetime NULL,
	MUser nvarchar(50) NULL,
	MDate datetime NULL,
 CONSTRAINT PK_uWebServiceClient PRIMARY KEY CLUSTERED 
(
	WSClientID ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'uWebServiceClient', @level2type=N'COLUMN',@level2name=N'WSClientID'
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'uWebServiceClient', @level2type=N'COLUMN',@level2name=N'WSClientID'
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'uWebServiceClient', @level2type=N'COLUMN',@level2name=N'WSClientID'
ALTER TABLE [dbo].[uWebServiceClient] ADD  CONSTRAINT [DF_uWebServiceClient_WSClientID]  DEFAULT (newid()) FOR [WSClientID]
ALTER TABLE [dbo].[uWebServiceClient] ADD  CONSTRAINT [DF_uWebServiceClient_Active]  DEFAULT ((0)) FOR [Active]

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '304', GetDate())
GO
