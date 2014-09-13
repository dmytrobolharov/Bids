
/****** Object:  Table [dbo].[pStyleBOMDimType]    Script Date: 09/06/2011 10:01:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pStyleBOMDimType](
	[DimTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[DimTypeName] [nvarchar](200) NULL,
	[DimTypeDesc] [nvarchar](4000) NULL,
	[DimType] [int] NULL,
	[DimTypePkID] [varchar](100) NULL,
	[DimTypeXmlSearch] [varchar](400) NULL,
	[DimTypeXmlForm] [varchar](200) NULL,
	[DimTypeXmlGrid] [varchar](200) NULL,
	[DimTypeUrl] [varchar](400) NULL,
	[DimTypeTable] [varchar](200) NULL,
	[DimTypeSPX] [varchar](200) NULL,
	[DimTypeHdrSPX] [nvarchar](200) NULL,
	[DimTypeText] [varchar](200) NULL,
	[DimTypeValue] [varchar](200) NULL,
	[DimTypeFilter] [varchar](200) NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleBOMDimType] PRIMARY KEY CLUSTERED 
(
	[DimTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pStyleBOMDimType] ADD  CONSTRAINT [DF_pStyleBOMDimType_DimTypeID]  DEFAULT (newsequentialid()) FOR [DimTypeID]
GO

ALTER TABLE [dbo].[pStyleBOMDimType] ADD  CONSTRAINT [DF_pStyleBOMDimType_Sort]  DEFAULT ((0)) FOR [Sort]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01855'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01855', GetDate())
	END
	
	
	GO