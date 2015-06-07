IF OBJECT_ID(N'[dbo].[spx_ConsumptionLabor_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_ConsumptionLabor_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ConsumptionLabor_INSERT]
	@SizeClass NVARCHAR(400)
AS
BEGIN
	INSERT INTO sConsumptionLabor
		(
		SizeClass
		, StyleCategoryID
		)
		SELECT
			sic.Custom
			, stc.StyleCategoryid
		FROM
			pSizeClass sic
			, pStyleCategory stc
		WHERE
			sic.custom = @SizeClass
			AND (SELECT COUNT (*) FROM sConsumptionLabor WHERE SizeClass=sic.custom AND StyleCategoryID=stc.StyleCategoryid)=0
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09523', GetDate())
GO
