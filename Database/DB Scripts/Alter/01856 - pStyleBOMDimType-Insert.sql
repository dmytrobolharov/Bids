
if not exists (select * from pStyleBOMDimType WHERE DimTypeName = 'Color')
begin
	INSERT INTO [dbo].[pStyleBOMDimType]
           ([DimTypeName]
           ,[DimTypeDesc]
           ,[DimType]
           ,[DimTypePkID]           
           ,[DimTypeTable]
           ,[DimTypeSPX]
           ,[DimTypeHdrSPX]
           ,[DimTypeText]
           ,[DimTypeValue]
           ,[DimTypeFilter]
           ,[Sort]
           )
     VALUES
           ('Color'
           ,'Color'
           ,1
           ,'StyleColorId'           
           ,'pStyleColorway'
           ,'spx_StyleBOMColorways_DimItem_SEL'
           ,'spx_StyleBOMColorwayHdr_Sel'
           ,'StyleColorName'
           ,'StyleColorNo'
           ,'StyleId'
           ,0
           )
 end 
 
if not exists (select * from pStyleBOMDimType WHERE DimTypeName = 'Size')
begin          
INSERT INTO [dbo].[pStyleBOMDimType]
           ([DimTypeName]
           ,[DimTypeDesc]
           ,[DimType]
           ,[DimTypePkID]           
           ,[DimTypeTable]
           ,[DimTypeSPX]
           ,[DimTypeHdrSPX]
           ,[DimTypeText]
           ,[DimTypeValue]
           ,[DimTypeFilter]
           ,[Sort]
           )
     VALUES
           ('Size'
           ,'Size'
           ,2
           ,'SizeRangeGuidId'           
           ,'pGRSizeRange'
           ,'spx_StyleBOMSizeRange_DimItem_sel'
           ,'spx_StyleBOMSizeRangeHdr_sel'
           ,'SizeRange'
           ,'SizerangeGuidId'
           ,'StyleId'
           ,1
           )
 end
 
if not exists (select * from pStyleBOMDimType WHERE DimTypeName = 'Packaging')
begin          
INSERT INTO [dbo].[pStyleBOMDimType]
           ([DimTypeName]
           ,[DimTypeDesc]
           ,[DimType]
           ,[DimTypePkID]           
           ,[DimTypeTable]
           ,[DimTypeSPX]
           ,[DimTypeHdrSPX]
           ,[DimTypeText]
           ,[DimTypeValue]
           ,[DimTypeFilter]
           ,[Sort]
           )
     VALUES
           ('Packaging'
           ,'Packaging'
           ,3
           ,'CustomId'           
           ,'xCustom16'
           ,'spx_StyleBOMCustom_DimItem_Sel'
           ,'spx_StyleBOMCustomHdr_Sel'
           ,'Custom'
           ,'CustomKey'
           ,'ControlPanelId'
           ,2
           )
end


if not exists (select * from pStyleBOMDimType WHERE DimTypeName = 'Alteration')
begin
INSERT INTO [dbo].[pStyleBOMDimType]
           ([DimTypeName]
           ,[DimTypeDesc]
           ,[DimType]
           ,[DimTypePkID]           
           ,[DimTypeTable]
           ,[DimTypeSPX]
           ,[DimTypeHdrSPX]
           ,[DimTypeText]
           ,[DimTypeValue]
           ,[DimTypeFilter]
           ,[Sort]
           )
     VALUES
           ('Alteration'
           ,'Alteration'
           ,4
           ,'CustomId'           
           ,'DCustom1'
           ,'spx_StyleBOMCustom1_DimItem_Sel'
           ,'spx_StyleBOMCustom1Hdr_Sel'
           ,'Custom'
           ,'CustomKey'
           ,'CustomId'
           ,3
           )
end

if not exists (select * from pStyleBOMDimType WHERE DimTypeName = 'Cup Size')
begin
INSERT INTO [dbo].[pStyleBOMDimType]
           ([DimTypeName]
           ,[DimTypeDesc]
           ,[DimType]
           ,[DimTypePkID]           
           ,[DimTypeTable]
           ,[DimTypeSPX]
           ,[DimTypeHdrSPX]
           ,[DimTypeText]
           ,[DimTypeValue]
           ,[DimTypeFilter]
           ,[Sort]
           )
     VALUES
           ('Cup Size'
           ,'Cup Size'
           ,5
           ,'CustomId'           
           ,'DCustom2'
           ,'spx_StyleBOMCustom2_DimItem_Sel'
           ,'spx_StyleBOMCustom2Hdr_Sel'
           ,'Custom'
           ,'CustomKey'
           ,'CustomId'
           ,4
           )
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01856'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01856', GetDate())
	END
	
	GO