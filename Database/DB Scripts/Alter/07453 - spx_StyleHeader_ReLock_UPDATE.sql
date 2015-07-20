--WI # 24037 : Unlock Button Logic

IF OBJECT_ID ( 'spx_StyleHeader_ReLock_UPDATE', 'P' ) IS NOT NULL
    DROP PROCEDURE spx_StyleHeader_ReLock_UPDATE;
GO


CREATE PROCEDURE [dbo].[spx_StyleHeader_ReLock_UPDATE]
(
	@StyleID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER = NULL,
	@ReLockType NVARCHAR(15) = 'Lock'
)
AS

DECLARE @HeaderLocked INT = 0

IF @ReLockType <> 'UnLock'
BEGIN

	--** Lock the Header based on Style Hierarchy Status
	
	DECLARE @HierarchyStatus NVARCHAR(200)
	DECLARE @StyleTypeID NVARCHAR(200)
	DECLARE @StyleStatus NVARCHAR(50)		
	SELECT @HierarchyStatus = b.Custom,
		   @StyleTypeID = a.StyleType,
		   @StyleStatus = b.CustomKey 
	FROM pStyleHeader a
		LEFT OUTER JOIN xCustom8 b ON a.CustomField3 = b.Custom
	WHERE a.StyleID = @StyleID
	
	IF @StyleStatus IS NULL OR @StyleStatus = ''
	BEGIN
		SET @HeaderLocked = 0
	END 
	ELSE
	BEGIN
		SET @HeaderLocked = @StyleStatus
	END
	
END
ELSE
BEGIN
	SET @HeaderLocked = 0
END

UPDATE pStyleHeader
SET HeaderLocked = @HeaderLocked
WHERE StyleID = @StyleID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07453', GetDate())
GO