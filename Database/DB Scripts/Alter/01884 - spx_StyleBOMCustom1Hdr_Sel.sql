IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMCustom1Hdr_Sel]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMCustom1Hdr_Sel]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMCustom1Hdr_Sel]    Script Date: 09/06/2011 12:34:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_StyleBOMCustom1Hdr_Sel] (
@ItemDimTypeId nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@DimLevel Int 
)
AS 	

SELECT CustomID, CustomKey, Custom, Customsort from DCustom1 order by customsort	

	begin		
		if @DimLevel=1
			begin
				SELECT distinct(Custom) as Dim1Name, Customsort, CustomID
				FROM DCustom1 order by customsort
			end
		if @DimLevel=2
			begin
				SELECT distinct(Custom) as Dim2Name, Customsort, CustomID
				FROM DCustom1 order by customsort
			end
		if @DimLevel=3
			begin
				SELECT distinct(Custom) as Dim3Name, Customsort, CustomID
				FROM DCustom1 order by customsort
			end							
	end

	
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01884'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01884', GetDate())
END

GO


