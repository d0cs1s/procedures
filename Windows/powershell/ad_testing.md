# Test de script powershell
## Agir sur l'AD



```powershell
$ad_users = Get-ADUser -Filter * -Properties City,Department

foreach ($user in $ad_users) {
    switch ($user.city) {
        "Quimper"
        {
            Set-ADUser $user.DistinguishedName -description "utilisateur BZH"
        }
        "Angers"
        {
            Set-ADUser $user.DistinguishedName -description "Tech-Niv-3" -Department "Ing-SI"
            Add-ADGroupMember -Identity "Domain Admins" -Members $user.DistinguishedName
        }
        "Rennes"
        {
            Set-ADUser $user.DistinguishedName -manager "JustinMiranda"
        }
    }
}
```
