/****** Object:  StoredProcedure [dbo].[spx_GetGuidGroupOnName]    Script Date: 02/11/2014 16:12:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetGuidGroupOnName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetGuidGroupOnName]
GO

/****** Object:  StoredProcedure [dbo].[spx_GetGuidGroupOnName]    Script Date: 02/11/2014 16:12:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_GetGuidGroupOnName]
	-- Add the parameters for the stored procedure here
@name nvarchar(200)
AS
BEGIN
	SET NOCOUNT ON;
	select * from uGroup as gr where gr.GroupName = @name	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07658', GetDate())
GO
