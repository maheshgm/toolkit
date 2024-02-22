# Insert your username and password within quotes
$Username = 'ROLL'
$Password = 'LDAP_PASS'

# Let Invoke-WebRequest do the rest
function Get-IDs {
    $Response = Invoke-WebRequest -Uri 'https://netaccess.iitm.ac.in/account/login' -SessionVariable PHPSESSID -UseBasicParsing
    $PHPSESSID = $Response.Headers['Set-Cookie'].Split('=')[1].Split(';')[0]

    $WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $WebSession.Cookies.SetCookies('https://netaccess.iitm.ac.in/', $PHPSESSID)

    Invoke-WebRequest -Uri 'https://netaccess.iitm.ac.in/account/login' -Method 'POST' -WebSession $WebSession -Body @{
        userLogin = $Username
        userPassword = $Password
        submit = ''
    } -UseBasicParsing | Out-Null

    Invoke-WebRequest -Uri 'https://netaccess.iitm.ac.in/account/approve' -Method 'POST' -WebSession $WebSession -Body @{
        duration = '2'
        approveBtn = ''
    } -UseBasicParsing | Out-Null
}

function Check-Internet {
    $check = (Invoke-WebRequest -Uri 'http://www.google.co.in' -UseBasicParsing).StatusCode
    if ($check -eq 200) {
        Write-Output "netaccess is approved."
    } else {
        Write-Output "something went wrong."
        exit
    }
}

Get-IDs
Check-Internet
