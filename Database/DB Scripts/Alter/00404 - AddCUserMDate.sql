ALTER TABLE pConLevel3 DROP CONSTRAINT [DF_pConLevel3_IsActive]
GO
ALTER TABLE pConLevel3 ADD  CONSTRAINT [DF_pConLevel3_Active]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE pConLevel1 DROP CONSTRAINT [DF_pConLevel1_IsActive]
GO
ALTER TABLE pConLevel1 ADD  CONSTRAINT [DF_pConLevel1_Active]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE pConLevel2 DROP CONSTRAINT [DF_pConLevel2_IsActive]
GO
ALTER TABLE pConLevel2 ADD  CONSTRAINT [DF_ppConLevel2_Active]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE pConLevel2 DROP CONSTRAINT [DF_ppConLevel2_Active]
GO
ALTER TABLE pConLevel2 ADD  CONSTRAINT [DF_pConLevel2_Active]  DEFAULT ((1)) FOR [IsActive]
GO
exec sp_RENAME 'pConLevel3.LastUpdated', 'MDate', 'COLUMN'
GO
exec sp_RENAME 'pConLevel3.IsActive', 'Active', 'COLUMN'
GO
ALTER TABLE pConLevel3 ADD MUser NVARCHAR(200) NULL ;
GO
ALTER TABLE pConLevel3 ADD CUser NVARCHAR(200) NULL ;
GO
ALTER TABLE pConLevel3 ADD CDate datetime NULL ;
GO
exec sp_RENAME 'pConLevel1.IsActive', 'Active', 'COLUMN'
GO
exec sp_RENAME 'pConLevel2.IsActive', 'Active', 'COLUMN'
GO