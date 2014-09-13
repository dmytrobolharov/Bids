IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderFinancial_LineFolderFinancialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderFinancial] DROP CONSTRAINT [DF_pLineFolderFinancial_LineFolderFinancialID]
END

GO

/****** Object:  Table [dbo].[pLineFolderFinancial]    Script Date: 03/19/2013 17:40:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderFinancial]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderFinancial]
GO

/****** Object:  Table [dbo].[pLineFolderFinancial]    Script Date: 03/19/2013 17:40:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pLineFolderFinancial](
	[LineFolderFinancialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LineFolderTemplateItemID] [uniqueidentifier] NULL,
	[LineFolderFinancialDataType] [varchar](50) NULL,
	[LineFolderFinancialDataFormat] [varchar](50) NULL,
	[LineFolderFinancialCssClass] [varchar](100) NULL,
	[LineFolderFinancialText] [nvarchar](100) NULL,
	[LineFolderFinancialValue] [nvarchar](50) NULL,
	[LineFolderFinancialGroup] [varchar](50) NULL,
	[LineFolderFinancialSort] [varchar](5) NULL,
	[LineFolderFinancialDelivery] [nvarchar](50) NULL,
	[LineFolderFinancialChannel1] [nvarchar](100) NULL,
	[LineFolderFinancialChannel2] [nvarchar](100) NULL,
	[LineFolderFinancialChannel3] [nvarchar](100) NULL,
	[LineFolderFinancialChannel4] [nvarchar](100) NULL,
	[LineFolderFinancialChannel5] [nvarchar](100) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[LinePlanFinancialViewRollup] [nvarchar](500) NULL,
	[BlankIfNull] [int] NULL,
 CONSTRAINT [PK_pLineFolderFinancial] PRIMARY KEY CLUSTERED 
(
	[LineFolderFinancialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pLineFolderFinancial] ADD  CONSTRAINT [DF_pLineFolderFinancial_LineFolderFinancialID]  DEFAULT (newid()) FOR [LineFolderFinancialID]
GO

INSERT INTO [pLineFolderFinancial]
           ([LineFolderFinancialID]
           ,[LineFolderTemplateItemID]
           ,[LineFolderFinancialDataType]
           ,[LineFolderFinancialDataFormat]
           ,[LineFolderFinancialCssClass]
           ,[LineFolderFinancialText]
           ,[LineFolderFinancialValue]
           ,[LineFolderFinancialGroup]
           ,[LineFolderFinancialSort]
           ,[LineFolderFinancialDelivery]
           ,[LineFolderFinancialChannel1]
           ,[LineFolderFinancialChannel2]
           ,[LineFolderFinancialChannel3]
           ,[LineFolderFinancialChannel4]
           ,[LineFolderFinancialChannel5]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate]
           ,[LinePlanFinancialViewRollup]
           ,[BlankIfNull])
     SELECT LinePlanFinancialID,
			LinePlanTemplateItemID,
			LinePlanFinancialDataType,
			LinePlanFinancialDataFormat,
			LinePlanFinancialCssClass,
			LinePlanFinancialText,
			LinePlanFinancialValue,
			LinePlanFinancialGroup,
			LinePlanFinancialSort,
			LinePlanFinancialDelivery,
			LinePlanFinancialChannel1,
			LinePlanFinancialChannel2,
			LinePlanFinancialChannel3,
			LinePlanFinancialChannel4,
			LinePlanFinancialChannel5,
			CUser,
			CDate,
			MUser,
			MDate,
			LinePlanFinancialViewRollup,
			BlankIfNull
     FROM pLinePlanFinancial
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05349', GetDate())
GO
