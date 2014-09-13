IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialPending_Linked_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialPending_Linked_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_StyleMaterialPending_Linked_INSERT]
(
	@StyleMaterialID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@CreatedDate datetime,
	@CreatedBy nvarchar(200)
)

AS 

SET NOCOUNT ON

/************************/
/*Declare variables.	*/
/************************/
DECLARE @StyleMaterialID_Param UNIQUEIDENTIFIER		--Keep a copy of the original parameter value.
DECLARE @StyleID_Param UNIQUEIDENTIFIER				--Keep a copy of the original parameter value.
DECLARE @StyleSet_Param INT							--Keep a copy of the original parameter value.


DECLARE @StyleLinkID UNIQUEIDENTIFIER
DECLARE @StyleMaterialLinkID UNIQUEIDENTIFIER
DECLARE @TotalCount INT
DECLARE @RowCounter INT


/************************************************/
/*Save a copy of the original parameter values.	*/
/************************************************/
SET @StyleID_Param = @StyleID
SET @StyleSet_Param = @StyleSet
SET @StyleMaterialID_Param = @StyleMaterialID
SET @StyleMaterialLinkID = NEWID()


/************************/
/*Create temp table.	*/
/************************/
CREATE TABLE dbo.#temp_Linked
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,StyleLinkID UNIQUEIDENTIFIER
	,StyleSet INT
	,StyleMaterialID UNIQUEIDENTIFIER
	,StyleMaterialLinkID UNIQUEIDENTIFIER
	)  ON [PRIMARY]


/*
ALTER TABLE dbo.#temp_Linked ADD CONSTRAINT
	PK_#temp_Linked PRIMARY KEY CLUSTERED 
	(
	TableRow
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
*/


/****************************************************/
/*Check to see if the Style is Multi-Cloth linked.	*/
/****************************************************/
/*Get the 'StyleLinkID' of the calling Style.*/
SELECT @StyleLinkID = StyleLinkID
FROM pStyleHeader
WHERE StyleID = @StyleID_Param


/********************************************************************/
/*See if there are other Multi-Cloth linked Styles with this one.	*/
/********************************************************************/
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000')	--Style is not Multi-Cloth linked.
	BEGIN
		/*Execute original procedure with original parameters.*/
		EXEC spx_StyleMaterialPending_INSERT
			@StyleMaterialID_Param
			,@StyleID_Param
			,@StyleSet_Param
			,@CreatedDate
			,@CreatedBy
	END
ELSE	--Style is Multi-Cloth linked.
	BEGIN
		/*Put a copy of the original Style in the temp table first.*/
		INSERT INTO #temp_Linked(
			StyleID
			,StyleLinkID
			,StyleSet
			,StyleMaterialID
			,StyleMaterialLinkID)
		SELECT
			@StyleID_Param AS StyleID
			,@StyleLinkID
			,@StyleSet_Param AS StyleSet
			,@StyleMaterialID_Param AS StyleMaterialID
			,@StyleMaterialLinkID 


		/*Get the other Styles that are Multi-Cloth linked to this one.*/
		INSERT INTO #temp_Linked(
			StyleID
			,StyleLinkID
			,StyleSet
			,StyleMaterialID
			,StyleMaterialLinkID)
		SELECT
			StyleID
			,StyleLinkID
			,@StyleSet_Param AS StyleSet
			,NEWID() AS StyleMaterialID
			,@StyleMaterialLinkID 
		FROM pStyleHeader
		WHERE StyleLinkID = @StyleLinkID
			AND StyleID <> @StyleID_Param
	END


/********************************************************************************************/
/*Loop through the records to add a copy of the system temp Material for the other Styles.	*/
/********************************************************************************************/
/*Get and set the counts for the Multi-Cloth linked Styles.*/
SELECT @TotalCount = COUNT(*) FROM #temp_Linked
SET @RowCounter = 1


/*Get the 'StyleID' for each of the Multi-Cloth linked Styles.*/
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		/*Clear variables.*/
		SET @StyleMaterialID = NULL
		SET @StyleID = NULL
		SET @StyleSet = NULL
		SET @StyleMaterialLinkID = NULL


		/*Get the 'StyleMaterialID' and 'StyleID' for the temp Material copy.*/
		SELECT @StyleMaterialID = StyleMaterialID
			,@StyleID = StyleID
			,@StyleSet = StyleSet
			,@StyleMaterialLinkID = StyleMaterialLinkID 
		FROM #temp_Linked
		WHERE TableRow = @RowCounter


		/*Check to make sure that the Style you're looking at is not the original.*/
		IF(@StyleMaterialID <> @StyleMaterialID_Param AND @StyleID <> @StyleID_Param)
			BEGIN
				/*Add a copy of the temp Material to the system temp table, but with the new 'StyleMaterialID' and 'StyleID' values.*/
				INSERT INTO pStyleMaterialTemp(
					[StyleMaterialID]
					,[MainMaterial]
					,[Development]
					,[MiscColor]
					,[StyleSet]
					,[StyleID]
					,[UOM]
					,[Qty]
					,[MaterialPrice]
					,[Ext]
					,[MaterialSize]
					,[MaterialID]
					,[MaterialPlacement]
					,[MaterialPlacementCode]
					,[MaterialPlacementDetail]
					,[MaterialImageID]
					,[MaterialImageVersion]
					,[NoColorMatch]
					,[SupplierID]
					,[ComponentTypeID]
					,[MaterialType]
					,[MaterialNo]
					,[MaterialName]
					,[A]
					,[B]
					,[C]
					,[D]
					,[E]
					,[F]
					,[G]
					,[H]
					,[I]
					,[J]
					,[K]
					,[L]
					,[M]
					,[N]
					,[O]
					,[P]
					,[Q]
					,[R]
					,[S]
					,[T]
					,[U]
					,[V]
					,[W]
					,[X]
					,[Y]
					,[Z]
					,[Source]
					,[Notes]
					,[Placement]
					,[VendorPrice]
					,[VolumePrice]
					,[VolumePriceMinimum]
					,[VendorProductionMin]
					,[VendorProductionLeadTime]
					,[DetailYesNo]
					,[ImageType]
					,[height]
					,[width]
					,[CDate]
					,[CUser]
					,[MDate]
					,[MUser]
					,[MChange]
					,[SChange]
					,[DChange]
					,[CChange]
					,[Action]
					,[ColorPlacement]
					,[Artwork]
					,[License]
					,[Colorway]
					,[MaterialPackLabelGroupID]
					,[TradePartnerID]
					,[TradePartnerVendorID]
					,[MaterialBOM]
					,[MaterialLining]
					,[MaterialLinked]
					,[MaterialTrack]
					,[MaterialDimension]
					,[MaterialSort]
					,[MaterialSizeID]
					,[StyleMaterialLinkID]
				)
				SELECT
					@StyleMaterialID AS [StyleMaterialID]
					,[MainMaterial]
					,[Development]
					,[MiscColor]
					,[StyleSet]
					,@StyleID AS [StyleID]
					,[UOM]
					,[Qty]
					,[MaterialPrice]
					,[Ext]
					,[MaterialSize]
					,[MaterialID]
					,[MaterialPlacement]
					,[MaterialPlacementCode]
					,[MaterialPlacementDetail]
					,[MaterialImageID]
					,[MaterialImageVersion]
					,[NoColorMatch]
					,[SupplierID]
					,[ComponentTypeID]
					,[MaterialType]
					,[MaterialNo]
					,[MaterialName]
					,[A]
					,[B]
					,[C]
					,[D]
					,[E]
					,[F]
					,[G]
					,[H]
					,[I]
					,[J]
					,[K]
					,[L]
					,[M]
					,[N]
					,[O]
					,[P]
					,[Q]
					,[R]
					,[S]
					,[T]
					,[U]
					,[V]
					,[W]
					,[X]
					,[Y]
					,[Z]
					,[Source]
					,[Notes]
					,[Placement]
					,[VendorPrice]
					,[VolumePrice]
					,[VolumePriceMinimum]
					,[VendorProductionMin]
					,[VendorProductionLeadTime]
					,[DetailYesNo]
					,[ImageType]
					,[height]
					,[width]
					,[CDate]
					,[CUser]
					,[MDate]
					,[MUser]
					,[MChange]
					,[SChange]
					,[DChange]
					,[CChange]
					,[Action]
					,[ColorPlacement]
					,[Artwork]
					,[License]
					,[Colorway]
					,[MaterialPackLabelGroupID]
					,[TradePartnerID]
					,[TradePartnerVendorID]
					,[MaterialBOM]
					,[MaterialLining]
					,[MaterialLinked]
					,[MaterialTrack]
					,[MaterialDimension]
					,[MaterialSort]
					,[MaterialSizeID]
					,@StyleMaterialLinkID 
				FROM pStyleMaterialTemp
				WHERE StyleMaterialID = @StyleMaterialID_Param
					AND StyleID = @StyleID_Param
					AND StyleSet = @StyleSet_Param
			END
		ELSE
		BEGIN
			--***
			--** Link original StyleMaterial 
			--***
			UPDATE pStyleMaterialTemp SET StyleMaterialLinkID = @StyleMaterialLinkID 
			WHERE StyleMaterialID = @StyleMaterialID_Param
			AND StyleID = @StyleID_Param
			AND StyleSet = @StyleSet_Param
		
		END 


		/*Up row counter.*/
		SET @RowCounter = @RowCounter + 1
	END


/********************************************************************/
/*Loop through the records to update all Multi-Cloth linked Styles.	*/
/********************************************************************/
/*Get and set the counts for the Multi-Cloth linked Styles.*/
SELECT @TotalCount = COUNT(*) FROM #temp_Linked
SET @RowCounter = 1


/*Get the 'StyleID' for each of the Multi-Cloth linked Styles.*/
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		/*Clear variables.*/
		SET @StyleMaterialID = NULL
		SET @StyleID = NULL
		SET @StyleSet = NULL
		SET @StyleMaterialLinkID = NULL


		/*Get the 'StyleID' for the insert.*/
		SELECT @StyleMaterialID = StyleMaterialID
			,@StyleID = StyleID
			,@StyleSet = StyleSet
			,@StyleMaterialLinkID = StyleMaterialLinkID 
		FROM #temp_Linked
		WHERE TableRow = @RowCounter


		/*Execute the original procedure for another Style.*/
		EXEC spx_StyleMaterialPending_INSERT
			@StyleMaterialID
			,@StyleID
			,@StyleSet
			,@CreatedDate
			,@CreatedBy


		/*Up row counter.*/
		SET @RowCounter = @RowCounter + 1
	END


/********************/
/*Drop temp tables.	*/
/********************/
DROP TABLE #temp_Linked

SET NOCOUNT OFF



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '083', GetDate())
