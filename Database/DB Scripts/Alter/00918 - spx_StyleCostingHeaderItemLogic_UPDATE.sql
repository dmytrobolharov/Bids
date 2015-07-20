IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingHeaderItemLogic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleCostingHeaderItemLogic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingHeaderItemLogic_UPDATE] (
@StyleCostingHeaderID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME 
)
AS 

DECLARE @StyleID UNIQUEIDENTIFIER,
	@StyleSeasonYearID UNIQUEIDENTIFIER

SELECT @StyleID=StyleID, @StyleSeasonYearID=StyleSeasonYearID
FROM dbo.pStyleCostingHeader  WITH (NOLOCK) WHERE StyleCostingHeaderID = @StyleCostingHeaderID 


EXECUTE spx_StyleCostingHeaderLogic_UPDATE
@StyleID = @StyleID,
@ModifiedBy = @MUser,
@ModifiedDate = @MDate,
@StyleSeasonYearID = @StyleSeasonYearID


