/****** Object:  StoredProcedure [dbo].[spx_StyleNewCopySizeClass_INSERT]    Script Date: 10/25/2012 11:05:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNewCopySizeClass_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNewCopySizeClass_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleNewCopySizeClass_INSERT]    Script Date: 10/25/2012 11:05:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


/*

Comments:



#01 - Ryan Cabanas - August 12, 2009

	When PI copies a Style, the 'pStyleCostingHeader' and 'pStyleCosting' records are copied

too.  They wanted this.  The problem is that the procedure below 'spx_StyleCostingCopy_INSERT'

does not include the 'StyleSeasonYearID' when it adds the records.  And because this procedure

runs before a new 'pStyleSeasonYear.StyleSeasonYearID' is even created for this new Style, here

at this procedure we're going to have to create that 'pStyleSeasonYear.StyleSeasonYearID' and

then do an UPDATE here to the 'pStyleCostingHeader' and 'pStyleCosting' records that have been

created (without a 'StyleSeasonYearID') by the 'spx_StyleCostingCopy_INSERT' procedure below.

	Because the 'pStyleHeader' Season and Year fields are customized for each client, this will

need to be customized for each client, as well.

	Also, I think that this method will only work for clients that are not using true seasonality.

This only works if they are using one StyleID per Season/Year.

*/





CREATE PROCEDURE [dbo].[spx_StyleNewCopySizeClass_INSERT](

@StyleID UNIQUEIDENTIFIER, 

@NewStyleID UNIQUEIDENTIFIER, 

@CreatedDate DATETIME, 

@CreatedBy NVARCHAR(200),

@AddComments INT,

@SqlStyleHeaderUpdate NVARCHAR(4000), 

@LinePlanItemID NVARCHAR(50) 

)

AS









BEGIN



	DECLARE @SketchID UNIQUEIDENTIFIER

	DECLARE @SketchVersion INT 
	
	DECLARE @SketchBackID UNIQUEIDENTIFIER
	
	DECLARE @SketchBackVersion INT



	SELECT @SketchID = DesignSketchID, @SketchVersion = DesignSketchVersion, 
	
	@SketchBackID = DesignSketchBackID, @SketchBackVersion = DesignSketchBackVersion

	FROM  pStyleHeader WHERE StyleID = @StyleID





	EXEC dbo.spx_StyleHeaderCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID, @DesignSketchID=@SketchID, @DesignSketchBackID = @SketchBackID,

		@DesignSketchVersion=@SketchVersion, @DesignSketchBackVersion = @SketchBackVersion, @StyleVariation=@SketchVersion, @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	

	EXEC(@SqlStyleHeaderUpdate)



	EXEC dbo.spx_StyleWorkflowScheaduleCopy_UPDATE @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy, @CreatedDate=@CreatedDate

	EXEC dbo.spx_StyleSizeClassRangeVariation_UPDATE @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy, @CreatedDate=@CreatedDate

	EXEC spx_StyleDetailGridCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	EXEC spx_StyleDetailVariation_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	EXEC spx_StyleMaterialVariation_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate, @ColorsSelected = 1

	EXEC spx_StyleCareCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	EXEC spx_StyleCostingCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	EXEC spx_StyleQuoteCopy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	EXEC spx_StyleDevelopmentSpecVariation_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate

	EXEC spx_StyleBOL_Copy_INSERT @StyleID=@StyleID, @NewStyleID=@NewStyleID, @CreatedBy=@CreatedBy, @CreatedDate=@CreatedDate



END







--Comment #01

BEGIN

	/*Declare variables.*/

	DECLARE @Season nvarchar(200)

	DECLARE @Year nvarchar(200)

	DECLARE @StyleSeasonYearID uniqueidentifier



	/*Get header information.*/

	SELECT

		@Season = CustomField5

		,@Year = CustomField6

	FROM pStyleHeader

	WHERE StyleID = @NewStyleID



	/*Get 'StyleSeasonYearID'.*/

	SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID

	FROM pStyleSeasonYear

	WHERE StyleID = @NewStyleID

		AND StyleSeason = @Season

		AND StyleYear = @Year

	

	/****************************************************************/

	/*Update 'pStyleCostingHeader' records if there and necessary.	*/

	/****************************************************************/

	BEGIN

		IF(SELECT COUNT(*) FROM pStyleCostingHeader WITH (NOLOCK) WHERE StyleID = @NewStyleID AND (StyleSeasonYearID IS NULL OR StyleSeasonYearID <> @StyleSeasonYearID)) = 1

			BEGIN

				UPDATE pStyleCostingHeader

				SET StyleSeasonYearID = @StyleSeasonYearID

				WHERE StyleID = @NewStyleID

			END

	END



	/************************************************************/

	/*Update 'pStyleCosting' records if there and necessary.	*/

	/************************************************************/

	BEGIN

		/*Declare variables.*/

		DECLARE @TotalCount int

		DECLARE @RowCounter int

		DECLARE @StyleCostingID uniqueidentifier



		/*Create temp table.*/

		CREATE TABLE #tempStyleCosting(

			TableRow int identity(1,1)

			,StyleCostingID uniqueidentifier)



		/*Get 'pStyleCosting' records.*/

		INSERT INTO #tempStyleCosting(StyleCostingID)

		SELECT StyleCostingID

		FROM pStyleCosting

		WHERE StyleID = @NewStyleID

			AND	(StyleSeasonYearID IS NULL

				OR StyleSeasonYearID <> @StyleSeasonYearID)



		/*Get/set counts.*/

		SELECT @TotalCount = COUNT(*) FROM #tempStyleCosting

		SET @RowCounter = 1



		/*Loop.*/

		WHILE(@RowCounter <= @TotalCount)

			BEGIN

				/*Clear variable.*/

				SET @StyleCostingID = NULL



				/*Get values.*/

				SELECT @StyleCostingID = StyleCostingID

				FROM #tempStyleCosting

				WHERE TableRow = @RowCounter



				/*Update 'pStyleCosting' record.*/

				UPDATE pStyleCosting

				SET StyleSeasonYearID = @StyleSeasonYearID

				WHERE StyleCostingID = @StyleCostingID



				/*Up counter.*/

				SET @RowCounter = @RowCounter + 1

			END



		/*Drop temp table.*/

		DROP TABLE #tempStyleCosting

	END

END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04251', GetDate())
GO
