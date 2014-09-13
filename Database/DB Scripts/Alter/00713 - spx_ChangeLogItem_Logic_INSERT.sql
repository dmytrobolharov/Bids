IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_Logic_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeLogItem_Logic_INSERT]
GO

CREATE PROCEDURE spx_ChangeLogItem_Logic_INSERT (
	@ChangeLogItemID UNIQUEIDENTIFIER
)
AS 


DECLARE 
	@ChangeTableID UNIQUEIDENTIFIER,
	@ChangeTransTypeID INT,
	@ChangeTablePKID NVARCHAR(40)


SELECT @ChangeTableID=c.ChangeTableID, @ChangeTransTypeID=b.ChangeTransTypeID,
@ChangeTablePKID=ChangeTablePKID
FROM dbo.pChangeLogItem a
	INNER JOIN dbo.pChangeTransaction b ON a.ChangeTransID = b.ChangeTransID
	INNER JOIN dbo.pChangeLog c ON c.ChangeLogID =  a.ChangeLogID
WHERE a.ChangeLogItemID = @ChangeLogItemID



IF @ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00008' --pStyleMaterials
--AND (@ChangeTablePKID = 0  OR @ChangeTablePKID = 1 OR @ChangeTablePKID = 2)  -- Update and Add
BEGIN

	DECLARE 
		@Custom_SMat_Name NVARCHAR(200),
		@Custom_SMat_No NVARCHAR(200),
		@Custom_SMat_Type NVARCHAR(200)

	SELECT @Custom_SMat_Name = a.MaterialName, @Custom_SMat_No = a.MaterialNo, 
	@Custom_SMat_Type = b.ComponentDescription
	FROM dbo.pStyleMaterials a WITH (NOLOCK)
		INNER JOIN dbo.pComponentType b WITH (NOLOCK) ON a.MaterialType =  b.ComponentTypeID
	WHERE a.StyleMaterialID = @ChangeTablePKID

	UPDATE pChangeLogItem 
	SET Custom_SMat_Name = @Custom_SMat_Name , Custom_SMat_No = @Custom_SMat_No,
	Custom_SMat_Type = @Custom_SMat_Type
	WHERE ChangeLogItemID = @ChangeLogItemID

END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '713', GetDate())
GO
