-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMMaterial_SELECT]    Script Date: 12/18/2011 18:58:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMMaterial_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMMaterial_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMMaterial_SELECT]    Script Date: 12/18/2011 18:58:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMMaterial_SELECT] 
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@TeamID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet nvarchar(5) = '1')
AS

DECLARE  @sql varchar(8000), @selectwhere varchar(8000), @delim varchar(1), @select varchar(8000), @duedate varchar(100), @recdate varchar(100), @revdate varchar(100), @status varchar(100), @pivot varchar(100), @table varchar(100)

DECLARE @subdate VARCHAR (100) 


SET NOCOUNT ON
SET ANSI_WARNINGS OFF


/*Begin: Script to automatically insert Materials into Material Sample Requests.*/
DECLARE @ComponentType varchar(4)


IF (@SampleWorkflowID = '25A') --License
	BEGIN

		INSERT INTO pSampleRequestMaterialBOM
		      (SampleRequestTradeID, SampleRequestWorkflowID, Submit, StartDate, DueDate, EndDate, Status, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet,
		       TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, 
		      MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		      ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, 
		      VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, 
		      MUser, MChange, SChange, DChange, CChange, [Action], ColorPlacement, Artwork, License, Colorway)
		SELECT     pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.Submit, 
		      pSampleRequestWorkflow.StartDate, pSampleRequestWorkflow.DueDate, pSampleRequestWorkflow.EndDate, pSampleRequestWorkflow.Status, 
		      pSampleRequestWorkflow.SampleWorkflowID, pSampleRequestWorkflow.StyleID, pSampleRequestWorkflow.ItemDim1Id,pSampleRequestWorkflow.ItemDim2Id,pSampleRequestWorkflow.ItemDim3Id,
		      pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.TradePartnerVendorID, 
		      pStyleMaterials.StyleMaterialID, pStyleMaterials.MainMaterial, pStyleMaterials.Development, pStyleMaterials.MiscColor, pStyleMaterials.UOM, 
		      pStyleMaterials.Qty, pStyleMaterials.MaterialPrice, pStyleMaterials.Ext, pStyleMaterials.MaterialSize, pStyleMaterials.MaterialID, 
		      pStyleMaterials.MaterialPlacement, pStyleMaterials.MaterialPlacementCode, pStyleMaterials.MaterialPlacementDetail, 
		      pStyleMaterials.MaterialImageID, pStyleMaterials.MaterialImageVersion, pStyleMaterials.NoColorMatch, pStyleMaterials.SupplierID, 
		      pStyleMaterials.ComponentTypeID, pStyleMaterials.MaterialType, pStyleMaterials.MaterialNo, pStyleMaterials.MaterialName, pStyleMaterials.A, 
		      pStyleMaterials.B, pStyleMaterials.C, pStyleMaterials.D, pStyleMaterials.E, pStyleMaterials.F, pStyleMaterials.G, pStyleMaterials.H, pStyleMaterials.I, 
		      pStyleMaterials.J, pStyleMaterials.K, pStyleMaterials.L, pStyleMaterials.M, pStyleMaterials.N, pStyleMaterials.O, pStyleMaterials.P, 
		      pStyleMaterials.Q, pStyleMaterials.R, pStyleMaterials.S,  pStyleMaterials.T, pStyleMaterials.U, pStyleMaterials.V, pStyleMaterials.W, pStyleMaterials.X, pStyleMaterials.Y, pStyleMaterials.Z , 
	   	      pStyleMaterials.Source, pStyleMaterials.Notes, pStyleMaterials.Placement, 
		      pStyleMaterials.VendorPrice, pStyleMaterials.VolumePrice, pStyleMaterials.VolumePriceMinimum, pStyleMaterials.VendorProductionMin, 
		      pStyleMaterials.VendorProductionLeadTime, pStyleMaterials.DetailYesNo, pStyleMaterials.ImageType, pStyleMaterials.height, pStyleMaterials.width, 
		      pStyleMaterials.CDate, pStyleMaterials.CUser, pStyleMaterials.MDate, pStyleMaterials.MUser, pStyleMaterials.MChange, pStyleMaterials.SChange, 
		      pStyleMaterials.DChange, pStyleMaterials.CChange, pStyleMaterials.[Action], pStyleMaterials.ColorPlacement, pStyleMaterials.Artwork, 
		      pStyleMaterials.License, pStyleMaterials.Colorway
		FROM  pStyleBOM pStyleMaterials WITH (NOLOCK) INNER JOIN pSampleRequestWorkflowBOM  pSampleRequestWorkflow WITH (NOLOCK) ON pStyleMaterials.StyleID = pSampleRequestWorkflow.StyleID AND 
		      pStyleMaterials.StyleSet = pSampleRequestWorkflow.StyleSet
		WHERE pStyleMaterials.StyleId = @StyleID AND pStyleMaterials.StyleSet = @StyleSet AND pStyleMaterials.MaterialTrack = 1 AND
			  pSampleRequestWorkflow.SampleRequestWorkflowID = @SampleRequestWorkflowID AND
			  (pStyleMaterials.StyleMaterialID NOT IN(SELECT StyleMaterialID FROM pSampleRequestMaterial WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID)) AND
			  pStyleMaterials.License = 1

	END
ELSE IF (@SampleWorkflowID = '27A') --Artwork
	BEGIN


		INSERT INTO pSampleRequestMaterialBOM
		      (SampleRequestTradeID, SampleRequestWorkflowID, Submit, StartDate, DueDate, EndDate, Status, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet,
		       TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, 
		      MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		      ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z , Source, Notes, Placement, VendorPrice, 
		      VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, 
		      MUser, MChange, SChange, DChange, CChange, [Action], ColorPlacement, Artwork, License, Colorway)
		SELECT     pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.Submit, 
		      pSampleRequestWorkflow.StartDate, pSampleRequestWorkflow.DueDate, pSampleRequestWorkflow.EndDate, pSampleRequestWorkflow.Status, 
		      pSampleRequestWorkflow.SampleWorkflowID, pSampleRequestWorkflow.StyleID, pSampleRequestWorkflow.ItemDim1Id, pSampleRequestWorkflow.ItemDim2Id,pSampleRequestWorkflow.ItemDim3Id,
		      pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.TradePartnerVendorID, 
		      pStyleMaterials.StyleMaterialID, pStyleMaterials.MainMaterial, pStyleMaterials.Development, pStyleMaterials.MiscColor, pStyleMaterials.UOM, 
		      pStyleMaterials.Qty, pStyleMaterials.MaterialPrice, pStyleMaterials.Ext, pStyleMaterials.MaterialSize, pStyleMaterials.MaterialID, 
		      pStyleMaterials.MaterialPlacement, pStyleMaterials.MaterialPlacementCode, pStyleMaterials.MaterialPlacementDetail, 
		      pStyleMaterials.MaterialImageID, pStyleMaterials.MaterialImageVersion, pStyleMaterials.NoColorMatch, pStyleMaterials.SupplierID, 
		      pStyleMaterials.ComponentTypeID, pStyleMaterials.MaterialType, pStyleMaterials.MaterialNo, pStyleMaterials.MaterialName, pStyleMaterials.A, 
		      pStyleMaterials.B, pStyleMaterials.C, pStyleMaterials.D, pStyleMaterials.E, pStyleMaterials.F, pStyleMaterials.G, pStyleMaterials.H, pStyleMaterials.I, 
		      pStyleMaterials.J, pStyleMaterials.K, pStyleMaterials.L, pStyleMaterials.M, pStyleMaterials.N, pStyleMaterials.O, pStyleMaterials.P, 
		      pStyleMaterials.Q, pStyleMaterials.R, pStyleMaterials.S,  pStyleMaterials.T, pStyleMaterials.U, pStyleMaterials.V, pStyleMaterials.W, pStyleMaterials.X, pStyleMaterials.Y, pStyleMaterials.Z ,
   		     pStyleMaterials.Source, pStyleMaterials.Notes, pStyleMaterials.Placement, 
		      pStyleMaterials.VendorPrice, pStyleMaterials.VolumePrice, pStyleMaterials.VolumePriceMinimum, pStyleMaterials.VendorProductionMin, 
		      pStyleMaterials.VendorProductionLeadTime, pStyleMaterials.DetailYesNo, pStyleMaterials.ImageType, pStyleMaterials.height, pStyleMaterials.width, 
		      pStyleMaterials.CDate, pStyleMaterials.CUser, pStyleMaterials.MDate, pStyleMaterials.MUser, pStyleMaterials.MChange, pStyleMaterials.SChange, 
		      pStyleMaterials.DChange, pStyleMaterials.CChange, pStyleMaterials.[Action], pStyleMaterials.ColorPlacement, pStyleMaterials.Artwork, 
		      pStyleMaterials.License, pStyleMaterials.Colorway
		FROM  pStyleBOM pStyleMaterials WITH (NOLOCK) INNER JOIN pSampleRequestWorkflowBOM  pSampleRequestWorkflow WITH (NOLOCK) ON pStyleMaterials.StyleID = pSampleRequestWorkflow.StyleID AND 
		      pStyleMaterials.StyleSet = pSampleRequestWorkflow.StyleSet
		WHERE pStyleMaterials.StyleId = @StyleID AND pStyleMaterials.StyleSet = @StyleSet AND pStyleMaterials.MaterialTrack = 1 AND
			  pSampleRequestWorkflow.SampleRequestWorkflowID = @SampleRequestWorkflowID AND
			  (pStyleMaterials.StyleMaterialID NOT IN(SELECT StyleMaterialID FROM pSampleRequestMaterial WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID)) AND
			  pStyleMaterials.Artwork = 1


	END
--IF (@SampleWorkflowID = '14A' OR @SampleWorkflowID = '24A') --Trimming and Fabrication
ELSE
	BEGIN


		SELECT @ComponentType = GroupID FROM pSampleWorkflow WITH (NOLOCK) WHERE SampleWorkflowID = @SampleWorkflowID
		
		INSERT INTO pSampleRequestMaterialBOM
		      (SampleRequestTradeID, SampleRequestWorkflowID, Submit, StartDate, DueDate, EndDate, Status, SampleWorkflowID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet,
		       TradePartnerVendorID, StyleMaterialID, MainMaterial, Development, MiscColor, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, 
		      MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		      ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z , Source, Notes, Placement, VendorPrice, 
		      VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, 
		      MUser, MChange, SChange, DChange, CChange, [Action], ColorPlacement, Artwork, License, Colorway )
		SELECT     pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.Submit, 
		      pSampleRequestWorkflow.StartDate, pSampleRequestWorkflow.DueDate, pSampleRequestWorkflow.EndDate, pSampleRequestWorkflow.Status, 
		      pSampleRequestWorkflow.SampleWorkflowID, pSampleRequestWorkflow.StyleID, pSampleRequestWorkflow.ItemDim1Id,pSampleRequestWorkflow.ItemDim2Id, pSampleRequestWorkflow.ItemDim3Id,  
		      pSampleRequestWorkflow.StyleSet, pSampleRequestWorkflow.TradePartnerVendorID, 
		      pStyleMaterials.StyleMaterialID, pStyleMaterials.MainMaterial, pStyleMaterials.Development, pStyleMaterials.MiscColor, pStyleMaterials.UOM, 
		      pStyleMaterials.Qty, pStyleMaterials.MaterialPrice, pStyleMaterials.Ext, pStyleMaterials.MaterialSize, pStyleMaterials.MaterialID, 
		      pStyleMaterials.MaterialPlacement, pStyleMaterials.MaterialPlacementCode, pStyleMaterials.MaterialPlacementDetail, 
		      pStyleMaterials.MaterialImageID, pStyleMaterials.MaterialImageVersion, pStyleMaterials.NoColorMatch, pStyleMaterials.SupplierID, 
		      pStyleMaterials.ComponentTypeID, pStyleMaterials.MaterialType, pStyleMaterials.MaterialNo, pStyleMaterials.MaterialName, pStyleMaterials.A, 
		      pStyleMaterials.B, pStyleMaterials.C, pStyleMaterials.D, pStyleMaterials.E, pStyleMaterials.F, pStyleMaterials.G, pStyleMaterials.H, pStyleMaterials.I, 
		      pStyleMaterials.J, pStyleMaterials.K, pStyleMaterials.L, pStyleMaterials.M, pStyleMaterials.N, pStyleMaterials.O, pStyleMaterials.P, 
		      pStyleMaterials.Q, pStyleMaterials.R, pStyleMaterials.S, pStyleMaterials.T, pStyleMaterials.U, pStyleMaterials.V, pStyleMaterials.W, pStyleMaterials.X, pStyleMaterials.Y, pStyleMaterials.Z ,
			pStyleMaterials.Source, pStyleMaterials.Notes, pStyleMaterials.Placement, 
		      pStyleMaterials.VendorPrice, pStyleMaterials.VolumePrice, pStyleMaterials.VolumePriceMinimum, pStyleMaterials.VendorProductionMin, 
		      pStyleMaterials.VendorProductionLeadTime, pStyleMaterials.DetailYesNo, pStyleMaterials.ImageType, pStyleMaterials.height, pStyleMaterials.width, 
		      pStyleMaterials.CDate, pStyleMaterials.CUser, pStyleMaterials.MDate, pStyleMaterials.MUser, pStyleMaterials.MChange, pStyleMaterials.SChange, 
		      pStyleMaterials.DChange, pStyleMaterials.CChange, pStyleMaterials.[Action], pStyleMaterials.ColorPlacement, pStyleMaterials.Artwork, 
		      pStyleMaterials.License, pStyleMaterials.Colorway
		FROM  pStyleBOM  pStyleMaterials WITH (NOLOCK) INNER JOIN pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) ON pStyleMaterials.StyleID = pSampleRequestWorkflow.StyleID AND 
		      pStyleMaterials.StyleSet = pSampleRequestWorkflow.StyleSet
		WHERE pStyleMaterials.StyleId = @StyleID AND pStyleMaterials.StyleSet = @StyleSet AND pStyleMaterials.MaterialTrack = 1 AND
			  (pStyleMaterials.MaterialType IN (SELECT ComponentTypeID FROM pComponentType WITH (NOLOCK) WHERE ComponentType = @ComponentType)) AND
			  (pSampleRequestWorkflow.SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
			  (pStyleMaterials.StyleMaterialID NOT IN(SELECT StyleMaterialID FROM pSampleRequestMaterial WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID))




		declare  @StyleSourcingID  uniqueidentifier 
		DECLARE  @SampleRequestTradeID  uniqueidentifier 


		SELECT @SampleRequestTradeID  =  SampleRequestTradeID  FROM  pSampleRequestMaterialBOM WITH (NOLOCK)  WHERE  SampleRequestWorkflowID = @SampleRequestWorkflowID
		SELECT @StyleSourcingID  =  StyleSourcingID    FROM pSampleRequestBOMTrade WITH (NOLOCK) where SampleRequestTradeID = @SampleRequestTradeID

	

		
		DECLARE @Row  int 
		DECLARE @Count  int 		
		DECLARE @SampleRequestMaterialID  UNIQUEIDENTIFIER 
		DECLARE @StyleMaterialID UNIQUEIDENTIFIER 
		DECLARE @ItemDim1Id UNIQUEIDENTIFIER = null,
				@ItemDim2Id UNIQUEIDENTIFIER = null,
				@ItemDim3Id UNIQUEIDENTIFIER = null 
		
		
		DECLARE @UOM NVARCHAR (50) 
		DECLARE @QTY  NVARCHAR (50) 
		DECLARE @Price money 
		DECLARE  @TradePartnerVendorID UNIQUEIDENTIFIER 
	
	
		if object_id('tempdb..#pSampleRequestMaterialTemp') is not null 
			drop table #pSampleRequestMaterialTemp

		
		CREATE TABLE #pSampleRequestMaterialTemp  (
			RowID  int IDENTITY (1,1) ,
			SampleRequestMaterialID uniqueidentifier, 
			StyleMaterialID  uniqueidentifier ,
			ItemDim1Id UNIQUEIDENTIFIER ,
			ItemDim2Id UNIQUEIDENTIFIER ,
			ItemDim3Id UNIQUEIDENTIFIER
		)
		
		INSERT INTO   #pSampleRequestMaterialTemp ( SampleRequestMaterialID , StyleMaterialID  , ItemDim1Id,ItemDim2Id,ItemDim3Id  ) 
		SELECT SampleRequestMaterialID ,  StyleMaterialID  , ItemDim1Id,ItemDim2Id,ItemDim3Id  FROM  pSampleRequestMaterialBOM WITH (NOLOCK)  
		WHERE SampleRequestTradeID = @SampleRequestTradeID


		
		SET @Row = 1
		SELECT @Count = count(*)  FROM #pSampleRequestMaterialTemp   

		
		IF @Count is null  SET @Count = 0 
		
		--print 'count ='  +  Cast ( @Count  as varchar(50) )
		
		WHILE  @Row <=  @Count 
		BEGIN 
			SET @SampleRequestMaterialID  =  NULL 
			SET @StyleMaterialID  =  NULL 
			SET @UOM = NULL 	
			SET @Qty = NULL 
			SET @Price  = NULL 
	
			SELECT @SampleRequestMaterialID  =  SampleRequestMaterialID  ,  @StyleMaterialID   =  StyleMaterialID  , @ItemDim1Id = ItemDim1Id,@ItemDim2Id = ItemDim2Id,@ItemDim3Id = ItemDim3Id  FROM #pSampleRequestMaterialTemp  WHERE  RowID = @Row 
			
			SELECT @TradePartnerVendorID = TradePartnerVendorID 
			--@UOM = UOM , @Qty = Qty ,  @Price = MaterialPrice , 
			FROM pStyleSourcingItem WITH (NOLOCK) WHERE  StyleSourcingID = @StyleSourcingID AND  StyleMaterialID = @StyleMaterialID
	
			UPDATE pSampleRequestMaterialBOM  SET  
			-- StyleSourcingID = @StyleSourcingID ,  SourcingUOM = @UOM , SourcingQty =  @Qty , SourcingPrice = @Price , 
			SourcingTradePartnerVendorID = @TradePartnerVendorID
			WHERE  SampleRequestMaterialID = @SampleRequestMaterialID  AND  StyleMaterialID   =  @StyleMaterialID 
	
			SET @Row   =  @Row  + 1 
		END 

		DROP TABLE #pSampleRequestMaterialTemp		

	END




/*End: Script to automatically insert Materials into Material Sample Requests.*/


--DROP TABLE ##SampleSpec
/*
SELECT @select = ' SELECT MainMaterial, StyleID, StyleSet, MaterialNo, MaterialName, MaterialSize FROM pSampleRequestMaterial WITH (NOLOCK)
GROUP BY MainMaterial, SampleRequestWorkflowID, SampleWorkflowID, TradePartnerVendorID, StyleID, StyleSet, StyleMaterialID, MaterialNo, MaterialName, MaterialSize '

SELECT @recdate = 'MAX(recdate)'
SELECT @duedate = 'MAX(DueDate)'
SELECT @revdate = 'MAX(EndDate)'


SELECT @pivot = 'Submit'
SELECt @table = 'pSampleRequestMaterial'

SELECT Submit AS pivot INTO ##SampleSpec FROM pSampleRequestMaterial WITH (NOLOCK) WHERE 1=2
INSERT INTO ##SampleSpec SELECT DISTINCT Submit FROM pSampleRequestMaterial WITH (NOLOCK) WHERE Submit Is Not Null AND StyleSet = @StyleSet AND StyleID = @StyleID AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND SampleWorkflowID = @SampleWorkflowID


SELECT @sql='',  @recdate=stuff(@recdate, len(@recdate), 1, ' END)' )
SELECT @sql=@sql + '',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + ''  ,  @revdate= 'MAX (   END)' 

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##SampleSpec' AND column_name='pivot'


SELECT @sql=@sql 
+ '''Due ' + convert(varchar(100), pivot) + ''' = ' + 
stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Rec ' + convert(varchar(100), pivot) + ''' = ' + 
stuff(@recdate,charindex( '(', @recdate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), pivot) + @delim + ' THEN ' ) + ', '
+ '''Apr ' + convert(varchar(100), pivot) + ''' = ' + 
stuff(@revdate,charindex( '(', @revdate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), pivot) + @delim + ' THEN  Case Status  when 2 then EndDate  when 3 then EndDate else  NULL  END   '        ) + ', ' 
FROM ##SampleSpec


if  ( @sql is not null  AND len (@sql ) > 0 )
begin 
	SELECT @sql = left(@sql, len(@sql)-1)
	SELECT @select = stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')
end 



SELECT @selectwhere = ' HAVING  (StyleSet =' + '''' + convert(varchar(5),@StyleSet) + ''')  
AND (StyleID =' + '''' + convert(varchar(50),@StyleID) + ''') 
AND (SampleRequestWorkflowID =' + '''' + convert(varchar(50),@SampleRequestWorkflowID) + ''') 
AND (SampleWorkflowID =' + '''' + convert(varchar(50),@SampleWorkflowID) + ''') 
ORDER BY MainMaterial DESC, MaterialNo, MaterialName '


DROP TABLE ##SampleSpec

print @select + @selectwhere

EXEC (@select + @selectwhere)

*/




SELECT @select = ' SELECT MainMaterial, StyleID, StyleSet, MaterialNo, MaterialName, MaterialSize FROM pSampleRequestMaterialBOM WITH (NOLOCK)
GROUP BY MainMaterial, SampleRequestWorkflowID, SampleWorkflowID, TradePartnerVendorID, StyleID, StyleSet, StyleMaterialID, MaterialNo, MaterialName, MaterialSize '

SELECT @subdate = 'MAX(EndDate)'

SELECT @revdate = 'MAX(EndDate)'



SELECT @pivot = 'Submit'
SELECt @table = 'pSampleRequestMaterial '

SELECT Submit AS tb_pivot INTO ##SampleSpec FROM pSampleRequestMaterialBOM WITH (NOLOCK) WHERE 1=2
INSERT INTO ##SampleSpec SELECT DISTINCT Submit FROM pSampleRequestMaterialBOM WITH (NOLOCK) WHERE Submit Is Not Null AND StyleSet = @StyleSet AND StyleID = @StyleID AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND SampleWorkflowID = @SampleWorkflowID


SELECT @sql=''
SELECT @sql=@sql + '',  @subdate = 'MAX (   END)' 
SELECT @sql=@sql + ''  ,  @revdate = 'MAX (   END)' 


SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##SampleSpec' AND column_name='tb_pivot'


SELECT @sql=@sql 
+ '''Sub ' + convert(varchar(100), tb_pivot) + ''' = ' + 
stuff(@subdate,charindex( '(', @subdate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN  CASE Status  WHEN 1 THEN EndDate ELSE NULL  END   '        ) + ', ' 

+ '''Apr ' + convert(varchar(100), tb_pivot) + ''' = ' + 
stuff(@revdate,charindex( '(', @revdate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), tb_pivot) + @delim + ' THEN  Case Status  when 2 then EndDate  when 3 then EndDate else  NULL  END   '        ) + ', ' 
FROM ##SampleSpec


if  ( @sql is not null  AND len (@sql ) > 0 )
begin 
	SELECT @sql = left(@sql, len(@sql)-1)
	SELECT @select = stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')
end 



SELECT @selectwhere = ' HAVING  (StyleSet =' + '''' + convert(varchar(5),@StyleSet) + ''')  
AND (StyleID =' + '''' + convert(varchar(50),@StyleID) + ''') 
AND (SampleRequestWorkflowID =' + '''' + convert(varchar(50),@SampleRequestWorkflowID) + ''') 
AND (SampleWorkflowID =' + '''' + convert(varchar(50),@SampleWorkflowID) + ''') 
ORDER BY MainMaterial DESC, MaterialNo, MaterialName '


DROP TABLE ##SampleSpec

print @select + @selectwhere

EXEC (@select + @selectwhere)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02442'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02442', GetDate())

END

GO