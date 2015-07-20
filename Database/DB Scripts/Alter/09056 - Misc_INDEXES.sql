/*** pSavedSearch ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pSavedSearch]') AND name = N'IX_pSavedSearch_TeamID')
DROP INDEX [IX_pSavedSearch_TeamID] ON [dbo].[pSavedSearch] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pSavedSearch_TeamID] ON [dbo].[pSavedSearch] 
(
	[TeamID] ASC
)
INCLUDE ( [Active],
[Folder],
[CDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*** sSystemHelp ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sSystemHelp]') AND name = N'IX_sSystemHelp_sSystemPageID')
DROP INDEX [IX_sSystemHelp_sSystemPageID] ON [dbo].[sSystemHelp] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sSystemHelp_sSystemPageID] ON [dbo].[sSystemHelp] 
(
	[sSystemPageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*** sSystemPage ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sSystemPage]') AND name = N'IX_sSystemPage_MappingPage')
DROP INDEX [IX_sSystemPage_MappingPage] ON [dbo].[sSystemPage] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sSystemPage_MappingPage] ON [dbo].[sSystemPage] 
(
	[MappingPage] ASC
)
INCLUDE ( [sSystemFolderID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** sAppSetting ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sAppSetting]') AND name = N'IX_sAppSetting_AppSettingKey')
DROP INDEX [IX_sAppSetting_AppSettingKey] ON [dbo].[sAppSetting] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sAppSetting_AppSettingKey] ON [dbo].[sAppSetting] 
(
	[AppSettingKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** sExchangeRate ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sExchangeRate]') AND name = N'IX_sExchangeRate_Season')
DROP INDEX [IX_sExchangeRate_Season] ON [dbo].[sExchangeRate] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sExchangeRate_Season] ON [dbo].[sExchangeRate] 
(
	[Season] ASC,
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** sExchangeRateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sExchangeRateItem]') AND name = N'IX_sExchangeRateItem_BaseCurrency')
DROP INDEX [IX_sExchangeRateItem_BaseCurrency] ON [dbo].[sExchangeRateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sExchangeRateItem_BaseCurrency] ON [dbo].[sExchangeRateItem] 
(
	[ExchangeRateID] ASC
)
INCLUDE ( [BaseCurrency]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pNBOLTemplateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLTemplateItem]') AND name = N'IX_pNBOLTemplateItem_TemplateID')
DROP INDEX [IX_pNBOLTemplateItem_TemplateID] ON [dbo].[pNBOLTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pNBOLTemplateItem_TemplateID] ON [dbo].[pNBOLTemplateItem] 
(
	[TemplateID] ASC
)
INCLUDE ( [MachineID],
[OperationID],
[OperationTypeID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** sSystemCulture ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sSystemCulture]') AND name = N'IX_sSystemCulture_SystemCultureId')
DROP INDEX [IX_sSystemCulture_SystemCultureId] ON [dbo].[sSystemCulture] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sSystemCulture_SystemCultureId] ON [dbo].[sSystemCulture] 
(
	[SystemCultureId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** rReportStylePageItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[rReportStylePageItem]') AND name = N'IX_rReportStylePageItem_ReportMapID')
DROP INDEX [IX_rReportStylePageItem_ReportMapID] ON [dbo].[rReportStylePageItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_rReportStylePageItem_ReportMapID] ON [dbo].[rReportStylePageItem] 
(
	[ReportMapID] ASC,
	[ReportPageActive] ASC,
	[ReportIsWorkflow] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTACalReference ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReference]') AND name = N'IX_pTACalReference_ReferenceId')
DROP INDEX [IX_pTACalReference_ReferenceId] ON [dbo].[pTACalReference] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalReference_ReferenceId] ON [dbo].[pTACalReference] 
(
	[ReferenceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTACalReferenceTask ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReferenceTask]') AND name = N'IX_pTACalReferenceTask_TACalReferenceId')
DROP INDEX [IX_pTACalReferenceTask_TACalReferenceId] ON [dbo].[pTACalReferenceTask] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalReferenceTask_TACalReferenceId] ON [dbo].[pTACalReferenceTask] 
(
	[TACalReferenceId] ASC
)
INCLUDE ( [TACalTemplateTaskId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTACalReference ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalReference]') AND name = N'IX_pTACalReference_TACalTemplateId_TACalReferenceTypeId')
DROP INDEX [IX_pTACalReference_TACalTemplateId_TACalReferenceTypeId] ON [dbo].[pTACalReference] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTACalReference_TACalTemplateId_TACalReferenceTypeId] ON [dbo].[pTACalReference] 
(
	[TACalTemplateId] ASC,
	[TACalReferenceTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pCompliance ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pCompliance]') AND name = N'IX_pCompliance_ComplianceTypeId')
DROP INDEX [IX_pCompliance_ComplianceTypeId] ON [dbo].[pCompliance] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pCompliance_ComplianceTypeId] ON [dbo].[pCompliance] 
(
	[ComplianceTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pLineListHistory ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pLineListHistory]') AND name = N'IX_pLineListHistory_TeamID')
DROP INDEX [IX_pLineListHistory_TeamID] ON [dbo].[pLineListHistory] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pLineListHistory_TeamID] ON [dbo].[pLineListHistory] 
(
	[TeamID] ASC,
	[CDate] DESC
)
INCLUDE ( [LineFolderID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pCalendarHeader ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarHeader]') AND name = N'IX_pCalendarHeader_SeasonYearID')
DROP INDEX [IX_pCalendarHeader_SeasonYearID] ON [dbo].[pCalendarHeader] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pCalendarHeader_SeasonYearID] ON [dbo].[pCalendarHeader] 
(
	[SeasonYearID] ASC,
	[Active] ASC
)
INCLUDE ( [CalendarName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTemplateStyleDetailItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTemplateStyleDetailItem]') AND name = N'IX_pTemplateStyleDetailItem_TemplateStyleDetailID')
DROP INDEX [IX_pTemplateStyleDetailItem_TemplateStyleDetailID] ON [dbo].[pTemplateStyleDetailItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTemplateStyleDetailItem_TemplateStyleDetailID] ON [dbo].[pTemplateStyleDetailItem] 
(
	[TemplateStyleDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pGRMeasurementsClassRange ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsClassRange]') AND name = N'IX_pGRMeasurementsClassRange_SizeClassID')
DROP INDEX [IX_pGRMeasurementsClassRange_SizeClassID] ON [dbo].[pGRMeasurementsClassRange] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pGRMeasurementsClassRange_SizeClassID] ON [dbo].[pGRMeasurementsClassRange] 
(
	[SizeClassId] ASC,
	[SizeRangeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pGRMeasurementsPOMAlternates ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMAlternates]') AND name = N'IX_pGRMeasurementsPOMAlternates_POMId')
DROP INDEX [IX_pGRMeasurementsPOMAlternates_POMId] ON [dbo].[pGRMeasurementsPOMAlternates] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pGRMeasurementsPOMAlternates_POMId] ON [dbo].[pGRMeasurementsPOMAlternates] 
(
	[POMId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** pGRMeasurementsPOMTemplateGroup ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMTemplateGroup]') AND name = N'IX_pGRMeasurementsPOMTemplateGroup_POMTempGroupID')
DROP INDEX [IX_pGRMeasurementsPOMTemplateGroup_POMTempGroupID] ON [dbo].[pGRMeasurementsPOMTemplateGroup] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pGRMeasurementsPOMTemplateGroup_POMTempGroupID] ON [dbo].[pGRMeasurementsPOMTemplateGroup] 
(
	[POMTempGroupID] ASC,
	[SizeClassId] ASC
)
INCLUDE ( [SizeRangeId],
[Relative],
[Negative],
[Metric]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pGRMeasurementsPOMTemplateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMTemplateItem]') AND name = N'IX_pGRMeasurementsPOMTemplateItem_POMTempGroupID')
DROP INDEX [IX_pGRMeasurementsPOMTemplateItem_POMTempGroupID] ON [dbo].[pGRMeasurementsPOMTemplateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pGRMeasurementsPOMTemplateItem_POMTempGroupID] ON [dbo].[pGRMeasurementsPOMTemplateItem] 
(
	[POMTempGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pGRMeasurementsPOMTemplate ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMTemplate]') AND name = N'IX_pGRMeasurementsPOMTemplate_POMTempGroupID')
DROP INDEX [IX_pGRMeasurementsPOMTemplate_POMTempGroupID] ON [dbo].[pGRMeasurementsPOMTemplate] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pGRMeasurementsPOMTemplate_POMTempGroupID] ON [dbo].[pGRMeasurementsPOMTemplate] 
(
	[POMTempGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pNBOLMachineType ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLMachineType]') AND name = N'IX_MachineClassID')
DROP INDEX [IX_MachineClassID] ON [dbo].[pNBOLMachineType] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_MachineClassID] ON [dbo].[pNBOLMachineType] 
(
	[MachineClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pNBOLOpToMacro ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLOpToMacro]') AND name = N'IX_pNBOLOpToMacro_MacroID')
DROP INDEX [IX_pNBOLOpToMacro_MacroID] ON [dbo].[pNBOLOpToMacro] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pNBOLOpToMacro_MacroID] ON [dbo].[pNBOLOpToMacro] 
(
	[MacroID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pFlashCostDutyItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pFlashCostDutyItem]') AND name = N'IX_pFlashCostDutyItem_FlashCostDutyID')
DROP INDEX [IX_pFlashCostDutyItem_FlashCostDutyID] ON [dbo].[pFlashCostDutyItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pFlashCostDutyItem_FlashCostDutyID] ON [dbo].[pFlashCostDutyItem] 
(
	[FlashCostDutyID] ASC,
	[StyleCategoryID] ASC
)
INCLUDE ( [SizeClassID],
[CostDutyPercent]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** pTradePartnerVendorRateItem ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTradePartnerVendorRateItem]') AND name = N'IX_pTradePartnerVendorRateItem_TradePartnerVendorRateID')
DROP INDEX [IX_pTradePartnerVendorRateItem_TradePartnerVendorRateID] ON [dbo].[pTradePartnerVendorRateItem] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTradePartnerVendorRateItem_TradePartnerVendorRateID] ON [dbo].[pTradePartnerVendorRateItem] 
(
	[TradePartnerVendorRateID] ASC,
	[StyleCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09056', GetDate())
GO
