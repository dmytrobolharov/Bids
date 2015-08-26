-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 June 2015                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2015 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF (OBJECT_ID('Yunify', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[Yunify](
		[YunifyID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
		[TableName] [nvarchar](500) NOT NULL,
		[PKFields] [xml] NOT NULL,
		[FieldValues] [xml] NULL,
		[CRUDType] [nvarchar](1) NOT NULL,
		[MDate] [datetime] NOT NULL,
		[ErrMsgs] [xml] NULL,
	 CONSTRAINT [PK_Yunify] PRIMARY KEY CLUSTERED 
	(
		[YunifyID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	ALTER TABLE [dbo].[Yunify] ADD  CONSTRAINT [DF_Yunify_YunifyID]  DEFAULT (newid()) FOR [YunifyID]
	ALTER TABLE [dbo].[Yunify] ADD  CONSTRAINT [DF_Yunify_CRUDType]  DEFAULT ('C') FOR [CRUDType]
	ALTER TABLE [dbo].[Yunify] ADD  CONSTRAINT [DF_Yunify_MDate]  DEFAULT (getutcdate()) FOR [MDate]
END
GO

SET NOCOUNT OFF
GO
