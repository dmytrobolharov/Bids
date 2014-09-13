IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialDepartment_COMMA]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialDepartment_COMMA]
GO

/****** Object:  StoredProcedure [dbo].[fnx_GetMaterialDepartment_COMMA]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnx_GetMaterialDepartment_COMMA](
	@MaterialID uniqueidentifier,
			@MaterialTradePartner VARCHAR(100)
)

RETURNS nvarchar(255)

AS

BEGIN
	DECLARE @CSV nvarchar(255)	
	SELECT @CSV= SUBSTRING((SELECT ',' + MaterialTradePartnerCustom24	FROM pMaterialTradePartner 
	WHERE MaterialId=@MaterialID	ORDER BY MaterialTradePartnerCustom24 FOR XML PATH('')),2,200000)
	RETURN @CSV
END




GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02127'))
BEGIN
	INSERT INTO sVersion
		(
			AppName
			,[Version]
			,LastScriptRun
			,[TimeStamp]
		)
	VALUES     
		(
			'DB_Version'
			,'4.1.3000'
			,'02127'
			,GetDate()
		)
END	
GO


