/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderDescription_SELECT]    Script Date: 06/10/2013 15:24:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderDescription_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeaderDescription_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleHeaderDescription_SELECT]
(@StyleID uniqueidentifier)
AS 

SELECT  StyleID, sh.StyleType, (StyleNo + ' - ' + [Description]) AS StyleHeaderDesc, stt.IsSilhouette
FROM    pStyleHeader sh
LEFT JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
LEFT JOIN pStyleTypeTemplate stt ON st.StyleTypeTemplateID = stt.StyleTypeTemplateID
WHERE   (StyleID = @StyleID)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05831', GetDate())
GO
