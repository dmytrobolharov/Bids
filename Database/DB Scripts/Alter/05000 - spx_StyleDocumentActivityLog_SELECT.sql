/****** Object:  StoredProcedure [dbo].[spx_StyleDocumentActivityLog_SELECT]    Script Date: 02/07/2013 17:15:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDocumentActivityLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDocumentActivityLog_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDocumentActivityLog_SELECT]    Script Date: 02/07/2013 17:15:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDocumentActivityLog_SELECT]
(@StyleDocumentId uniqueidentifier)
AS 

SELECT   *  
FROM      pStyleDocumentActivity WITH (NOLOCK)
WHERE     (StyleDocumentID = @StyleDocumentId)
ORDER BY StyleDocumentActivityID DESC

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05000', GetDate())
GO