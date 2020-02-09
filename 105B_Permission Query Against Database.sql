
/* 
This query must be run directly against a NAV Database, not against the reporting database.
However, since dbo.ImportantTables table is only found in the reporting database, you must change the database name in the query
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
FROM dbo.[User Group Permission Set] ugps
    JOIN dbo.[User Group Member] ugm
        ON ugps.[User Group Code] = ugm.[User Group Code]
    JOIN dbo.[User] us
        ON ugm.[User Security ID] = us.[User Security ID]
    JOIN dbo.Permission per
        ON ugps.[Role ID] = per.[Role ID]
    LEFT OUTER JOIN dbo.Object obj
        ON per.[Object Type] = obj.Type
           AND per.[Object ID] = obj.ID
 -- change the database listed here
 LEFT OUTER JOIN NAVReportingTest.dbo.ImportantTables imp
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
