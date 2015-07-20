IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleRemoval_StyleRemovalID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleRemoval] DROP CONSTRAINT [DF_pStyleRemoval_StyleRemovalID]
END

GO

/****** Object:  Table [dbo].[pStyleRemoval]    Script Date: 02/05/2013 12:22:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleRemoval]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleRemoval]
GO

/****** Object:  Table [dbo].[pStyleRemoval]    Script Date: 02/05/2013 12:22:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pStyleRemoval](
	[StyleRemovalID] [uniqueidentifier] NOT NULL,
	[RemovalTeamID] [uniqueidentifier] NULL,
	[RemovalReasonID] [uniqueidentifier] NULL,
	[RemovalComment] [nvarchar](500) NULL,
	[RemovalDate] [datetime] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleType] [int] NULL,
	[WorkflowType] [uniqueidentifier] NULL,
	[StyleNo] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[StyleCategory] [uniqueidentifier] NULL,
	[SizeClass] [nvarchar](50) NULL,
	[SizeRange] [nvarchar](50) NULL,
	[DueDate] [datetime] NULL,
	[RecDate] [datetime] NULL,
	[DesignSketchID] [uniqueidentifier] NULL,
	[TechSketchID] [uniqueidentifier] NULL,
	[ConceptSketchID] [uniqueidentifier] NULL,
	[ColorSketchID] [uniqueidentifier] NULL,
	[DesignSketchVersion] [int] NULL,
	[TechSketchVersion] [int] NULL,
	[ConceptSketchVersion] [int] NULL,
	[ColorSketchVersion] [int] NULL,
	[DetailSketchID1] [uniqueidentifier] NULL,
	[DetailSketchID2] [uniqueidentifier] NULL,
	[DetailSketchID3] [uniqueidentifier] NULL,
	[DetailSketchID4] [uniqueidentifier] NULL,
	[DetailSketchVersion1] [int] NULL,
	[DetailSketchVersion2] [int] NULL,
	[DetailSketchVersion3] [int] NULL,
	[DetailSketchVersion4] [int] NULL,
	[SpecSketchID1] [uniqueidentifier] NULL,
	[SpecSketchID2] [uniqueidentifier] NULL,
	[SpecSketchID3] [uniqueidentifier] NULL,
	[SpecSketchID4] [uniqueidentifier] NULL,
	[SpecSketchVersion1] [int] NULL,
	[SpecSketchVersion2] [int] NULL,
	[SpecSketchVersion3] [int] NULL,
	[SpecSketchVersion4] [int] NULL,
	[Markup] [numeric](18, 0) NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CustomField6] [nvarchar](200) NULL,
	[CustomField7] [nvarchar](200) NULL,
	[CustomField8] [nvarchar](200) NULL,
	[CustomField9] [nvarchar](200) NULL,
	[CustomField10] [nvarchar](200) NULL,
	[CustomField11] [nvarchar](200) NULL,
	[CustomField12] [nvarchar](200) NULL,
	[CustomField13] [nvarchar](200) NULL,
	[CustomField14] [nvarchar](200) NULL,
	[CustomField15] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CustomField16] [nvarchar](200) NULL,
	[CustomField17] [nvarchar](200) NULL,
	[CustomField18] [nvarchar](200) NULL,
	[CustomField19] [nvarchar](200) NULL,
	[CustomField20] [nvarchar](200) NULL,
	[CustomField21] [nvarchar](200) NULL,
	[CustomField22] [nvarchar](200) NULL,
	[CustomField23] [nvarchar](200) NULL,
	[CustomField24] [nvarchar](200) NULL,
	[CustomField25] [nvarchar](200) NULL,
	[CustomField26] [nvarchar](200) NULL,
	[CustomField27] [nvarchar](200) NULL,
	[CustomField28] [nvarchar](200) NULL,
	[CustomField29] [nvarchar](200) NULL,
	[CustomField30] [nvarchar](200) NULL,
	[CustomField31] [nvarchar](200) NULL,
	[CustomField32] [nvarchar](200) NULL,
	[CustomField33] [nvarchar](200) NULL,
	[CustomField34] [nvarchar](200) NULL,
	[CustomField35] [nvarchar](200) NULL,
	[CustomField36] [nvarchar](200) NULL,
	[CustomField37] [nvarchar](200) NULL,
	[CustomField38] [nvarchar](200) NULL,
	[CustomField39] [nvarchar](200) NULL,
	[CustomField40] [nvarchar](200) NULL,
	[IntroSeasonYearID] [uniqueidentifier] NULL,
	[DesignSketchBackID] [uniqueidentifier] NULL,
	[DesignSketchBackVersion] [int] NULL,
	[OwnerGroup] [nvarchar](50) NULL,
	[StartDate] [datetime] NULL,
	[PlannedDueDate] [datetime] NULL,
	[PlannedStartDate] [datetime] NULL,
	[ScheduleBy] [char](1) NULL,
	[EnforceDependency] [bit] NULL,
	[WorkflowTemplateID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pStyleRemovalLog] PRIMARY KEY CLUSTERED 
(
	[StyleRemovalID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pStyleRemoval] ADD  CONSTRAINT [DF_pStyleRemoval_StyleRemovalID]  DEFAULT (newid()) FOR [StyleRemovalID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04970', GetDate())
GO
