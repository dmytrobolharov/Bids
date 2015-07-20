/****** Object:  StoredProcedure [dbo].[spx_StyleDimBOMColorMgmtMaterial_INSERT]    Script Date: 05/16/2013 17:48:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDimBOMColorMgmtMaterial_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDimBOMColorMgmtMaterial_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDimBOMColorMgmtMaterial_INSERT]    Script Date: 05/16/2013 17:48:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleDimBOMColorMgmtMaterial_INSERT](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowItemId UNIQUEIDENTIFIER,
	@WorkflowId UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,	
	@StyleMaterialMiscID UNIQUEIDENTIFIER,
	@DimColor NVARCHAR(2),
	@CreatedDate DATETIME,
	@CreatedBy NVARCHAR(200)	
)

AS 
DECLARE @MaxRow int
DECLARE @MaterialCode NVARCHAR(50)  
DECLARE @StyleBOMDimensionItemID UNIQUEIDENTIFIER 

BEGIN TRY
	BEGIN TRANSACTION

	SELECT @MaxRow = COUNT(Distinct(StyleMaterialID)) FROM pStyleBOMMiscItem WITH (NOLOCK) WHERE StyleMaterialID = @StyleMaterialID
	and StyleBOMDimensionID=@StyleBOMDimensionID

	set @MaxRow=@MaxRow+1
	set @MaterialCode='Combo' + CAST(@MaxRow as nvarchar(4))

	CREATE TABLE #tmpDtlItem (
		Dtl_ID INT IDENTITY (1,1),			
		DimId NVARCHAR(50)			
		)
		
	If @DimColor = '1'
		begin
			insert into #tmpDtlItem (DimId) 
			Select distinct(ItemDim1Id) as DimId FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
			and ItemDim1Id is not null  
		end
	else If @DimColor = '2'
		begin
			insert into #tmpDtlItem (DimId) 
			Select distinct(ItemDim2Id) as DimId FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
			and ItemDim2Id is not null  
		end
	else If @DimColor = '3'
		begin
			insert into #tmpDtlItem (DimId) 
			Select distinct(ItemDim3Id) as DimId FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
			and ItemDim3Id is not null  
		end

		
	INSERT INTO [pStyleBOMMiscItem]
			   ([StyleBOMDimensionID]
			   ,[StyleBOMDimensionItemID]
			   ,[StyleMaterialID]
			   ,StyleMaterialMiscID
			   ,[MaterialNo]
			   ,[MaterialName] 
			   ,SubMaterial                   
			   ,[CDate]
			   ,[CUser]
			   ,[MDate]
			   ,[MUser])
	select @StyleBOMDimensionID , DimId, @StyleMaterialID, @StyleMaterialMiscID, @MaterialCode,
	@MaterialCode, 1, @CreatedDate , @CreatedBy, @CreatedDate, @CreatedBy from #tmpDtlItem 


	drop table #tmpDtlItem

COMMIT TRANSACTION
	select 1 as Success
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	select 0 as Success
END CATCH


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05685', GetDate())
GO
