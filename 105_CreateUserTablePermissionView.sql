IF OBJECT_ID('dbo.vR3NAV100_UserTablePermission') IS NOT NULL
DROP VIEW dbo.vR3NAV100_UserTablePermission
go
CREATE VIEW  dbo.vR3NAV100_UserTablePermission
as
/* 
Key note:
NAV Permission Values 
0 - No
1 - Yes
2 - Indirect
We only care about 1 - Yes for this purpose'
*/
SELECT DISTINCT
       us.[User Name],
       per.[Object Type],
       per.[Object ID],
       obj.Name,
       MAX(imp.SecurityType) AS SecurityType,
       MAX(   CASE per.[Insert Permission]
                  WHEN 1 THEN
                      'Yes'
					  ELSE ''
              END
          ) AS InsertPermission,
       MAX(   CASE per.[Modify Permission]
                  WHEN 1 THEN
                      'Yes'
                  ELSE
                      ''
              END
          ) AS ModifyPermission,
       MAX(   CASE per.[Delete Permission]
                  WHEN 1 THEN
                      'Yes'
                  ELSE
                      ''
              END
          ) AS DeletePermission
FROM dbo.[vNAV_User Group Permission Set] ugps
    JOIN dbo.[vNAV_User Group Member] ugm
        ON ugps.[User Group Code] = ugm.[User Group Code]
    JOIN dbo.[vNAV_User] us
        ON ugm.[User Security ID] = us.[User Security ID]
    JOIN dbo.vNAV_Permission per
        ON ugps.[Role ID] = per.[Role ID]
    LEFT OUTER JOIN dbo.vNAV_Object obj
        ON per.[Object Type] = obj.Type
           AND per.[Object ID] = obj.ID
 LEFT OUTER JOIN dbo.ImportantTables imp
        ON obj.ID = imp.ID
WHERE us.State = 0
      AND
      (
          per.[Insert Permission] = 1
          OR per.[Modify Permission] = 1
          OR per.[Delete Permission] = 1
      )
      AND ugps.[User Group Code] NOT IN ( 'ALL', 'FOUNDATION' )
GROUP BY us.[User Name],
         per.[Object Type],
         per.[Object ID],
         obj.Name;
