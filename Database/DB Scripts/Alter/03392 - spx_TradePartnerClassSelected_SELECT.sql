IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerClassSelected_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerClassSelected_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerClassSelected_SELECT] (
@TradePartnerClass  nvarchar(5)
)
AS
BEGIN

	DECLARE @str nvarchar(max)

	SELECT @str = COALESCE(@str + ', ', '') + StyleCostingType 
	FROM pStyleCostingType
	WHERE power(2, (StyleCostingTypeID - 1)) & CAST (@TradePartnerClass AS INT) <> 0

	SELECT @str AS TradePartnerClassSelected

END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03392', GetDate())

GO	