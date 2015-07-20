IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRTolerance' and COLUMN_NAME = N'Garment_Cls_ImgGuidId')
       BEGIN
            EXEC sp_rename 'pGRTolerance.Garment_Cls_ImgGuidId', 'ProductClassImageId', 'COLUMN';
       END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '732', GetDate())

GO