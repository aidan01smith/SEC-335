param($network, $server)

for ($i=0; $i -lt 256; $i++) {
    $resolver = (Resolve-DnsName -DnsOnly ($network + "." + $i) -Server $server -ErrorAction Ignore)
    if ($resolver -NE $null) {
        Write-Host ($network + "." + $i) $resolver.NameHost
    }
}
