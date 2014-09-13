IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleOwnerGroup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleOwnerGroup_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleOwnerGroup_SELECT]
(
@StyleID nvarchar(50),
@StyleSet int
)
AS 

SELECT OwnerGroup  FROM pStyleHeader WITH (NOLOCK) where StyleID=@StyleID and 
StyleSet=@StyleSet 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03207'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03207', GetDate())
END

GO	