SELECT * INTO #changeTable FROM pChangeTable WHERE 1 = 2 -- copy table structure

INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'3219fd45-becc-df11-af06-005056c00008', N'pMaterial', N'MaterialID', N'MaterialID', N'ChangeLogItem_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000001-c1cc-df11-af06-005056c00008', N'pStyleColorwayItem', N'StyleColorItemID', N'StyleColorItemID', N'ChangeLogItem_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000002-c1cc-df11-af06-005056c00008', N'pStyleColorwaySeasonyear', N'StyleColorwaySeasonYearID', N'StyleColorwaySeasonYearID', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000003-c1cc-df11-af06-005056c00008', N'pStyleColorway', N'StyleColorID', N'StyleColorID', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000004-c1cc-df11-af06-005056c00008', N'pStyleSourcingItem', N'StyleSourcingItemID', N'StyleSourcingItemID', N'ChangeLogItem_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000005-c1cc-df11-af06-005056c00008', N'pStyleQuoteItem', N'StyleQuoteItemID', N'StyleQuoteItemID', N'ChangeLogItem_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000006-c1cc-df11-af06-005056c00008', N'pStyleCostingHeader', N'StyleCostingHeaderID', N'StyleCostingHeaderID', N'ChangeLogItem_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000007-c1cc-df11-af06-005056c00008', N'pLinePlanRange', N'LinePlanRangeID', N'LinePlanRangeID', N'ChangeLogItem_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000008-c1cc-df11-af06-005056c00008', N'pLinePlanShowroomStyleColor', N'LinePlanShowroomStyleColorID', N'LinePlanShowroomStyleColorID', N'ChangeLogItem_ShowroomStyleColor_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000009-c1cc-df11-af06-005056c00008', N'pStyleQuoteItem', N'StyleQuoteItemID', N'StyleQuoteItemID', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'00000010-c1cc-df11-af06-005056c00008', N'pMaterial', N'MaterialID', N'MaterialID', N'ChangeLog_Material_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'036f8b4c-c1cc-df11-af06-005056c00008', N'pStyleMaterials', N'StyleMaterialID', N'StyleMaterialID', N'ChangeLog_StyleMaterial_Default.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'aa16faaa-7acd-df11-af06-005056c00008', N'pSampleRequestStyle', N'StyleID', N'StyleID', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'ba16faaa-7acd-df11-af06-005056c00008', N'pSampleRequestWorkflow', N'SampleRequestWorkflowID', N'SampleRequestWorkflowID', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'd612faae-7acd-df11-af06-005056c00008', N'pStyleHeader', N'StyleID', N'StyleID', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'dd12faae-7acd-df11-af06-005056c00008', N'pStyleDevelopment', N'StyleDevelopmentID', N'StyleDevelopmentID', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'd616faae-7acd-df11-af06-005056c00008', N'pStyleCare', N'StyleCareId', N'StyleCareId', N'ChangeLogItem_Advanced.xml')
INSERT #changeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES (N'd612faae-7acd-df11-af06-005056c00009', N'pStyleDetail', N'StyleID', N'StyleID', N'ChangeLogItem_Advanced.xml')
GO

-- update existing records
UPDATE pChangeTable 
SET [ChangeTableName] = t.[ChangeTableName],
	[ChangeTableFieldName] = t.[ChangeTableFieldName],
	[ChangeTablePKName] = t.[ChangeTablePKName],
	[ChangeTableXML] = t.[ChangeTableXML]
FROM #changeTable t WHERE t.ChangeTableID = pChangeTable.ChangeTableID
GO

-- insert new records
INSERT INTO pChangeTable([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML])
SELECT [ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]
FROM #changeTable WHERE ChangeTableID NOT IN (SELECT ChangeTableID FROM pChangeTable)
GO

DROP TABLE #changeTable
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03731', GetDate())
GO
