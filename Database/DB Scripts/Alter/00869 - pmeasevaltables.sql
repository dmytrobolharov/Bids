/****** Object:  Table [dbo].[pMSEvalSampMeas]    Script Date: 12/14/2010 13:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pMSEvalSampMeas](
	[SampleMeasId] [uniqueidentifier] NOT NULL,
	[SampleRequestHeaderId] [uniqueidentifier] NOT NULL,
	[SamplepomId] [uniqueidentifier] NULL,
	[SampleLabelId] [uniqueidentifier] NULL,
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[AMLMeasPomid] [uniqueidentifier] NULL,
	[AMLMeasIGCId] [uniqueidentifier] NULL,
	[POMRow] [int] NOT NULL,
	[SampleIndex] [int] NOT NULL,
	[EvalMeasValue] [numeric](18, 4) NULL,
	[VdrMeasValue] [numeric](18, 4) NULL,
	[VdrDelta] [numeric](18, 4) NULL,
	[VdrOutTol] [int] NULL,
	[SampMeasValue] [numeric](18, 4) NULL,
	[SampDelta] [numeric](18, 4) NULL,
	[SampOutTol] [int] NULL,
	[SampPOMComment] [nvarchar](510) NULL,
	[RevisedSpec] [numeric](18, 0) NULL,
	[ColLabel] [nvarchar](24) NULL,
	[IsVisible] [int] NOT NULL,
	[IsSample] [int] NOT NULL,
	[IsVendor] [int] NOT NULL,
 CONSTRAINT [PK_pMSEvalSampMeas] PRIMARY KEY CLUSTERED 
(
	[SampleMeasId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pMSEvalSampLbl]    Script Date: 12/14/2010 13:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pMSEvalSampLbl](
	[SampleLabelId] [uniqueidentifier] NOT NULL,
	[SampleRequestHeaderId] [uniqueidentifier] NOT NULL,
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[SampleIndex] [int] NOT NULL,
	[DateSampReq] [datetime] NULL,
	[DateSampProv] [datetime] NULL,
	[DateVdrMeasured] [datetime] NULL,
	[VdrMeasurer] [nvarchar](100) NULL,
	[VdrComment] [text] NULL,
	[DateSampMeasured] [datetime] NULL,
	[SampMeasurer] [nvarchar](100) NULL,
	[SampComment] [text] NULL,
	[SampStatusId] [int] NULL,
	[SampStatus] [nvarchar](100) NULL,
	[SampType] [nvarchar](100) NULL,
	[FitAttendee] [nvarchar](100) NULL,
 CONSTRAINT [PK_pMSEvalSampLbl] PRIMARY KEY CLUSTERED 
(
	[SampleLabelId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pMSEvalPom]    Script Date: 12/14/2010 13:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pMSEvalPom](
	[SamplePomId] [uniqueidentifier] NOT NULL,
	[SampleRequestHeaderId] [uniqueidentifier] NOT NULL,
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[AmlMeaspomid] [uniqueidentifier] NULL,
	[POMRow] [int] NOT NULL,
	[Refcode] [nvarchar](12) NULL,
	[POMDescription] [nvarchar](204) NULL,
	[TolPlus] [numeric](18, 4) NOT NULL,
	[TolMinus] [numeric](18, 4) NOT NULL,
	[WSRowId] [int] NOT NULL,
	[HowToMeasurText] [nvarchar](4000) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[SortId] [int] NOT NULL,
 CONSTRAINT [PK_pMSEvalPom] PRIMARY KEY CLUSTERED 
(
	[SamplePomId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pMSEvalHeader]    Script Date: 12/14/2010 13:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pMSEvalHeader](
	[SampleRequestHeaderId] [uniqueidentifier] NOT NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[WorkFlowItemId] [uniqueidentifier] NULL,
	[StyleId] [uniqueidentifier] NOT NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[AMLMeasHdrId] [uniqueidentifier] NOT NULL,
	[Submit] [int] NULL,
	[CompanyName] [nvarchar](60) NULL,
	[IsRelative] [int] NULL,
	[IsMetric] [int] NULL,
	[SizeClassId] [uniqueidentifier] NULL,
	[SizeClass] [nvarchar](60) NULL,
	[SizeRangeId] [uniqueidentifier] NULL,
	[SizeRange] [nvarchar](60) NULL,
	[ProductTypeId] [uniqueidentifier] NULL,
	[ProductType] [nvarchar](100) NULL,
	[SampleSizeId] [uniqueidentifier] NULL,
	[SampleSize] [nvarchar](24) NULL,
	[EvalSizeId] [uniqueidentifier] NOT NULL,
	[EvalSize] [nvarchar](24) NOT NULL,
	[FactoryId] [uniqueidentifier] NULL,
	[FactoryName] [nvarchar](100) NULL,
	[AgentId] [uniqueidentifier] NULL,
	[AgentName] [nvarchar](100) NULL,
	[Pattern] [nvarchar](100) NULL,
	[PatternId] [int] NULL,
	[PatternStatus] [nvarchar](40) NULL,
	[RevisionStatus] [nvarchar](100) NULL,
	[Revised] [int] NULL,
	[Comments] [text] NULL,
	[DateDue] [datetime] NULL,
 CONSTRAINT [PK_pMSEvalHeader] PRIMARY KEY CLUSTERED 
(
	[SampleRequestHeaderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Default [DF_pMSEvalHeader_HeaderId]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalHeader] ADD  CONSTRAINT [DF_pMSEvalHeader_HeaderId]  DEFAULT (newid()) FOR [SampleRequestHeaderId]
GO
/****** Object:  Default [DF_pMSEvalPom_SamplePomId]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalPom] ADD  CONSTRAINT [DF_pMSEvalPom_SamplePomId]  DEFAULT (newid()) FOR [SamplePomId]
GO
/****** Object:  Default [DF_pMSEvalPom_TolPlus]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalPom] ADD  CONSTRAINT [DF_pMSEvalPom_TolPlus]  DEFAULT ((0)) FOR [TolPlus]
GO
/****** Object:  Default [DF_pMSEvalPom_TolMinus]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalPom] ADD  CONSTRAINT [DF_pMSEvalPom_TolMinus]  DEFAULT ((0)) FOR [TolMinus]
GO
/****** Object:  Default [DF_pMSEvalPom_SortId]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalPom] ADD  CONSTRAINT [DF_pMSEvalPom_SortId]  DEFAULT ((0)) FOR [SortId]
GO
/****** Object:  Default [DF_pMSEvalSampLbl_SampleLabelId]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampLbl] ADD  CONSTRAINT [DF_pMSEvalSampLbl_SampleLabelId]  DEFAULT (newid()) FOR [SampleLabelId]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_SampleMeasId]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_SampleMeasId]  DEFAULT (newid()) FOR [SampleMeasId]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_EvalMeasValue]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_EvalMeasValue]  DEFAULT ((0)) FOR [EvalMeasValue]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_VdrMeasValue]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_VdrMeasValue]  DEFAULT ((0)) FOR [VdrMeasValue]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_VdrDelta]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_VdrDelta]  DEFAULT ((0)) FOR [VdrDelta]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_VdrOutTol]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_VdrOutTol]  DEFAULT ((0)) FOR [VdrOutTol]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_SampMeasValue]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_SampMeasValue]  DEFAULT ((0)) FOR [SampMeasValue]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_SampDelta]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_SampDelta]  DEFAULT ((0)) FOR [SampDelta]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_SampOutTol]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_SampOutTol]  DEFAULT ((0)) FOR [SampOutTol]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_RevisedSpec]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_RevisedSpec]  DEFAULT ((0)) FOR [RevisedSpec]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_IsVisible]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_IsVisible]  DEFAULT ((0)) FOR [IsVisible]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_IsSample]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_IsSample]  DEFAULT ((0)) FOR [IsSample]
GO
/****** Object:  Default [DF_pMSEvalSampMeas_IsVendor]    Script Date: 12/14/2010 13:15:01 ******/
ALTER TABLE [dbo].[pMSEvalSampMeas] ADD  CONSTRAINT [DF_pMSEvalSampMeas_IsVendor]  DEFAULT ((0)) FOR [IsVendor]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '869', GetDate())
GO