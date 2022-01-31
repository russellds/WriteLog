$classes = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Classes/*.ps1') -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Functions/Private/*.ps1') -Recurse -ErrorAction Stop)
$public = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Functions/Public/*.ps1') -Recurse -ErrorAction Stop)

foreach ($import in @($classes + $private + $public)) {
    try {
        . $import.FullName
    } catch {
        throw "Unable to dot source [$( $import.FullName )]"
    }
}

Export-ModuleMember -Function $public.BaseName
