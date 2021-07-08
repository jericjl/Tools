function AddVpnRoute {

    foreach($vpn_name in (Get-VpnConnection).Name){
            #Check if VPN Name US-VPN exist
            if ($vpn_name.Contains("US-VPN")) {
              
                
                foreach($us_route in $UsVpnRoutes){
                    #Add route if VPN name exist 
                    #$us_route
                    Add-VpnConnectionRoute -ConnectionName $vpn_name -DestinationPrefix $us_route -PassThru
                }
            } #if
            #Check if VPN Name PH-VPN exist
            elseif ($vpn_name.Contains("PH-VPN")) {
                 
                foreach($ph_route in $PhVpnRoutes ){
                    #Add route if VPN name exist    
                    #$ph_route
                    Add-VpnConnectionRoute -ConnectionName $vpn_name -DestinationPrefix $ph_route -PassThru    
                }
            
            } #elseif
            else {
                #Do nothing
            } #else
        
    } # End of foreach VPN name Checking

}#End of function AddVpnRoute


    # Add routing prefix here inside the ()
    # Use comma , when adding network prefix
$UsVpnRoutes = (
    "1.1.1.1/32","4.4.2.2/32" #This is just an example
    )

    # Add routing prefix here inside the ()
    # Use comma , when adding network prefix
$PhVpnRoutes = (
    "1.1.1.1/32","4.4.2.2/32" #This is just an example
    )

AddVpnRoute $UsVpnRoutes $PhVpnRoutes

