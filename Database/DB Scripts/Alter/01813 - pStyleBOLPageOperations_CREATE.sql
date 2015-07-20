SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOLPageOperations](
	[PageOperationId] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Sort] [nvarchar](5) NULL,
	[IsLinked] [int] NULL,
	[OperationId] [uniqueidentifier] NULL,
	[MacroId] [uniqueidentifier] NULL,
	[MacroParentId] [uniqueidentifier] NULL,
	[Code] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NULL,
	[Comments] [nvarchar](200) NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageType] [nvarchar](50) NULL,
	[SAM] [numeric](10, 2) NULL,
	[Coef] [numeric](10, 2) NULL,
	[Adj] [nvarchar](20) NULL,
	[AdjTime] [nvarchar](20) NULL,
	[BaseRateId] [uniqueidentifier] NULL,
	[MachineId] [uniqueidentifier] NULL,
	[IsException] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleBOLPageOperations] PRIMARY KEY CLUSTERED 
(
	[PageOperationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOLPageOperations] ADD  CONSTRAINT [DF_pStyleBOLPageOperations_PageOperationId]  DEFAULT (newid()) FOR [PageOperationId]
GO

ALTER TABLE [dbo].[pStyleBOLPageOperations] ADD  CONSTRAINT [DF_pStyleBOLPageOperations_isException]  DEFAULT ((0)) FOR [IsException]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01813'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01813', GetDate())
END

GO
