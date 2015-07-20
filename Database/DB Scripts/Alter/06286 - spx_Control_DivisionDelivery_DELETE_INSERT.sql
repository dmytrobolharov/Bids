IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_DivisionDelivery_DELETE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_DivisionDelivery_DELETE_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Control_DivisionDelivery_DELETE_INSERT]
	@DivisionID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT
		d.DeliveryID
		, d.DeliveryCode
		, d.DeliveryName
		, d.Active
		, div.CustomID
	INTO #tmpAllDelivery
	FROM pBrandDelivery bd
		INNER JOIN iCustom1 div ON bd.BrandID = div.BrandID
		INNER JOIN pDelivery d ON  bd.DeliveryID = d.DeliveryID
	WHERE div.CustomID = @DivisionID
	
	-- delete
	DELETE FROM pDivisionDelivery
	WHERE DivisionID = @DivisionID AND DeliveryID NOT IN (SELECT DeliveryID FROM #tmpAllDelivery)

	-- insert
	INSERT INTO pDivisionDelivery (DeliveryID, DivisionID)
	SELECT DeliveryID, @DivisionID FROM #tmpAllDelivery
	WHERE DeliveryID NOT IN (SELECT DeliveryID FROM pDivisionDelivery WHERE DivisionID = @DivisionID)
	
	DROP TABLE #tmpAllDelivery
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06286', GetDate())
GO
