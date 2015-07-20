IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailGridCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDetailGridCopy_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailGridCopy_INSERT]
(@StyleID uniqueidentifier,
@NewStyleID nvarchar(50),
@CreatedBy nvarchar(50),
@CreatedDate nvarchar(50))
AS 
BEGIN
INSERT INTO pStyleDetailGrid
    (StyleID, StyleSet, StyleDetailCustom, StyleDetailCustom1, StyleDetailCustom2, StyleDetailCustom3, StyleDetailCustom4, StyleDetailCustom5, 
    StyleDetailCustom6, StyleDetailCustom7, StyleDetailCustom8, StyleDetailCustom9, StyleDetailCustom10, StyleDetailCustom11, StyleDetailCustom12, 
    StyleDetailCustom13, StyleDetailCustom14, StyleDetailCustom15, StyleDetailCustom16, StyleDetailCustom17, StyleDetailCustom18, 
    StyleDetailCustom19, StyleDetailCustom20, StyleDetailCustom21, StyleDetailCustom22, StyleDetailCustom23, StyleDetailCustom24, 
    StyleDetailCustom25, CUser, CDate, MUser, MDate, Sort, SizeHomeID)
SELECT     @NewStyleID AS NewStyleID, StyleSet, StyleDetailCustom, StyleDetailCustom1, StyleDetailCustom2, StyleDetailCustom3, StyleDetailCustom4, StyleDetailCustom5, 
    StyleDetailCustom6, StyleDetailCustom7, StyleDetailCustom8, StyleDetailCustom9, StyleDetailCustom10, StyleDetailCustom11, StyleDetailCustom12, 
    StyleDetailCustom13, StyleDetailCustom14, StyleDetailCustom15, StyleDetailCustom16, StyleDetailCustom17, StyleDetailCustom18, 
    StyleDetailCustom19, StyleDetailCustom20, StyleDetailCustom21, StyleDetailCustom22, StyleDetailCustom23, StyleDetailCustom24, 
    StyleDetailCustom25, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, Sort, SizeHomeID
FROM         pStyleDetailGrid WITH (NOLOCK)
WHERE   (StyleID = @StyleID)

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01344', GetDate())
GO




