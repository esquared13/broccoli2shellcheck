# broccoli2shellcheck
# script to check versions of google brotli, python brotli, and node.js on windows server

write-output "welcome to broccoli2shellcheck"
write-output "created by e.e., 10-28-26"
write-output "see https://broccoli2shell.com/#other for more information"
# write-output "modified by name, date"

write-output "please enter your server credentials."
$userCredential = get-credential

# add the fqdn of each server in this array
$servers = @(
    'serverName1', 'serverName2', 'serverName3'
    )

# check each server using a foreach loop
foreach ($server in $servers) {
    write-output "results for $server"
    enter-pssession -ComputerName "$server" -Credential $userCredential
    get-item ([psobject].Assembly.Location -replace 'System.Management.Automation\.dll$', 'System.IO.Compression.Brotli.dll') | Select-Object -ExpandProperty VersionInfo -ErrorAction SilentlyContinue # check version of Brotli running
    dotnet --list-runtimes 
    node --version 
    pip show brotlicffi 
    Exit-PSSession
}

# clean up the userCredential variable
$userCredential.Password.Dispose()