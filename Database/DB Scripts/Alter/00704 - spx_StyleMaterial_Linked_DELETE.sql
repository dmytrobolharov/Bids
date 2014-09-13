IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterial_Linked_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterial_Linked_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterial_Linked_DELETE](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@MUser nvarchar(200),
	@MDate DATETIME,
	@ChangeTransID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER
)
AS 

--**********************  
--Declare variables.	  
--**********************  
DECLARE @StyleMaterialID_Param UNIQUEIDENTIFIER		--Keep a copy of the original parameter value.
DECLARE @StyleID_Param UNIQUEIDENTIFIER
DECLARE @StyleSet_Param INT
DECLARE @StyleLinkID UNIQUEIDENTIFIER

DECLARE @MainMaterial INT

DECLARE @StyleMaterialLinkID UNIQUEIDENTIFIER			--To find the the same Material in the other Styles.

DECLARE @TotalCount INT
DECLARE @RowCounter INT


--**********************************************  
--Save a copy of the original parameter values.	  
--**********************************************  
SET @StyleMaterialID_Param = @StyleMaterialID
SET @StyleID_Param = @StyleID
SET @StyleSet_Param = @StyleSet


--**********************  
--Create temp table.	  
--**********************  
CREATE TABLE dbo.#temp_Linked
	(
	TableRow int NOT NULL IDENTITY (1, 1)
	,StyleID UNIQUEIDENTIFIER
	,StyleLinkID UNIQUEIDENTIFIER
	,StyleSet INT
	,StyleMaterialID UNIQUEIDENTIFIER
	)  ON [PRIMARY]


--ALTER TABLE dbo.#temp_Linked ADD CONSTRAINT
--	PK_#temp_Linked PRIMARY KEY CLUSTERED 
--	(
--	TableRow
--	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


--**************************************************  
--Check to see if the Style is Multi-Cloth linked.	  
--**************************************************  
--Get the 'MainMaterial' value (and 'StyleID') for checking later on.  
SELECT @MainMaterial = MainMaterial
	,@StyleID = StyleID
	,@StyleSet = StyleSet
FROM pStyleMaterials
WHERE StyleMaterialID = @StyleMaterialID_Param


--Get the 'StyleLinkID' of the calling Style.  
SELECT @StyleLinkID = StyleLinkID
FROM pStyleHeader
WHERE StyleID = @StyleID


--******************************************************************  
--See if there are other Multi-Cloth linked Styles with this one.	  
--******************************************************************  
IF(@StyleLinkID IS NULL OR @StyleLinkID = '00000000-0000-0000-0000-000000000000' OR @MainMaterial = 1)	--Style is not Multi-Cloth linked, or this is a Main Material.
	BEGIN
		--Execute original procedure with original parameters.  
		EXEC spx_StyleMaterial_DELETE 
				@StyleMaterialID = @StyleMaterialID_Param, 
				@ChangeTransID = @ChangeTransID,
				@ChangeTransUserID = @ChangeTransUserID,
				@MUser = @MUser,
				@MDate = @MDate


	END
ELSE	--Style is Multi-Cloth linked and this is not a Main Material.
	BEGIN
		--Clear variables.  
		SET @StyleMaterialLinkID = NULL


		--Get the 'StyleMaterialLinkID' value of the calling Style.  
		SELECT @StyleMaterialLinkID = StyleMaterialLinkID
		FROM pStyleMaterials WITH (NOLOCK)
		WHERE StyleMaterialID = @StyleMaterialID_Param


		--Get all the Styles that are Multi-Cloth linked to this 'StyleLinkID'.  
		INSERT INTO #temp_Linked(
			StyleID
			,StyleLinkID
			,StyleSet)
		SELECT
			StyleID
			,StyleLinkID
			,@StyleSet
		FROM pStyleHeader WITH (NOLOCK)
		WHERE StyleLinkID = @StyleLinkID


		--Get and set the counts for the Multi-Cloth linked Styles.  
		SELECT @TotalCount = COUNT(*) FROM #temp_Linked
		SET @RowCounter = 1


		--Get the 'StyleMaterialID' of the Material for each of the Multi-Cloth linked Styles.  
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				--Clear variables.  
				SET @StyleID = NULL
				SET @StyleSet = NULL
				SET @StyleMaterialID = NULL


				--Get 'StyleID'.  
				SELECT @StyleID = StyleID
					,@StyleSet = StyleSet
				FROM #temp_Linked
				WHERE TableRow = @RowCounter


				--Get the 'StyleMaterialID'.  
				SELECT @StyleMaterialID = StyleMaterialID
				FROM pStyleMaterials WITH (NOLOCK)
				WHERE StyleID = @StyleID
					AND StyleSet = @StyleSet
					AND StyleMaterialLinkID = @StyleMaterialLinkID


				--Update the temp table with the 'StyleMaterialID'.  
				UPDATE #temp_Linked
				SET StyleMaterialID = @StyleMaterialID
				WHERE TableRow = @RowCounter


				--Up row counter.  
				SET @RowCounter = @RowCounter + 1
			END
	END


--******************************************************************  
--Loop through the records to update all Multi-Cloth linked Styles.	  
--******************************************************************  
--Get and set the counts for the Multi-Cloth linked Styles.  
SELECT @TotalCount = COUNT(*) FROM #temp_Linked
SET @RowCounter = 1


--Get the 'StyleID' for each of the Multi-Cloth linked Styles.  
WHILE(@RowCounter <= @TotalCount)
	BEGIN
		--Clear variables.  
		SET @StyleMaterialID = NULL


		--Get the 'StyleID' for the delete.  
		SELECT @StyleMaterialID = StyleMaterialID
		FROM #temp_Linked
		WHERE TableRow = @RowCounter

		--Execute the original procedure for another Style.  
		EXEC spx_StyleMaterial_DELETE 
				@StyleMaterialID = @StyleMaterialID,
				@ChangeTransID = @ChangeTransID,
				@ChangeTransUserID = @ChangeTransUserID,
				@MUser = @MUser,
				@MDate = @MDate
		
		--Up row counter.  
		SET @RowCounter = @RowCounter + 1
	END

--******************  
--Drop temp tables.	  
--******************  
DROP TABLE #temp_Linked



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '704', GetDate())
GO
