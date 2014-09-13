IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ConsumptionLabor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ConsumptionLabor_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ConsumptionLabor_INSERT]
	@SizeClass NVARCHAR(200)
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
VALUES ('DB_Version', '5.0.0000', '04624', GetDate())
GO
