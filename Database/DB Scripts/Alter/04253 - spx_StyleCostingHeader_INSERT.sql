/****** Object:  StoredProcedure [dbo].[spx_StyleCostingHeader_INSERT]    Script Date: 10/26/2012 18:15:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingHeader_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingHeader_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleCostingHeader_INSERT]    Script Date: 10/26/2012 18:15:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingHeader_INSERT](
	@StyleID UNIQUEIDENTIFIER
	,@ModifiedBy VARCHAR(200)
	,@ModifiedDate DATETIME
	,@StyleSeasonYearID UNIQUEIDENTIFIER
	,@StyleCostingHeaderID UNIQUEIDENTIFIER OUTPUT
)

AS 

BEGIN
/************************/
/*Declare variables.	*/
/************************/
DECLARE @Count INT


/********************************************************************/
/*Check to see if there is already a 'pStyleCostingHeader' record.	*/
/********************************************************************/
IF(@StyleSeasonYearID IS NULL)
	SELECT @Count = COUNT(*) FROM pStyleCostingHeader WHERE StyleID = @StyleID
ELSE
	SELECT @Count = COUNT(*) FROM pStyleCostingHeader WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID


/********************************************************************************/
/*INSERT the pStyleCostingHeader record for the Style, if one does not exist.	*/
/********************************************************************************/
IF(@Count = 0)
	BEGIN
		INSERT INTO pStyleCostingHeader(StyleID, CUser, MUser, CDate, MDate, StyleSeasonYearID)
		VALUES(@StyleID, @ModifiedBy, @ModifiedBy, @ModifiedDate, @ModifiedDate, @StyleSeasonYearID)
	END

-- Returning value of costing header ID
IF(@StyleSeasonYearID IS NULL)
	SELECT @StyleCostingHeaderID = StyleCostingHeaderID FROM pStyleCostingHeader WHERE StyleID = @StyleID
ELSE
	SELECT @StyleCostingHeaderID = StyleCostingHeaderID FROM pStyleCostingHeader WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID
RETURN

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04253', GetDate())
GO
